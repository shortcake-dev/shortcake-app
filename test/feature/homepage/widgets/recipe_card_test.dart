import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shortcake_app/feature/homepage/graphql/all_recipes.data.gql.dart';
import 'package:shortcake_app/feature/homepage/widgets/recipe_card.dart';

class TestRecipeCard extends RecipeCard {
  TestRecipeCard(GAllRecipesData_recipes recipe) : super(recipe);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: super.build(context));
  }
}

void main() {
  group("RecipeCard widget", () {
    final recipeName = "Raw oats";
    final recipeDescription = "Literally just oats";
    final ingredientNames = ["oats", "bowl"];
    final steps = ["Get bowl", "Pour oats", "Consume"];

    testWidgets('displays recipe title', (tester) async {
      final recipe = GAllRecipesData_recipes((b) => b..name = recipeName);

      var widget = TestRecipeCard(recipe);

      // One pump builds widget with uncompleted Future
      await tester.pumpWidget(widget);

      expect(find.text(recipeName), findsOneWidget);
    });

    testWidgets('displays recipe description', (tester) async {
      final recipe = GAllRecipesData_recipes((b) => b
        ..name = recipeName
        ..description = recipeDescription);

      var widget = TestRecipeCard(recipe);
      await tester.pumpWidget(widget);

      expect(find.text(recipeDescription), findsOneWidget);
    });

    testWidgets('displays recipe ingredients', (tester) async {
      final recipe = GAllRecipesData_recipes((b) => b
        ..name = recipeName
        ..ingredients.addAll(ingredientNames.map(
          (ingredient) => GAllRecipesData_recipes_ingredients(
              (c) => c..ingredient.name = ingredient),
        )));

      var widget = TestRecipeCard(recipe);
      await tester.pumpWidget(widget);

      expect(find.text("[Ingredients]"), findsOneWidget);
      for (var ingredient in ingredientNames) {
        expect(find.text(ingredient), findsOneWidget);
      }
    });

    testWidgets('displays recipe steps', (tester) async {
      final recipe = GAllRecipesData_recipes((b) => b
        ..name = recipeName
        ..steps.addAll(steps.map(
          (step) => GAllRecipesData_recipes_steps((c) => c..text = step),
        )));

      var widget = TestRecipeCard(recipe);
      await tester.pumpWidget(widget);

      expect(find.text("[Steps]"), findsOneWidget);
      for (var step in steps) {
        expect(find.text(step), findsOneWidget);
      }
    });
  });
}
