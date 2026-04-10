import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'cache_models.dart';
import 'mutation_queue.dart';

// ============================================================================
// SHELF REPOSITORY
// ============================================================================

abstract class ShelfRepository {
  /// Get all shelves for the current user
  Future<List<IsarShelf>> getShelves();

  /// Get tracks in a specific shelf
  Future<List<IsarShelfTrack>> getShelfTracks(String shelfId);

  /// Add track to shelf (with optimistic update)
  /// Returns mutation ID for tracking
  Future<String> addToShelf({
    required String shelfId,
    required String trackId,
    required String trackTitle,
    required String composerName,
    required String sourceName,
  });

  /// Remove track from shelf
  Future<String> removeFromShelf({
    required String shelfId,
    required String trackId,
  });

  /// Rate a track
  Future<String> rateTrack({
    required String trackId,
    required double rating,
  });

  /// Get pending mutations
  Future<List<IsarPendingMutation>> getPendingMutations();

  /// Retry a specific mutation
  Future<void> retryMutation(String mutationId);

  /// Cancel a mutation
  Future<void> cancelMutation(String mutationId);
}

// ============================================================================
// SUPABASE SHELF REPOSITORY
// ============================================================================

class SupabaseShelfRepository implements ShelfRepository {
  SupabaseShelfRepository({
    required Isar isar,
    required SupabaseClient? client,
  })  : _isar = isar,
        _client = client;

  final Isar _isar;
  final SupabaseClient? _client;

  late MutationQueue _mutationQueue;

  /// Initialize the repository (call once at app startup)
  Future<void> initialize() async {
    _mutationQueue = MutationQueue(
      isar: _isar,
      execute: _executeMutation,
      maxRetries: 5,
      maxDelayMs: 30000,
      initialDelayMs: 2000,
    );

    // Start processing pending mutations immediately
    await _mutationQueue.processPending();
  }

  @override
  Future<List<IsarShelf>> getShelves() async {
    // Return cached shelves first
    final cached = await _isar.isarShelves.where().findAll();
    if (cached.isNotEmpty) {
      // Trigger background sync
      _syncShelvesBackground();
      return cached;
    }

    // Fetch from network if cache is empty
    if (_client != null) {
      return _syncShelves();
    }

    return const [];
  }

  @override
  Future<List<IsarShelfTrack>> getShelfTracks(String shelfId) async {
    // Return cached tracks first (Cache-Then-Network)
    final cached = await _isar.isarShelfTracks
        .filter()
        .shelfIdEqualTo(shelfId)
        .findAll();

    if (cached.isNotEmpty) {
      // Trigger background sync
      _syncShelfTracksBackground(shelfId);
      return cached;
    }

    // Fetch from network if cache is empty
    if (_client != null) {
      return _syncShelfTracks(shelfId);
    }

    return const [];
  }

  @override
  Future<String> addToShelf({
    required String shelfId,
    required String trackId,
    required String trackTitle,
    required String composerName,
    required String sourceName,
  }) async {
    // Optimistic update: add to local cache immediately
    final shelfTrack = IsarShelfTrack()
      ..trackId = trackId
      ..shelfId = shelfId
      ..title = trackTitle
      ..composerName = composerName
      ..sourceName = sourceName
      ..addedAtMs = DateTime.now().millisecondsSinceEpoch;

    await _isar.writeTxn(() async {
      await _isar.isarShelfTracks.put(shelfTrack);
    });

    // Queue the actual API mutation
    final payload = jsonEncode({
      'shelfId': shelfId,
      'trackId': trackId,
      'title': trackTitle,
      'composerName': composerName,
      'sourceName': sourceName,
    });

    return _mutationQueue.queue(
      type: MutationType.addToShelf,
      payload: payload,
    );
  }

  @override
  Future<String> removeFromShelf({
    required String shelfId,
    required String trackId,
  }) async {
    // Optimistic update: remove from local cache immediately
    await _isar.writeTxn(() async {
      final toDelete = await _isar.isarShelfTracks
          .filter()
          .shelfIdEqualTo(shelfId)
          .and()
          .trackIdEqualTo(trackId)
          .findAll();

      for (final track in toDelete) {
        await _isar.isarShelfTracks.delete(track.id!);
      }
    });

    // Queue the actual API mutation
    final payload = jsonEncode({
      'shelfId': shelfId,
      'trackId': trackId,
    });

    return _mutationQueue.queue(
      type: MutationType.removeFromShelf,
      payload: payload,
    );
  }

  @override
  Future<String> rateTrack({
    required String trackId,
    required double rating,
  }) async {
    // Optimistic update: store rating in cache
    final isarRating = IsarTrackRating()
      ..trackId = trackId
      ..rating = rating
      ..ratedAtMs = DateTime.now().millisecondsSinceEpoch;

    await _isar.writeTxn(() async {
      // Delete existing rating for this track
      final existing = await _isar.isarTrackRatings
          .filter()
          .trackIdEqualTo(trackId)
          .findAll();

      for (final rating in existing) {
        await _isar.isarTrackRatings.delete(rating.id!);
      }

      await _isar.isarTrackRatings.put(isarRating);
    });

    // Queue the actual API mutation
    final payload = jsonEncode({
      'trackId': trackId,
      'rating': rating,
    });

    return _mutationQueue.queue(
      type: MutationType.rateTrack,
      payload: payload,
    );
  }

  @override
  Future<List<IsarPendingMutation>> getPendingMutations() {
    return _mutationQueue.getPending();
  }

  @override
  Future<void> retryMutation(String mutationId) {
    return _mutationQueue.retryMutation(mutationId);
  }

  @override
  Future<void> cancelMutation(String mutationId) {
    return _mutationQueue.cancelMutation(mutationId);
  }

  // =========================================================================
  // BACKGROUND SYNC
  // =========================================================================

  void _syncShelvesBackground() async {
    try {
      await _syncShelves();
    } catch (_) {
      // Silent failure - keep using cache
    }
  }

  Future<List<IsarShelf>> _syncShelves() async {
    if (_client == null) return const [];

    try {
      final response = await _client!.from('shelves').select('*').limit(100);

      final shelves = (response as List<dynamic>)
          .map((row) {
            final r = row as Map<String, dynamic>;
            return IsarShelf()
              ..shelfId = r['id']?.toString() ?? ''
              ..name = r['name']?.toString() ?? ''
              ..description = r['description']?.toString() ?? ''
              ..trackCount = (r['track_count'] as num?)?.toInt() ?? 0
              ..createdAtMs = (r['created_at'] as num?)?.toInt() ?? 0
              ..updatedAtMs = (r['updated_at'] as num?)?.toInt() ?? 0
              ..isPublic = r['is_public'] == true;
          })
          .toList();

      // Update cache
      await _isar.writeTxn(() async {
        await _isar.isarShelves.putAll(shelves);
      });

      return shelves;
    } catch (_) {
      return const [];
    }
  }

  void _syncShelfTracksBackground(String shelfId) async {
    try {
      await _syncShelfTracks(shelfId);
    } catch (_) {
      // Silent failure - keep using cache
    }
  }

  Future<List<IsarShelfTrack>> _syncShelfTracks(String shelfId) async {
    if (_client == null) return const [];

    try {
      final response = await _client!
          .from('shelf_tracks')
          .select('*, tracks(title, composer_name, source_title)')
          .eq('shelf_id', shelfId)
          .order('added_at', ascending: false);

      final tracks = (response as List<dynamic>)
          .map((row) {
            final r = row as Map<String, dynamic>;
            final track = (r['tracks'] as Map<String, dynamic>?) ?? {};

            return IsarShelfTrack()
              ..trackId = r['track_id']?.toString() ?? ''
              ..shelfId = shelfId
              ..title = track['title']?.toString() ?? ''
              ..composerName = track['composer_name']?.toString() ?? ''
              ..sourceName = track['source_title']?.toString() ?? ''
              ..addedAtMs = (r['added_at'] as num?)?.toInt() ?? 0;
          })
          .toList();

      // Update cache
      await _isar.writeTxn(() async {
        // Delete existing tracks for this shelf
        final existing = await _isar.isarShelfTracks
            .filter()
            .shelfIdEqualTo(shelfId)
            .findAll();

        for (final track in existing) {
          await _isar.isarShelfTracks.delete(track.id!);
        }

        await _isar.isarShelfTracks.putAll(tracks);
      });

      return tracks;
    } catch (_) {
      return const [];
    }
  }

  // =========================================================================
  // MUTATION EXECUTION
  // =========================================================================

  Future<bool> _executeMutation(IsarPendingMutation mutation) async {
    if (_client == null) {
      throw Exception('Supabase client not initialized');
    }

    final type = mutation.type;
    dynamic payload;

    try {
      payload = jsonDecode(mutation.payload);
    } catch (e) {
      throw Exception('Invalid mutation payload: $e');
    }

    if (type == MutationType.addToShelf.toString()) {
      return _executeAddToShelf(payload);
    } else if (type == MutationType.removeFromShelf.toString()) {
      return _executeRemoveFromShelf(payload);
    } else if (type == MutationType.rateTrack.toString()) {
      return _executeRateTrack(payload);
    }

    throw Exception('Unknown mutation type: $type');
  }

  Future<bool> _executeAddToShelf(Map<String, dynamic> payload) async {
    final shelfId = payload['shelfId'] as String;
    final trackId = payload['trackId'] as String;

    await _client!.from('shelf_tracks').insert({
      'shelf_id': shelfId,
      'track_id': trackId,
      'added_at': DateTime.now().toIso8601String(),
    });

    return true;
  }

  Future<bool> _executeRemoveFromShelf(Map<String, dynamic> payload) async {
    final shelfId = payload['shelfId'] as String;
    final trackId = payload['trackId'] as String;

    await _client!
        .from('shelf_tracks')
        .delete()
        .eq('shelf_id', shelfId)
        .eq('track_id', trackId);

    return true;
  }

  Future<bool> _executeRateTrack(Map<String, dynamic> payload) async {
    final trackId = payload['trackId'] as String;
    final rating = payload['rating'] as double;

    await _client!.from('track_ratings').upsert({
      'track_id': trackId,
      'rating': rating,
      'rated_at': DateTime.now().toIso8601String(),
    });

    return true;
  }
}

// ============================================================================
// LOCAL-ONLY SHELF REPOSITORY (for testing offline)
// ============================================================================

class LocalShelfRepository implements ShelfRepository {
  LocalShelfRepository({required Isar isar}) : _isar = isar {
    _mutationQueue = MutationQueue(
      isar: _isar,
      execute: (_) async => true, // Always succeeds locally
    );
  }

  final Isar _isar;
  late MutationQueue _mutationQueue;

  @override
  Future<List<IsarShelf>> getShelves() async {
    return _isar.isarShelves.where().findAll();
  }

  @override
  Future<List<IsarShelfTrack>> getShelfTracks(String shelfId) async {
    return _isar.isarShelfTracks.filter().shelfIdEqualTo(shelfId).findAll();
  }

  @override
  Future<String> addToShelf({
    required String shelfId,
    required String trackId,
    required String trackTitle,
    required String composerName,
    required String sourceName,
  }) async {
    final shelfTrack = IsarShelfTrack()
      ..trackId = trackId
      ..shelfId = shelfId
      ..title = trackTitle
      ..composerName = composerName
      ..sourceName = sourceName
      ..addedAtMs = DateTime.now().millisecondsSinceEpoch;

    await _isar.writeTxn(() async {
      await _isar.isarShelfTracks.put(shelfTrack);
    });

    return _mutationQueue.queue(
      type: MutationType.addToShelf,
      payload: jsonEncode({
        'shelfId': shelfId,
        'trackId': trackId,
      }),
    );
  }

  @override
  Future<String> removeFromShelf({
    required String shelfId,
    required String trackId,
  }) async {
    await _isar.writeTxn(() async {
      final toDelete = await _isar.isarShelfTracks
          .filter()
          .shelfIdEqualTo(shelfId)
          .and()
          .trackIdEqualTo(trackId)
          .findAll();

      for (final track in toDelete) {
        await _isar.isarShelfTracks.delete(track.id!);
      }
    });

    return _mutationQueue.queue(
      type: MutationType.removeFromShelf,
      payload: jsonEncode({
        'shelfId': shelfId,
        'trackId': trackId,
      }),
    );
  }

  @override
  Future<String> rateTrack({
    required String trackId,
    required double rating,
  }) async {
    final isarRating = IsarTrackRating()
      ..trackId = trackId
      ..rating = rating
      ..ratedAtMs = DateTime.now().millisecondsSinceEpoch;

    await _isar.writeTxn(() async {
      final existing = await _isar.isarTrackRatings
          .filter()
          .trackIdEqualTo(trackId)
          .findAll();

      for (final r in existing) {
        await _isar.isarTrackRatings.delete(r.id!);
      }

      await _isar.isarTrackRatings.put(isarRating);
    });

    return _mutationQueue.queue(
      type: MutationType.rateTrack,
      payload: jsonEncode({
        'trackId': trackId,
        'rating': rating,
      }),
    );
  }

  @override
  Future<List<IsarPendingMutation>> getPendingMutations() {
    return _mutationQueue.getPending();
  }

  @override
  Future<void> retryMutation(String mutationId) {
    return _mutationQueue.retryMutation(mutationId);
  }

  @override
  Future<void> cancelMutation(String mutationId) {
    return _mutationQueue.cancelMutation(mutationId);
  }
}
