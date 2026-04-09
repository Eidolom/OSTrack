import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ostrack_app/src/ostrack_app.dart';

void main() {
  testWidgets('completes onboarding and opens the OSTrack shell', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const OstrackApp());
    await tester.pumpAndSettle();

    expect(find.text('Create your account'), findsOneWidget);

    for (var i = 0; i < 4; i++) {
      await tester.tap(find.text('Continue').last);
      await tester.pumpAndSettle();
    }

    await tester.scrollUntilVisible(find.text('Enter OSTrack'), 200);
    await tester.tap(find.text('Enter OSTrack'));
    await tester.pumpAndSettle();

    expect(find.text('Your soundtrack pulse'), findsOneWidget);
  });

  testWidgets('skips onboarding when preferences already exist', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'onboarding_completed': true,
      'selected_platform': 'Apple Music',
      'selected_worlds': ['Anime', 'Composers', 'Video Games', 'Movies & TV', 'K-Drama'],
      'followed_users': ['melodyarchive'],
    });

    await tester.pumpWidget(const OstrackApp());
    await tester.pumpAndSettle();

    expect(find.text('Your soundtrack pulse'), findsOneWidget);
    expect(find.text('Create your account'), findsNothing);
  });
}
