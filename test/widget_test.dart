import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ostrack_app/src/ostrack_app.dart';

void main() {
  testWidgets('opens the OSTrack shell and switches tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const OstrackApp());
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
    expect(find.text('Your soundtrack pulse'), findsOneWidget);

    await tester.tap(find.text('Explore').last);
    await tester.pumpAndSettle();

    expect(find.text('Browse worlds, not just songs'), findsOneWidget);
  });
}
