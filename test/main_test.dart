import 'package:flutter_test/flutter_test.dart';
import 'package:shortcake_app/main.dart';

void main() {
  testWidgets('App builds', (WidgetTester tester) async {
    await tester.pumpWidget(ShortcakeClient());
    await tester.pumpAndSettle();
  });
}
