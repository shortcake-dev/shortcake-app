import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shortcake_app/core/widgets/base_page.dart';

class TestShortcakePage extends ShortcakePage {
  TestShortcakePage({required body}) : super(body: body);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: super.build(context));
  }
}

void main() {
  group('ShortcakePage', () {
    testWidgets('displays AppBar', (tester) async {
      final pageWidget = TestShortcakePage(body: const Text('unused'));

      await tester.pumpWidget(pageWidget);

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('displays passed body', (tester) async {
      const Widget bodyWidget = Text('This is a test widget');
      final pageWidget = TestShortcakePage(body: bodyWidget);

      await tester.pumpWidget(pageWidget);

      expect(find.byWidget(bodyWidget), findsOneWidget);
    });
  });
}
