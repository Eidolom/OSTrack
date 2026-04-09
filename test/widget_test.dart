import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ostrack_app/src/ostrack_app.dart';

void main() {
  testWidgets('completes onboarding and opens the OSTrack shell', (WidgetTester tester) async {
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
}
