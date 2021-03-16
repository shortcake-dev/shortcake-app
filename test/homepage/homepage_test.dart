import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shortcake_app/homepage/homepage.dart';

void main() {
  testWidgets('Homepage has content', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ShortcakeHomepage()));

    expect(find.text('Shortcake'), findsOneWidget);
  });
}
