import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:shortcake_app/feature/recipe_page/graphql/complete_recipe.data.gql.dart';
import 'package:shortcake_app/feature/recipe_page/graphql/complete_recipe.req.gql.dart';
import 'package:shortcake_app/feature/recipe_page/recipe_page.dart';
import 'package:shortcake_app/feature/recipe_page/widgets/recipe_card.dart';
import 'package:shortcake_app/graphql/api_client.dart';

import '../../test_core/mock.dart';

class TestRecipePage extends StatelessWidget {
  final ShortcakeApi shortcakeApi;
  final String recipeId;

  TestRecipePage(this.shortcakeApi, this.recipeId);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider<ShortcakeApi>.value(
        value: shortcakeApi,
        child: RecipePage(recipeId),
      ),
    );
  }
}

void main() {
  group('RecipePage widget', () {
    late MockApi mockApi;
    late GCompleteRecipeData result;

    const recipeId = 'recipe_id';
    const recipeName = 'Chicken noodle soup';

    setUpAll(() async {
      mockApi = MockApi();
      final req = GCompleteRecipeReq(
        (b) => b..vars.recipe_id = recipeId,
      );

      result = GCompleteRecipeData(
        (b) => b..recipe.name = recipeName,
      );

      when(() => mockApi.request(req)).thenAnswer(
        (_) => Stream.value(OperationResponse(
          operationRequest: req,
          data: result,
        )),
      );
    });

    testWidgets('displays RecipeCard corresponding to recipeId',
        (tester) async {
      final widget = TestRecipePage(mockApi, recipeId);

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(RecipeCard), findsOneWidget);
      expect(find.text(recipeName), findsOneWidget);
    });
  });
}
