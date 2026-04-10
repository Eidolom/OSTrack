import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../app_preferences.dart';
import '../mascot_monetization.dart';
import '../ostrack_theme.dart';

class MascotOwnershipRecord {
  const MascotOwnershipRecord({
    required this.mascotId,
    required this.source,
    this.editionNumber,
    this.purchasedAtLabel,
  });

  final String mascotId;
  final MascotOwnershipSource source;
  final int? editionNumber;
  final String? purchasedAtLabel;
}

abstract class MascotRepository {
  Future<List<MascotEntry>> fetchMascots();
  Future<List<MascotOwnershipRecord>> fetchOwnedMascots();
  Future<String> fetchEquippedMascotId();
  Future<void> equipMascot(String mascotId);
  Future<void> purchaseMascot(String mascotId);
}

class SupabaseMascotRepository implements MascotRepository {
  SupabaseMascotRepository({
    required SupabaseClient? client,
    required OstrackMascotCatalog seedCatalog,
    required AppPreferencesStore preferencesStore,
  })  : _client = client,
        _seedCatalog = seedCatalog,
        _preferencesStore = preferencesStore;

  final SupabaseClient? _client;
  final OstrackMascotCatalog _seedCatalog;
  final AppPreferencesStore _preferencesStore;

  @override
  Future<List<MascotEntry>> fetchMascots() async {
    if (_client == null) {
      return _seedCatalog.mascots;
    }

    try {
      final rows = await _client
          .from('mascots')
          .select('id, name, concept, tier, price_cents, description, frame_count, frame_duration_ms, artist_name, composer_name, edition_cap, editions_sold, available_until, retired, is_founding_exclusive, is_featured, asset_color_hex')
          .order('created_at', ascending: true);

      final mapped = (rows as List<dynamic>).map((raw) {
        final row = raw as Map<String, dynamic>;

        return MascotEntry(
          id: row['id']?.toString() ?? '',
          name: row['name']?.toString() ?? 'Unknown Mascot',
          concept: row['concept']?.toString() ?? '',
          tier: _parseTier(row['tier']?.toString()),
          priceCents: (row['price_cents'] as num?)?.toInt() ?? 0,
          assetColor: _parseColor(row['asset_color_hex']?.toString()),
          description: row['description']?.toString() ?? '',
          frameCount: (row['frame_count'] as num?)?.toInt() ?? 3,
          frameDurationMs: (row['frame_duration_ms'] as num?)?.toInt() ?? 250,
          artistName: row['artist_name']?.toString(),
          composerName: row['composer_name']?.toString(),
          editionCap: (row['edition_cap'] as num?)?.toInt(),
          editionsSold: (row['editions_sold'] as num?)?.toInt(),
          availableUntilLabel: _formatAvailableUntil(row['available_until']?.toString()),
          isRetired: row['retired'] == true,
          isFoundingExclusive: row['is_founding_exclusive'] == true,
          isFeatured: row['is_featured'] == true,
        );
      }).where((entry) => entry.id.isNotEmpty).toList(growable: false);

      return mapped.isEmpty ? _seedCatalog.mascots : mapped;
    } catch (_) {
      return _seedCatalog.mascots;
    }
  }

  @override
  Future<List<MascotOwnershipRecord>> fetchOwnedMascots() async {
    if (_client == null) {
      return _fallbackOwnedMascots();
    }

    try {
      final rows = await _client
          .from('user_mascots')
          .select('mascot_id, source, edition_number, purchased_at')
          .order('purchased_at', ascending: false);

      final mapped = (rows as List<dynamic>).map((raw) {
        final row = raw as Map<String, dynamic>;
        return MascotOwnershipRecord(
          mascotId: row['mascot_id']?.toString() ?? '',
          source: _parseOwnershipSource(row['source']?.toString()),
          editionNumber: (row['edition_number'] as num?)?.toInt(),
          purchasedAtLabel: _formatPurchasedAt(row['purchased_at']?.toString()),
        );
      }).where((entry) => entry.mascotId.isNotEmpty).toList(growable: false);

      return mapped.isEmpty ? _fallbackOwnedMascots() : mapped;
    } catch (_) {
      return _fallbackOwnedMascots();
    }
  }

  @override
  Future<String> fetchEquippedMascotId() async {
    if (_client == null) {
      return _fallbackEquippedMascotId();
    }

    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) {
        return _fallbackEquippedMascotId();
      }

      final row = await _client
          .from('users')
          .select('equipped_mascot_id')
          .eq('id', userId)
          .maybeSingle();

      final remoteValue = row?['equipped_mascot_id']?.toString();
      if (remoteValue == null || remoteValue.isEmpty) {
        return _fallbackEquippedMascotId();
      }

      return remoteValue;
    } catch (_) {
      return _fallbackEquippedMascotId();
    }
  }

  @override
  Future<void> equipMascot(String mascotId) async {
    final local = await _preferencesStore.load();
    await _preferencesStore.save(local.copyWith(equippedMascotId: mascotId));

    if (_client == null) {
      return;
    }

    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) {
        return;
      }

      await _client.from('users').upsert({
        'id': userId,
        'equipped_mascot_id': mascotId,
      });
    } catch (_) {
      // Keep local update as source of truth while offline or if API fails.
    }
  }

  @override
  Future<void> purchaseMascot(String mascotId) async {
    final local = await _preferencesStore.load();
    final owned = local.ownedMascotIds.toSet()..add(mascotId);
    await _preferencesStore.save(local.copyWith(ownedMascotIds: owned.toList()));

    if (_client == null) {
      return;
    }

    try {
      await _client.from('user_mascots').upsert({
        'mascot_id': mascotId,
        'source': 'purchased',
        'purchased_at': DateTime.now().toIso8601String(),
      });
    } catch (_) {
      // Keep local ownership while offline or if API fails.
    }
  }

  MascotTier _parseTier(String? raw) {
    switch (raw?.toLowerCase()) {
      case 'house':
        return MascotTier.house;
      case 'partnership':
        return MascotTier.partnership;
      case 'community':
        return MascotTier.community;
      case 'founding':
        return MascotTier.founding;
      default:
        return MascotTier.house;
    }
  }

  MascotOwnershipSource _parseOwnershipSource(String? raw) {
    if (raw?.toLowerCase() == 'founding_grant') {
      return MascotOwnershipSource.foundingGrant;
    }
    return MascotOwnershipSource.purchased;
  }

  Color _parseColor(String? rawHex) {
    if (rawHex == null || rawHex.isEmpty) {
      return OstrackColors.gold;
    }

    final cleaned = rawHex.replaceAll('#', '').trim();
    final normalized = cleaned.length == 6 ? 'FF$cleaned' : cleaned;

    final colorInt = int.tryParse(normalized, radix: 16);
    if (colorInt == null) {
      return OstrackColors.gold;
    }

    return Color(colorInt);
  }

  String? _formatAvailableUntil(String? iso) {
    if (iso == null || iso.isEmpty) {
      return null;
    }
    try {
      final parsed = DateTime.parse(iso);
      return 'Until ${parsed.year}-${parsed.month.toString().padLeft(2, '0')}-${parsed.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return null;
    }
  }

  String? _formatPurchasedAt(String? iso) {
    if (iso == null || iso.isEmpty) {
      return null;
    }

    try {
      final parsed = DateTime.parse(iso);
      return '${parsed.year}-${parsed.month.toString().padLeft(2, '0')}-${parsed.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return null;
    }
  }

  Future<List<MascotOwnershipRecord>> _fallbackOwnedMascots() async {
    final prefs = await _preferencesStore.load();
    return prefs.ownedMascotIds
        .map(
          (id) => MascotOwnershipRecord(
            mascotId: id,
            source: id == 'founding-archivist'
                ? MascotOwnershipSource.foundingGrant
                : MascotOwnershipSource.purchased,
          ),
        )
        .toList(growable: false);
  }

  Future<String> _fallbackEquippedMascotId() async {
    final prefs = await _preferencesStore.load();
    return prefs.equippedMascotId;
  }
}
