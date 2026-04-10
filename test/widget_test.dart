import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ostrack_app/src/app_preferences.dart';
import 'package:ostrack_app/src/auth/auth_service.dart';
import 'package:ostrack_app/src/onboarding/onboarding_flow.dart';
import 'package:ostrack_app/src/ostrack_catalog.dart';
import 'package:ostrack_app/src/ostrack_shell.dart';

Future<AuthSession> _fakeSignIn(AuthProvider provider) async {
  return AuthSession(provider: provider, displayName: 'Test User', email: 'test@ostrack.dev');
}

void main() {
  testWidgets('completes onboarding and opens the OSTrack shell', (WidgetTester tester) async {
    var completedPreferences = AppPreferences.defaults;

    await tester.pumpWidget(
      MaterialApp(
        home: OnboardingFlow(
          catalog: const OstrackCatalog(),
          initialPreferences: AppPreferences.defaults,
          onSignIn: _fakeSignIn,
          onComplete: (updated) {
            completedPreferences = updated;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Create your account'), findsOneWidget);

    for (var i = 0; i < 4; i++) {
      await tester.tap(find.text('Continue').last);
      await tester.pumpAndSettle();
    }

    await tester.scrollUntilVisible(find.text('Enter OSTrack'), 200);
    await tester.tap(find.text('Enter OSTrack'));
    await tester.pumpAndSettle();

    expect(completedPreferences.onboardingCompleted, isTrue);
  });

  testWidgets('shows the OSTrack shell when onboarding is complete', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: OstrackShell(
            catalog: const OstrackCatalog(),
            preferences: AppPreferences.defaults.copyWith(onboardingCompleted: true),
            onPreferencesChanged: (_) async {},
            onSignOut: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Your soundtrack pulse'), findsOneWidget);
    expect(find.text('Create your account'), findsNothing);
  });
}
