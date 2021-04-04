import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:shortcake/shortcake.dart';
import 'package:shortcake_app/homepage/homepage.dart';

class MockApi extends Mock implements ShortcakeApi {}

class TestHomepage extends StatelessWidget {
  final ShortcakeApi shortcakeApi;

  const TestHomepage(this.shortcakeApi);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider<ShortcakeApi>.value(
        value: shortcakeApi,
        child: ShortcakeHomepage(),
      ),
    );
  }
}

void main() {
  group("Homepage widget", () {
    late MockApi mockApi;
    late QueryResult result;

    setUpAll(() async {
      mockApi = MockApi();

      result = QueryResult.optimistic(data: {"some_field": 1234});
      when(() => mockApi.introspect()).thenAnswer((_) async => result);
    });

    testWidgets('starts by displaying "loading"', (tester) async {
      var widget = TestHomepage(mockApi);

      // One pump builds widget with uncompleted Future
      await tester.pumpWidget(widget);

      expect(find.text('loading'), findsOneWidget);
    });

    testWidgets('then loads and displays results', (tester) async {
      var widget = TestHomepage(mockApi);

      // One pump builds widget with uncompleted Future
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text(result.toString()), findsOneWidget);
    });
  });
}
