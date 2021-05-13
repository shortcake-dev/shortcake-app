import 'package:flutter_test/flutter_test.dart';
import 'package:shortcake_app/feature/shortcake_app/shortcake_app.dart';

void main() {
  testWidgets('App builds', (WidgetTester tester) async {
    await tester.pumpWidget(ShortcakeClient());
    await tester.pumpAndSettle();
  });
}
