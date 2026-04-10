import 'package:shared_preferences/shared_preferences.dart';

typedef PreferencesUpdater = Future<void> Function(AppPreferences updated);

class AppPreferences {
  const AppPreferences({
    required this.onboardingCompleted,
    required this.selectedPlatform,
    required this.selectedWorlds,
    required this.followedUsers,
    required this.ownedMascotIds,
    required this.equippedMascotId,
  });

  static const defaults = AppPreferences(
    onboardingCompleted: false,
    selectedPlatform: 'Spotify',
    selectedWorlds: [
      'Video Games',
      'Anime',
      'Movies & TV',
      'K-Drama',
      'Composers',
    ],
    followedUsers: ['yukirose', 'ostnerdd', 'melodyarchive'],
    ownedMascotIds: [
      'conductor-skeleton',
      'kitsune-archivist',
      'cassette-ghost',
      'founding-archivist',
    ],
    equippedMascotId: 'conductor-skeleton',
  );

  final bool onboardingCompleted;
  final String selectedPlatform;
  final List<String> selectedWorlds;
  final List<String> followedUsers;
  final List<String> ownedMascotIds;
  final String equippedMascotId;

  AppPreferences copyWith({
    bool? onboardingCompleted,
    String? selectedPlatform,
    List<String>? selectedWorlds,
    List<String>? followedUsers,
    List<String>? ownedMascotIds,
    String? equippedMascotId,
  }) {
    return AppPreferences(
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      selectedPlatform: selectedPlatform ?? this.selectedPlatform,
      selectedWorlds: selectedWorlds ?? this.selectedWorlds,
      followedUsers: followedUsers ?? this.followedUsers,
      ownedMascotIds: ownedMascotIds ?? this.ownedMascotIds,
      equippedMascotId: equippedMascotId ?? this.equippedMascotId,
    );
  }
}

class AppPreferencesStore {
  static const _onboardingCompletedKey = 'onboarding_completed';
  static const _selectedPlatformKey = 'selected_platform';
  static const _selectedWorldsKey = 'selected_worlds';
  static const _followedUsersKey = 'followed_users';
  static const _ownedMascotIdsKey = 'owned_mascot_ids';
  static const _equippedMascotIdKey = 'equipped_mascot_id';

  Future<AppPreferences> load() async {
    final prefs = await SharedPreferences.getInstance();
    final defaults = AppPreferences.defaults;

    return AppPreferences(
      onboardingCompleted: prefs.getBool(_onboardingCompletedKey) ?? defaults.onboardingCompleted,
      selectedPlatform: prefs.getString(_selectedPlatformKey) ?? defaults.selectedPlatform,
      selectedWorlds: prefs.getStringList(_selectedWorldsKey) ?? defaults.selectedWorlds,
      followedUsers: prefs.getStringList(_followedUsersKey) ?? defaults.followedUsers,
      ownedMascotIds: prefs.getStringList(_ownedMascotIdsKey) ?? defaults.ownedMascotIds,
      equippedMascotId: prefs.getString(_equippedMascotIdKey) ?? defaults.equippedMascotId,
    );
  }

  Future<void> save(AppPreferences value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, value.onboardingCompleted);
    await prefs.setString(_selectedPlatformKey, value.selectedPlatform);
    await prefs.setStringList(_selectedWorldsKey, value.selectedWorlds);
    await prefs.setStringList(_followedUsersKey, value.followedUsers);
    await prefs.setStringList(_ownedMascotIdsKey, value.ownedMascotIds);
    await prefs.setString(_equippedMascotIdKey, value.equippedMascotId);
  }
}
