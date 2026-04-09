import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  const AppPreferences({
    required this.onboardingCompleted,
    required this.selectedPlatform,
    required this.selectedWorlds,
    required this.followedUsers,
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
  );

  final bool onboardingCompleted;
  final String selectedPlatform;
  final List<String> selectedWorlds;
  final List<String> followedUsers;

  AppPreferences copyWith({
    bool? onboardingCompleted,
    String? selectedPlatform,
    List<String>? selectedWorlds,
    List<String>? followedUsers,
  }) {
    return AppPreferences(
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      selectedPlatform: selectedPlatform ?? this.selectedPlatform,
      selectedWorlds: selectedWorlds ?? this.selectedWorlds,
      followedUsers: followedUsers ?? this.followedUsers,
    );
  }
}

class AppPreferencesStore {
  static const _onboardingCompletedKey = 'onboarding_completed';
  static const _selectedPlatformKey = 'selected_platform';
  static const _selectedWorldsKey = 'selected_worlds';
  static const _followedUsersKey = 'followed_users';

  Future<AppPreferences> load() async {
    final prefs = await SharedPreferences.getInstance();
    final defaults = AppPreferences.defaults;

    return AppPreferences(
      onboardingCompleted: prefs.getBool(_onboardingCompletedKey) ?? defaults.onboardingCompleted,
      selectedPlatform: prefs.getString(_selectedPlatformKey) ?? defaults.selectedPlatform,
      selectedWorlds: prefs.getStringList(_selectedWorldsKey) ?? defaults.selectedWorlds,
      followedUsers: prefs.getStringList(_followedUsersKey) ?? defaults.followedUsers,
    );
  }

  Future<void> save(AppPreferences value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, value.onboardingCompleted);
    await prefs.setString(_selectedPlatformKey, value.selectedPlatform);
    await prefs.setStringList(_selectedWorldsKey, value.selectedWorlds);
    await prefs.setStringList(_followedUsersKey, value.followedUsers);
  }
}
