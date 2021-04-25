import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shortcake_app/feature/homepage/graphql/all_recipes.data.gql.dart';
import 'package:shortcake_app/feature/homepage/widgets/recipe_card.dart';

class TestRecipeCard extends RecipeCard {
  TestRecipeCard(GAllRecipesData_recipes recipe) : super(recipe);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Material(child: super.build(context)));
  }
}

class TestRecipeStepList extends RecipeStepList {
  TestRecipeStepList(BuiltList<GAllRecipesData_recipes_steps> steps)
      : super(steps);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Material(child: super.build(context)));
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

      final widget = TestRecipeCard(recipe);

      // One pump builds widget with uncompleted Future
      await tester.pumpWidget(widget);

      expect(find.text(recipeName), findsOneWidget);
    });

    testWidgets('displays recipe description', (tester) async {
      final recipe = GAllRecipesData_recipes((b) => b
        ..name = recipeName
        ..description = recipeDescription);

      final widget = TestRecipeCard(recipe);
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

      final widget = TestRecipeCard(recipe);
      await tester.pumpWidget(widget);

      expect(find.text("[Ingredients]"), findsOneWidget);
      for (final ingredient in ingredientNames) {
        expect(find.text(ingredient), findsOneWidget);
      }
    });

    testWidgets('displays recipe steps', (tester) async {
      final recipe = GAllRecipesData_recipes((b) => b
        ..name = recipeName
        ..steps.addAll(steps.map(
          (step) => GAllRecipesData_recipes_steps((c) => c..text = step),
        )));

      final widget = TestRecipeCard(recipe);
      await tester.pumpWidget(widget);

      expect(find.text("[Steps]"), findsOneWidget);
      expect(find.byType(RecipeStepList), findsOneWidget);
    });
  });

  group("RecipeStepList widget", () {
    final steps = ["get bread", "spread peanut butter", "add banana"];

    testWidgets('contains recipe steps', (tester) async {
      final recipeSteps =
          BuiltList<GAllRecipesData_recipes_steps>.from(steps.map(
        (step) => GAllRecipesData_recipes_steps((c) => c..text = step),
      ));

      final widget = TestRecipeStepList(recipeSteps);
      await tester.pumpWidget(widget);

      for (final step in steps) {
        expect(find.text(step), findsOneWidget);
      }
    });

    testWidgets('has indices for each step, indexing at 1', (tester) async {
      final recipeSteps =
          BuiltList<GAllRecipesData_recipes_steps>.from(steps.map(
        (step) => GAllRecipesData_recipes_steps((c) => c..text = step),
      ));

      final widget = TestRecipeStepList(recipeSteps);
      await tester.pumpWidget(widget);

      for (var i = 1; i < steps.length + 1; i++) {
        expect(find.text(i.toString()), findsOneWidget);
      }
    });
  });
}
