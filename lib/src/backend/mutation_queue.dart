import 'dart:async';

import 'package:isar/isar.dart';

import 'cache_models.dart';

// ============================================================================
// MUTATION TYPES
// ============================================================================

enum MutationType {
  addToShelf,
  removeFromShelf,
  rateTrack,
  createShelf,
  deleteShelf,
}

// ============================================================================
// MUTATION QUEUE MANAGER
// ============================================================================

class MutationQueue {
  MutationQueue({
    required Isar isar,
    required Future<bool> Function(IsarPendingMutation) execute,
    this.maxRetries = 5,
    this.maxDelayMs = 30000, // 30 seconds max backoff
    this.initialDelayMs = 2000, // Start with 2 seconds
  })  : _isar = isar,
        _execute = execute;

  final Isar _isar;
  final Future<bool> Function(IsarPendingMutation) _execute;
  final int maxRetries;
  final int maxDelayMs;
  final int initialDelayMs;

  final _processingController = StreamController<List<IsarPendingMutation>>.broadcast();
  Stream<List<IsarPendingMutation>> get onMutationsChanged => _processingController.stream;

  Timer? _retryTimer;
  bool _isProcessing = false;

  /// Queue a mutation for execution.
  /// Returns the mutation ID for tracking.
  Future<String> queue({
    required MutationType type,
    required String payload,
    String? mutationId,
  }) async {
    final id = mutationId ?? _generateId();
    final now = DateTime.now().millisecondsSinceEpoch;

    final mutation = IsarPendingMutation()
      ..mutationId = id
      ..type = type.toString()
      ..payload = payload
      ..createdAtMs = now
      ..lastAttemptMs = now
      ..attemptCount = 0
      ..retryDelayMs = initialDelayMs
      ..isRetrying = false
      ..errorMessage = null;

    await _isar.writeTxn(() async {
      await _isar.isarPendingMutations.put(mutation);
    });

    _broadcastChange();
    _scheduleRetry();

    return id;
  }

  /// Process pending mutations. Called periodically or on demand.
  Future<void> processPending() async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      final pending = await _isar.isarPendingMutations
          .filter()
          .isRetryingEqualTo(false)
          .findAll();

      for (final mutation in pending) {
        if (await _tryExecute(mutation)) {
          // Remove on success
          await _isar.writeTxn(() async {
            await _isar.isarPendingMutations.delete(mutation.id!);
          });
          _broadcastChange();
        } else {
          // Mark for retry, schedule next attempt
          _scheduleRetry();
        }
      }
    } finally {
      _isProcessing = false;
    }
  }

  /// Retry a specific mutation manually.
  Future<void> retryMutation(String mutationId) async {
    final mutation = await _isar.isarPendingMutations
        .filter()
        .mutationIdEqualTo(mutationId)
        .findFirst();

    if (mutation != null) {
      if (await _tryExecute(mutation)) {
        await _isar.writeTxn(() async {
          await _isar.isarPendingMutations.delete(mutation.id!);
        });
      } else {
        _scheduleRetry();
      }
      _broadcastChange();
    }
  }

  /// Cancel a queued mutation.
  Future<void> cancelMutation(String mutationId) async {
    await _isar.writeTxn(() async {
      final mutation = await _isar.isarPendingMutations
          .filter()
          .mutationIdEqualTo(mutationId)
          .findFirst();
      if (mutation != null) {
        await _isar.isarPendingMutations.delete(mutation.id!);
      }
    });
    _broadcastChange();
  }

  /// Get all pending mutations.
  Future<List<IsarPendingMutation>> getPending() {
    return _isar.isarPendingMutations.where().findAll();
  }

  /// Attempt to execute a mutation with error handling.
  Future<bool> _tryExecute(IsarPendingMutation mutation) async {
    try {
      return await _execute(mutation);
    } catch (e) {
      // On failure, update retry state
      await _isar.writeTxn(() async {
        mutation.lastAttemptMs = DateTime.now().millisecondsSinceEpoch;
        mutation.attemptCount++;
        mutation.isRetrying = true;
        mutation.errorMessage = e.toString();

        // Calculate next backoff delay (exponential: 2s → 4s → 8s → ...)
        mutation.retryDelayMs = (mutation.retryDelayMs * 2).clamp(0, maxDelayMs);

        await _isar.isarPendingMutations.put(mutation);
      });

      return false;
    }
  }

  /// Schedule retry processing after appropriate delay.
  void _scheduleRetry() {
    _retryTimer?.cancel();

    // Start immediate processing check
    _retryTimer = Timer(const Duration(milliseconds: 500), () async {
      await processPending();
    });
  }

  /// Broadcast current mutations to listeners.
  void _broadcastChange() async {
    final mutations = await getPending();
    _processingController.add(mutations);
  }

  /// Generate a unique mutation ID.
  String _generateId() {
    return '${DateTime.now().millisecondsSinceEpoch}-${DateTime.now().microsecond}';
  }

  void dispose() {
    _retryTimer?.cancel();
    _processingController.close();
  }
}

// ============================================================================
// MUTATION RESULT
// ============================================================================

class MutationResult<T> {
  const MutationResult({
    required this.id,
    required this.isOptimistic,
    required this.data,
    this.error,
  });

  final String id;
  final bool isOptimistic;
  final T data;
  final String? error;

  bool get isSuccess => error == null;
}
