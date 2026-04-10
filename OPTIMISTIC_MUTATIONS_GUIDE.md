# Optimistic Mutations & Background Queues Implementation

**Date:** April 10, 2026  
**Status:** ✅ Complete

---

## Overview

OSTrack now supports **optimistic mutations** with exponential backoff retry logic and background queuing. When users perform actions like "Add to Shelf," the UI updates instantly while the API request happens in the background. If the network is down, pending mutations are automatically queued and retry with exponential backoff (2s → 4s → 8s → ... up to 30s).

---

## Architecture

### Components

1. **`MutationQueue`** (`lib/src/backend/mutation_queue.dart`)
   - Manages pending mutations in Isar
   - Handles exponential backoff retry logic
   - Tracks mutation status and errors
   - Broadcasts mutation state changes to listeners

2. **`IsarPendingMutation`** (cache model)
   - Persists mutations to local database
   - Tracks attempt count, timestamps, and errors
   - Survives app crashes/restarts

3. **`ShelfRepository`** (`lib/src/backend/shelf_repository.dart`)
   - Implements Cache-Then-Network pattern
   - Handles optimistic UI updates
   - Delegates to `MutationQueue` for API requests

4. **`ShelfController`** (Riverpod)
   - High-level API for UI components
   - Automatically invalidates providers after mutations
   - Simplifies shelf operations

---

## Data Flow

### Adding a Track to a Shelf

```
User taps "Add to Shelf"
    ↓
ShelfController.addToShelf() called
    ↓
1. Optimistic Update: Write to local Isar immediately
2. Queue Mutation: Push API request to MutationQueue
    ↓
MutationQueue.queue()
    ↓
- Saved to Isar as IsarPendingMutation
- Broadcast to listeners (UI shows pending state)
    ↓
Attempt execution:
    ├─ Success → Delete from queue, refresh UI
    └─ Failure → Increment retry count, schedule backoff
        ├─ 2s backoff → retry
        ├─ 4s backoff → retry
        ├─ 8s backoff → retry
        └─ ... up to 30s max backoff
        
On Network Recovery:
    ↓
MutationQueue.processPending() runs automatically
    ↓
- Retries all failed mutations
- Updates UI as mutations succeed/fail
```

---

## Isar Models

New collections added to support mutations:

### IsarShelf
```dart
@collection
class IsarShelf {
  Id? id = Isar.autoIncrement;
  late String shelfId;      // Backend UUID
  late String name;
  late String description;
  late int trackCount;
  late int createdAtMs;
  late int updatedAtMs;
  late bool isPublic;
}
```

### IsarShelfTrack
```dart
@collection
class IsarShelfTrack {
  Id? id = Isar.autoIncrement;
  late String trackId;      // Backend UUID
  late String shelfId;      // FK to shelf
  late String title;
  late String composerName;
  late String sourceName;
  late int addedAtMs;
}
```

### IsarTrackRating
```dart
@collection
class IsarTrackRating {
  Id? id = Isar.autoIncrement;
  late String trackId;
  late double rating;       // 0.5 to 5.0
  late int ratedAtMs;
}
```

### IsarPendingMutation
```dart
@collection
class IsarPendingMutation {
  Id? id = Isar.autoIncrement;
  late String mutationId;         // UUID for tracking
  late String type;               // MutationType as string
  late String payload;            // JSON-encoded data
  late int createdAtMs;
  late int lastAttemptMs;
  late int attemptCount;
  late int retryDelayMs;          // Current backoff delay
  late bool isRetrying;
  late String? errorMessage;
}
```

---

## Riverpod Providers

### Available Providers

```dart
// Shelf repository (main entry point)
final shelfRepositoryProvider = Provider<ShelfRepository>((ref) { ... });

// Shelves cache
final shelvesProvider = FutureProvider<List<IsarShelf>>((ref) async { ... });

// Currently selected shelf ID
final selectedShelfIdProvider = StateProvider<String?>((ref) => null);

// Tracks in selected shelf (Cache-Then-Network)
final shelfTracksProvider = FutureProvider<List<IsarShelfTrack>>((ref) async { ... });

// Pending mutations (for showing sync status)
final pendingMutationsProvider = FutureProvider<List<IsarPendingMutation>>((ref) async { ... });

// High-level controller for mutations
final shelfControllerProvider = Provider<ShelfController>((ref) { ... });
```

---

## Usage in UI

### 1. Add Track to Shelf (Optimistic)

```dart
class ShelfTrackCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(shelfControllerProvider);

    return ElevatedButton(
      onPressed: () async {
        final shelfId = 'shelf-uuid-here';
        final trackId = 'track-uuid-here';

        // This returns immediately with optimistic update
        final mutationId = await controller.addToShelf(
          shelfId: shelfId,
          trackId: trackId,
          trackTitle: 'City of Tears',
          composerName: 'Christopher Larkin',
          sourceName: 'Hollow Knight',
        );

        // Show toast with mutation ID for tracking
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added to shelf (sync: $mutationId)'))
        );
      },
      child: const Text('Add to Shelf'),
    );
  }
}
```

### 2. Display Shelf Tracks with Cache-Then-Network

```dart
class ShelfTracksView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracksAsync = ref.watch(shelfTracksProvider);

    return tracksAsync.when(
      data: (tracks) {
        return ListView.builder(
          itemCount: tracks.length,
          itemBuilder: (context, index) {
            final track = tracks[index];
            return ListTile(
              title: Text(track.title),
              subtitle: Text('${track.composerName} • ${track.sourceName}'),
            );
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, st) => Text('Error: $error'),
    );
  }
}
```

### 3. Show Pending Mutations (Sync Status)

```dart
class SyncStatusIndicator extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingAsync = ref.watch(pendingMutationsProvider);

    return pendingAsync.when(
      data: (pending) {
        if (pending.isEmpty) {
          return const Icon(Icons.cloud_done, color: Colors.green);
        }

        final failed = pending.where((m) => m.isRetrying).length;
        return Tooltip(
          message: 'Syncing: ${pending.length} pending, $failed retrying',
          child: Stack(
            children: [
              const Icon(Icons.cloud_upload, color: Colors.orange),
              if (failed > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Center(
                      child: Text(
                        '$failed',
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      loading: () => const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, __) => const Icon(Icons.cloud_off, color: Colors.red),
    );
  }
}
```

### 4. Retry / Cancel Failed Mutations

```dart
class MutationFailureDialog extends ConsumerWidget {
  final IsarPendingMutation mutation;

  const MutationFailureDialog({required this.mutation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(shelfControllerProvider);

    return AlertDialog(
      title: const Text('Sync Failed'),
      content: Text(
        'Could not save: ${mutation.errorMessage}\n\n'
        'Retries: ${mutation.attemptCount}',
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await controller.cancelMutation(mutation.mutationId);
            Navigator.pop(context);
          },
          child: const Text('Discard'),
        ),
        ElevatedButton(
          onPressed: () async {
            await controller.retryMutation(mutation.mutationId);
            Navigator.pop(context);
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
```

---

## Exponential Backoff Configuration

Default settings in `MutationQueue`:

- **Initial Delay:** 2 seconds
- **Backoff Multiplier:** 2× each retry
- **Maximum Delay:** 30 seconds
- **Maximum Retries:** 5 attempts
- **Sequence:** 2s → 4s → 8s → 16s → 30s (capped)

Override in `ShelfRepository` constructor:

```dart
_mutationQueue = MutationQueue(
  isar: _isar,
  execute: _executeMutation,
  maxRetries: 10,           // Custom max
  maxDelayMs: 60000,        // 60 seconds
  initialDelayMs: 1000,     // Start with 1 second
);
```

---

## Testing Offline Behavior

1. **Trigger a mutation** while network is connected
2. **Go to Airplane Mode** (or disconnect network)
3. **Observe:** UI updates immediately, mutation queued
4. **Check Isar:** `IsarPendingMutation` persists in local database
5. **Reconnect network:**
   - `MutationQueue` auto-retries with exponential backoff
   - UI updates as mutations succeed
6. **Force failure:** Cancel network, let retries exhaust, reopen app
   - Mutations still in queue on reboot
   - Can manually retry or discard

---

## Initialization Checklist

✅ **Done:**
- Isar initialized in `main.dart`
- All schema models registered
- `MutationQueue` integrated with `ShelfRepository`
- Riverpod providers exposed
- `ShelfController` wired for UI
- Isar boilerplate generated with `build_runner`

**Next Steps:**
1. Restart the Dart analyzer / IDE:
   ```bash
   flutter clean
   flutter pub get
   ```
   *Note: The `build_runner` has already completed generation. If you see analyzer errors about undefined schemas, restart your IDE or run the above commands.*

2. Update backend to accept mutations (Supabase RLS policies)

3. Wire UI components to use `shelfControllerProvider`

4. Test offline flow with network toggle

---

## Key Behaviors

| Scenario | Behavior |
|----------|----------|
| Network OK | Mutation queus, executes immediately, succeeds |
| Network Down | Mutation queues, waits 2s, retries, fails, schedules 4s backoff |
| Airplane Mode → Reboot | Mutations survive in Isar, auto-retry on app reopen |
| Max Retries Exceeded | Mutation marked as failed, shown in UI, user can retry/discard |
| Manual Cancel | Mutation deleted, optimistic UI update reverted on next refresh |

---

## Files Modified

- `lib/main.dart` — Added Isar initialization
- `lib/src/ostrack_app.dart` — Pass Isar to ProviderScope
- `lib/src/app_providers.dart` — Added shelf providers & controller
- `lib/src/backend/cache_models.dart` — Added shelf & rating models
- **NEW:** `lib/src/backend/mutation_queue.dart` — Core mutation queue
- **NEW:** `lib/src/backend/shelf_repository.dart` — Shelf ops with mutations

---

## References

- **Isar:** https://isar.dev
- **Flutter Riverpod:** https://riverpod.dev
- **Exponential Backoff:** https://aws.amazon.com/blogs/architecture/exponential-backoff-and-jitter/
- **Optimistic UI:** https://www.smashingmagazine.com/2016/11/true-lies-of-optimistic-user-interfaces/
