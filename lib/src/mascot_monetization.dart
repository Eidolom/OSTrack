import 'package:flutter/material.dart';

import 'app_preferences.dart';
import 'ostrack_theme.dart';
import 'ostrack_widgets.dart';

enum MascotTier { house, partnership, community, founding }

enum MascotOwnershipSource { purchased, foundingGrant }

String mascotGlyphForId(String mascotId) {
  return switch (mascotId) {
    'conductor-skeleton' => '💀',
    'kitsune-archivist' => '🦊',
    'cassette-ghost' => '👻',
    'chibi-beethoven' => '🎵',
    'shrine-maiden' => '⛩',
    'pixel-composer' => '✎',
    'annoying-dog' => '🐶',
    'founding-archivist' => '✦',
    'community-echo' => '〰',
    _ => '□',
  };
}

class MascotEntry {
  const MascotEntry({
    required this.id,
    required this.name,
    required this.concept,
    required this.tier,
    required this.priceCents,
    required this.assetColor,
    required this.description,
    required this.frameCount,
    required this.frameDurationMs,
    this.artistName,
    this.composerName,
    this.editionCap,
    this.editionsSold,
    this.availableUntilLabel,
    this.isRetired = false,
    this.isFoundingExclusive = false,
    this.isFeatured = false,
  });

  final String id;
  final String name;
  final String concept;
  final MascotTier tier;
  final int priceCents;
  final Color assetColor;
  final String description;
  final int frameCount;
  final int frameDurationMs;
  final String? artistName;
  final String? composerName;
  final int? editionCap;
  final int? editionsSold;
  final String? availableUntilLabel;
  final bool isRetired;
  final bool isFoundingExclusive;
  final bool isFeatured;

  String get priceLabel => '\$${(priceCents / 100).toStringAsFixed(2)}';

  String get tierLabel => switch (tier) {
        MascotTier.house => 'HOUSE',
        MascotTier.partnership => 'PARTNERSHIP',
        MascotTier.community => 'COMMUNITY',
        MascotTier.founding => 'FOUNDING',
      };

  String get editionLabel {
    if (editionCap == null) {
      return 'Permanent';
    }

    final sold = editionsSold ?? 0;
    return '$sold of $editionCap sold';
  }

  bool get isLimited => editionCap != null;

  bool get isAvailable => !isRetired;
}

class OwnedMascotEntry {
  const OwnedMascotEntry({
    required this.mascotId,
    required this.source,
    required this.purchasedAtLabel,
    this.editionNumber,
  });

  final String mascotId;
  final MascotOwnershipSource source;
  final String purchasedAtLabel;
  final int? editionNumber;
}

class MascotCatalogEntry {
  const MascotCatalogEntry({
    required this.mascot,
    required this.owned,
    required this.equipped,
  });

  final MascotEntry mascot;
  final OwnedMascotEntry? owned;
  final bool equipped;
}

class MascotCatalogView {
  const MascotCatalogView({
    required this.mascots,
    required this.ownedMascotIds,
    required this.equippedMascotId,
  });

  final List<MascotEntry> mascots;
  final List<String> ownedMascotIds;
  final String equippedMascotId;

  List<MascotCatalogEntry> get entries => mascots
      .map(
        (mascot) => MascotCatalogEntry(
          mascot: mascot,
          owned: ownedMascotIds.contains(mascot.id)
              ? OwnedMascotEntry(
                  mascotId: mascot.id,
                  source: mascot.tier == MascotTier.founding
                      ? MascotOwnershipSource.foundingGrant
                      : MascotOwnershipSource.purchased,
                  purchasedAtLabel: mascot.tier == MascotTier.founding ? 'Founding grant' : 'Purchased today',
                  editionNumber: mascot.editionCap == null ? null : 47,
                )
              : null,
          equipped: equippedMascotId == mascot.id,
        ),
      )
      .toList(growable: false);

  MascotCatalogEntry? entryFor(String mascotId) {
    for (final entry in entries) {
      if (entry.mascot.id == mascotId) {
        return entry;
      }
    }
    return null;
  }

  MascotCatalogEntry? get equippedEntry => entryFor(equippedMascotId);
}

class MascotCabinetSection extends StatelessWidget {
  const MascotCabinetSection({
    super.key,
    required this.catalog,
    required this.onEquipMascot,
    required this.onOpenStore,
  });

  final MascotCatalogView catalog;
  final Future<void> Function(String mascotId) onEquipMascot;
  final VoidCallback onOpenStore;

  @override
  Widget build(BuildContext context) {
    final ownedEntries = catalog.entries.where((entry) => entry.owned != null).toList(growable: false);
    final unlockedCount = ownedEntries.length;

    return OstrackCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('COLLECTION', style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 4),
                    Text('$unlockedCount owned', style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              IconButton(
                onPressed: onOpenStore,
                icon: const Icon(Icons.storefront_outlined),
                tooltip: 'Open store',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _MascotFilterPill(label: 'ALL', isActive: true),
              _MascotFilterPill(label: 'HOUSE'),
              _MascotFilterPill(label: 'PARTNERSHIP'),
              _MascotFilterPill(label: 'COMMUNITY'),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final tileWidth = (constraints.maxWidth - 24) / 4;

              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: catalog.entries
                    .map(
                      (entry) => SizedBox(
                        width: tileWidth,
                        child: _MascotCaseTile(
                          entry: entry,
                          onEquipMascot: () => onEquipMascot(entry.mascot.id),
                        ),
                      ),
                    )
                    .toList(growable: false),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MascotStorePage extends StatefulWidget {
  const MascotStorePage({
    super.key,
    required this.catalog,
    required this.preferences,
    required this.onPreferencesChanged,
  });

  final MascotCatalogView catalog;
  final AppPreferences preferences;
  final PreferencesUpdater onPreferencesChanged;

  @override
  State<MascotStorePage> createState() => _MascotStorePageState();
}

class _MascotStorePageState extends State<MascotStorePage> {
  String _selectedTier = 'ALL';
  late AppPreferences _localPreferences;

  @override
  void initState() {
    super.initState();
    _localPreferences = widget.preferences;
  }

  @override
  Widget build(BuildContext context) {
    final localCatalog = widget.catalog.copyWithPreferences(_localPreferences);
    final entries = localCatalog.entries.where((entry) {
      if (_selectedTier == 'ALL') {
        return true;
      }
      return entry.mascot.tierLabel == _selectedTier;
    }).toList(growable: false);
    final featured = localCatalog.entries.where((entry) => entry.mascot.isFeatured).toList(growable: false);

    return Scaffold(
      body: Stack(
        children: [
          const OstrackBackdrop(),
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text('Mascot Store', style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (featured.isNotEmpty) ...[
                    _FeaturedMascotDrop(entry: featured.first),
                    const SizedBox(height: 16),
                  ],
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _StoreFilterChip(label: 'ALL', isSelected: _selectedTier == 'ALL', onSelected: () => setState(() => _selectedTier = 'ALL')),
                      _StoreFilterChip(label: 'HOUSE', isSelected: _selectedTier == 'HOUSE', onSelected: () => setState(() => _selectedTier = 'HOUSE')),
                      _StoreFilterChip(label: 'PARTNERSHIP', isSelected: _selectedTier == 'PARTNERSHIP', onSelected: () => setState(() => _selectedTier = 'PARTNERSHIP')),
                      _StoreFilterChip(label: 'COMMUNITY', isSelected: _selectedTier == 'COMMUNITY', onSelected: () => setState(() => _selectedTier = 'COMMUNITY')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  for (var i = 0; i < entries.length; i++) ...[
                    _MascotStoreCard(
                      entry: entries[i],
                      onPurchase: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final owned = _localPreferences.ownedMascotIds.toSet();
                        owned.add(entries[i].mascot.id);
                        final updated = _localPreferences.copyWith(ownedMascotIds: owned.toList());
                        setState(() {
                          _localPreferences = updated;
                        });
                        await widget.onPreferencesChanged(updated);
                        if (!mounted) {
                          return;
                        }
                        messenger.showSnackBar(
                          SnackBar(content: Text('${entries[i].mascot.name} added to your collection.')),
                        );
                      },
                      onEquip: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final updated = _localPreferences.copyWith(equippedMascotId: entries[i].mascot.id);
                        setState(() {
                          _localPreferences = updated;
                        });
                        await widget.onPreferencesChanged(updated);
                        if (!mounted) {
                          return;
                        }
                        messenger.showSnackBar(
                          SnackBar(content: Text('${entries[i].mascot.name} equipped.')),
                        );
                      },
                    ),
                    if (i < entries.length - 1) const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedMascotDrop extends StatelessWidget {
  const _FeaturedMascotDrop({required this.entry});

  final MascotCatalogEntry entry;

  @override
  Widget build(BuildContext context) {
    final mascot = entry.mascot;
    return OstrackCard(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [mascot.assetColor.withValues(alpha: 0.22), OstrackColors.surface],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _StoreBadge(label: 'FEATURED'),
              const SizedBox(width: 8),
              if (mascot.isLimited) const _StoreBadge(label: 'LIMITED', color: OstrackColors.gold),
            ],
          ),
          const SizedBox(height: 12),
          Text(mascot.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(mascot.concept, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic)),
          const SizedBox(height: 14),
          Text(mascot.description, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          Text('${mascot.editionLabel}${mascot.availableUntilLabel != null ? ' · ${mascot.availableUntilLabel}' : ''}', style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}

class _MascotStoreCard extends StatelessWidget {
  const _MascotStoreCard({
    required this.entry,
    required this.onPurchase,
    required this.onEquip,
  });

  final MascotCatalogEntry entry;
  final VoidCallback onPurchase;
  final VoidCallback onEquip;

  @override
  Widget build(BuildContext context) {
    final mascot = entry.mascot;
    final owned = entry.owned != null;

    return OstrackCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MascotArtwork(size: 88, color: mascot.assetColor, glyph: _glyphFor(mascot.id)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(mascot.name, style: Theme.of(context).textTheme.titleLarge)),
                        if (entry.equipped) const _StoreBadge(label: 'EQUIPPED', color: OstrackColors.teal),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(mascot.tierLabel, style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 8),
                    Text(mascot.description, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (mascot.artistName != null) _StoreBadge(label: mascot.artistName!),
                        if (mascot.composerName != null) _StoreBadge(label: mascot.composerName!, color: OstrackColors.gold),
                        if (mascot.isFoundingExclusive) const _StoreBadge(label: 'FOUNDING', color: OstrackColors.teal),
                        if (mascot.isLimited) _StoreBadge(label: mascot.editionLabel, color: OstrackColors.gold),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(mascot.priceLabel, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: OstrackColors.gold)),
              const Spacer(),
              TextButton.icon(
                onPressed: onPurchase,
                icon: const Icon(Icons.shopping_bag_outlined),
                label: Text(owned ? 'Owned' : 'Add to Collection'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: owned ? onEquip : null,
                icon: const Icon(Icons.vibration),
                label: const Text('Equip'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _glyphFor(String mascotId) {
    return mascotGlyphForId(mascotId);
  }
}

class _MascotCaseTile extends StatelessWidget {
  const _MascotCaseTile({required this.entry, required this.onEquipMascot});

  final MascotCatalogEntry entry;
  final VoidCallback onEquipMascot;

  @override
  Widget build(BuildContext context) {
    final mascot = entry.mascot;
    final owned = entry.owned != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: owned ? onEquipMascot : null,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: owned ? OstrackColors.surfaceAlt : OstrackColors.surface.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: entry.equipped ? OstrackColors.gold : Colors.white.withValues(alpha: 0.08), width: entry.equipped ? 1.4 : 1),
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Center(
                  child: Text(
                    _glyphFor(mascot.id),
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                mascot.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 2),
              Text(
                owned ? (entry.owned?.editionNumber != null ? '#${entry.owned!.editionNumber} of ${mascot.editionCap ?? '-'}' : mascot.tierLabel) : 'Locked',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: owned ? OstrackColors.textMuted : OstrackColors.textLow),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              if (entry.equipped)
                const _StoreBadge(label: 'EQUIPPED', color: OstrackColors.gold)
              else if (owned)
                const _StoreBadge(label: 'OWNED')
              else
                const _StoreBadge(label: '?', color: OstrackColors.coral),
            ],
          ),
        ),
      ),
    );
  }

  String _glyphFor(String mascotId) {
    return mascotGlyphForId(mascotId);
  }
}

class _MascotArtwork extends StatelessWidget {
  const _MascotArtwork({required this.size, required this.color, required this.glyph});

  final double size;
  final Color color;
  final String glyph;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      alignment: Alignment.center,
      child: Text(glyph, style: const TextStyle(fontSize: 42)),
    );
  }
}

class _StoreBadge extends StatelessWidget {
  const _StoreBadge({required this.label, this.color = OstrackColors.textMuted});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color)),
    );
  }
}

class _MascotFilterPill extends StatelessWidget {
  const _MascotFilterPill({required this.label, this.isActive = false});

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? OstrackColors.gold.withValues(alpha: 0.18) : OstrackColors.surfaceAlt,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: isActive ? OstrackColors.gold.withValues(alpha: 0.55) : Colors.white.withValues(alpha: 0.08)),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}

class _StoreFilterChip extends StatelessWidget {
  const _StoreFilterChip({required this.label, required this.isSelected, required this.onSelected});

  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
    );
  }
}

extension MascotTierLabel on MascotTier {
  String get tierLabel => switch (this) {
        MascotTier.house => 'HOUSE',
        MascotTier.partnership => 'PARTNERSHIP',
        MascotTier.community => 'COMMUNITY',
        MascotTier.founding => 'FOUNDING',
      };
}

class OstrackMascotCatalog {
  const OstrackMascotCatalog();

  List<MascotEntry> get mascots => const [
        MascotEntry(
          id: 'conductor-skeleton',
          name: 'Conductor Skeleton',
          concept: 'A tiny skeleton in a conductor\'s tuxedo, baton raised.',
          tier: MascotTier.house,
          priceCents: 199,
          assetColor: OstrackColors.gold,
          description: 'OSTrack\'s de facto mascot. Ideal for users who want the archive to feel theatrical.',
          frameCount: 4,
          frameDurationMs: 260,
          isFeatured: true,
        ),
        MascotEntry(
          id: 'kitsune-archivist',
          name: 'Kitsune Archivist',
          concept: 'A fox spirit holding a scroll and a vinyl record.',
          tier: MascotTier.house,
          priceCents: 199,
          assetColor: OstrackColors.teal,
          description: 'Represents the cataloging identity with a warm, mischievous edge.',
          frameCount: 3,
          frameDurationMs: 240,
        ),
        MascotEntry(
          id: 'cassette-ghost',
          name: 'Cassette Ghost',
          concept: 'A translucent ghost emerging from a cassette tape.',
          tier: MascotTier.house,
          priceCents: 199,
          assetColor: OstrackColors.coral,
          description: 'Nostalgia and soundtrack culture with a little static in the silhouette.',
          frameCount: 4,
          frameDurationMs: 280,
        ),
        MascotEntry(
          id: 'chibi-beethoven',
          name: 'Chibi Beethoven',
          concept: 'A miniature Beethoven with wild hair and a quill.',
          tier: MascotTier.house,
          priceCents: 199,
          assetColor: Color(0xFF7CC8FF),
          description: 'Historical composer, public domain, and a little absurd in the best way.',
          frameCount: 2,
          frameDurationMs: 320,
        ),
        MascotEntry(
          id: 'shrine-maiden',
          name: 'Shrine Maiden',
          concept: 'An anime-adjacent shrine maiden with music note motifs.',
          tier: MascotTier.house,
          priceCents: 199,
          assetColor: Color(0xFFFFA94D),
          description: 'Represents the anime OST category with ceremonial poise.',
          frameCount: 3,
          frameDurationMs: 260,
        ),
        MascotEntry(
          id: 'pixel-composer',
          name: 'Pixel Composer',
          concept: 'A small figure hunched over sheet music under a lamp.',
          tier: MascotTier.house,
          priceCents: 199,
          assetColor: Color(0xFF9B8CFF),
          description: 'The archivist at work, forever solving a melody problem.',
          frameCount: 4,
          frameDurationMs: 260,
        ),
        MascotEntry(
          id: 'annoying-dog',
          name: 'Annoying Dog',
          concept: 'An official drop from a beloved indie composer partnership.',
          tier: MascotTier.partnership,
          priceCents: 499,
          assetColor: Color(0xFFF1E8A8),
          description: 'A limited partnership mascot built to feel like a release event, not a merch SKU.',
          frameCount: 4,
          frameDurationMs: 220,
          composerName: 'Toby Fox',
          editionCap: 1000,
          editionsSold: 743,
          availableUntilLabel: '7-day window',
          isFeatured: true,
        ),
        MascotEntry(
          id: 'community-echo',
          name: 'Echo Runner',
          concept: 'A community mascot that trails a ribbon of sound.',
          tier: MascotTier.community,
          priceCents: 249,
          assetColor: Color(0xFF82D0C8),
          description: 'Open submission program entry with a clean, expressive silhouette.',
          frameCount: 3,
          frameDurationMs: 250,
          artistName: '@pixelfable',
        ),
        MascotEntry(
          id: 'founding-archivist',
          name: 'Founding Archivist',
          concept: 'A small figure holding a quill and magnifying glass.',
          tier: MascotTier.founding,
          priceCents: 0,
          assetColor: OstrackColors.gold,
          description: 'Beta-exclusive and permanently non-purchasable. The strongest status signal in the system.',
          frameCount: 3,
          frameDurationMs: 240,
          isFoundingExclusive: true,
        ),
      ];

  MascotCatalogView viewFor(AppPreferences preferences) {
    return MascotCatalogView(
      mascots: mascots,
      ownedMascotIds: preferences.ownedMascotIds,
      equippedMascotId: preferences.equippedMascotId,
    );
  }
}

extension MascotCatalogViewPreferences on MascotCatalogView {
  MascotCatalogView copyWithPreferences(AppPreferences preferences) {
    return MascotCatalogView(
      mascots: mascots,
      ownedMascotIds: preferences.ownedMascotIds,
      equippedMascotId: preferences.equippedMascotId,
    );
  }
}
