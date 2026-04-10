import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'cache_models.g.dart';

// ============================================================================
// CATEGORY CACHE MODEL
// ============================================================================

@collection
class IsarCategoryEntry {
  Id? id = Isar.autoIncrement;

  late String label;
  late int accentValue; // Store Color as int (ARGB)

  // Reconstruct to app model
  @ignore
  Color get accentColor => Color(accentValue);
}

// ============================================================================
// TREND CACHE MODEL
// ============================================================================

@collection
class IsarTrendEntry {
  Id? id = Isar.autoIncrement;

  late String label;
  late String meta;
  late int accentValue; // Store Color as int (ARGB)

  // Reconstruct to app model
  @ignore
  Color get accentColor => Color(accentValue);
}

// ============================================================================
// ACTIVE TRACK CACHE MODEL
// ============================================================================

@collection
class IsarActiveTrackEntry {
  Id? id = Isar.autoIncrement;

  late String title;
  late String composer;
  late String source;
  late String description;
  late String sceneTag;
  late int cachedAtMs; // Timestamp for cache invalidation
}

// ============================================================================
// MASCOT ENTRY CACHE MODEL
// ============================================================================

@collection
class IsarMascotEntry {
  Id? id = Isar.autoIncrement;

  late String mascotId;
  late String name;
  late String concept;
  late String tier; // MascotTier enum as string (house, partnership, etc.)
  late int priceCents;
  late int assetColorValue; // Store Color as int (ARGB)
  late String description;
  late int frameCount;
  late int frameDurationMs;

  String? artistName;
  String? composerName;
  int? editionCap;
  int? editionsSold;
  String? availableUntilLabel;

  late bool isRetired;
  late bool isFoundingExclusive;
  late bool isFeatured;
  late int cachedAtMs; // Timestamp for cache invalidation

  // Reconstruct to app model Color
  @ignore
  Color get assetColor => Color(assetColorValue);
}

// ============================================================================
// PROFILE ENTRY CACHE MODEL
// ============================================================================

@collection
class IsarProfileEntry {
  Id? id = Isar.autoIncrement;

  late String username;
  late String bio;
  late int ratings;
  late String topComposer;
  late int cachedAtMs; // Timestamp for cache invalidation
}

// ============================================================================
// SEARCH RESULT CACHE MODEL
// ============================================================================

@collection
class IsarMediaSearchResult {
  Id? id = Isar.autoIncrement;

  late String query; // The search query this result came from
  late String title;
  late String source;
  late String alias;
  late int cachedAtMs; // Timestamp for cache invalidation
}

// ============================================================================
// SHELF CACHE MODEL
// ============================================================================

@collection
class IsarShelf {
  Id? id = Isar.autoIncrement;

  late String shelfId; // UUID from backend
  late String name;
  late String description;
  late int trackCount;
  late int createdAtMs;
  late int updatedAtMs;
  late bool isPublic;
}

// ============================================================================
// SHELF TRACK CACHE MODEL
// ============================================================================

@collection
class IsarShelfTrack {
  Id? id = Isar.autoIncrement;

  late String trackId; // Track UUID from backend
  late String shelfId; // FK to shelf
  late String title;
  late String composerName;
  late String sourceName;
  late int addedAtMs;
}

// ============================================================================
// TRACK RATING CACHE MODEL (for optimistic UI)
// ============================================================================

@collection
class IsarTrackRating {
  Id? id = Isar.autoIncrement;

  late String trackId; // Track UUID from backend
  late double rating; // 0.5 to 5.0
  late int ratedAtMs;
}

// ============================================================================
// PENDING MUTATION CACHE MODEL
// ============================================================================

@collection
class IsarPendingMutation {
  Id? id = Isar.autoIncrement;

  late String mutationId; // UUID for deduplication
  late String type; // MutationType as string
  late String payload; // JSON-serialized mutation data
  late int createdAtMs;
  late int lastAttemptMs;
  late int attemptCount;
  late int retryDelayMs; // Current exponential backoff delay
  late bool isRetrying;
  late String? errorMessage;
}
