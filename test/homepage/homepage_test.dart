import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:shortcake/shortcake.dart';
import 'package:shortcake_app/homepage/homepage.dart';

class MockApi extends Mock implements ShortcakeApi {}

void main() {
  group("Homepage widget", () {
    final mockApi = MockApi();

    testWidgets('starts by displaying "loading"', (tester) async {
      var widget = MaterialApp(
        home: Provider<ShortcakeApi>.value(
          value: mockApi,
          child: ShortcakeHomepage(),
        ),
      );

      var result = QueryResult.optimistic(data: {"some_field": 1234});
      when(() => mockApi.introspect()).thenAnswer((_) async => result);

      // One pump builds widget with uncompleted Future
      await tester.pumpWidget(widget);

      expect(find.text('loading'), findsOneWidget);
    });

    testWidgets('loads and displays results', (tester) async {
      var widget = MaterialApp(
        home: Provider<ShortcakeApi>.value(
          value: mockApi,
          child: ShortcakeHomepage(),
        ),
      );

      var result = QueryResult.optimistic(data: {"some_field": 1234});
      when(() => mockApi.introspect()).thenAnswer((_) async => result);

      // One pump builds widget with uncompleted Future
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text(result.toString()), findsOneWidget);
    });
  });
}
