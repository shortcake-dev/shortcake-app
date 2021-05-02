import 'package:ferry_exec/ferry_exec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gql_link/gql_link.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:shortcake_app/feature/homepage/graphql/all_recipes.data.gql.dart';
import 'package:shortcake_app/feature/homepage/graphql/all_recipes.req.gql.dart';
import 'package:shortcake_app/feature/homepage/homepage.dart';
import 'package:shortcake_app/graphql/api_client.dart';

class MockLink extends Mock implements Link {}

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
  group('Homepage widget', () {
    late MockApi mockApi;
    late GAllRecipesData result;

    setUpAll(() async {
      mockApi = MockApi();
      final req = GAllRecipesReq();
      result = GAllRecipesData(
        (b) => b
          ..recipes.add(GAllRecipesData_recipes(
            (c) => c..name = 'Some recipe',
          )),
      );

      when(() => mockApi.request(req)).thenAnswer(
        (_) => Stream.value(OperationResponse(
          operationRequest: req,
          data: result,
        )),
      );
    });

    testWidgets('starts by displaying "loading"', (tester) async {
      final widget = TestHomepage(mockApi);

      // One pump builds widget with uncompleted Future
      await tester.pumpWidget(widget);

      expect(find.text('loading'), findsOneWidget);
    });

    testWidgets('then loads and displays results', (tester) async {
      final widget = TestHomepage(mockApi);

      // One pump builds widget with uncompleted Future
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text(result.recipes[0].name), findsOneWidget);
    });
  });
}
