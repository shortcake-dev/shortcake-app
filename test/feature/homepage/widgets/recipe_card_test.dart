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

class TestRecipeIngredientList extends RecipeIngredientList {
  TestRecipeIngredientList(
      BuiltList<GAllRecipesData_recipes_ingredients> ingredients)
      : super(ingredients);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Material(child: super.build(context)));
  }
}

void main() {
  group("RecipeCard widget", () {
    const recipeName = "Raw oats";
    const recipeDescription = "Literally just oats";
    const ingredientNames = ["oats", "bowl"];
    const measurements = ["1 cup", "1"];
    const steps = ["Get bowl", "Pour oats", "Consume"];

    testWidgets('displays recipe title', (tester) async {
      final recipe = GAllRecipesData_recipes((b) => b..name = recipeName);

      final widget = TestRecipeCard(recipe);
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
        ..ingredients.addAll(List.generate(
          ingredientNames.length,
          (i) => GAllRecipesData_recipes_ingredients((c) => c
            ..ingredient.name = ingredientNames[i]
            ..measurement = measurements[i]),
        )));

      final widget = TestRecipeCard(recipe);
      await tester.pumpWidget(widget);

      expect(find.text("[Ingredients]"), findsOneWidget);
      expect(find.byType(RecipeIngredientList), findsOneWidget);
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

  group("RecipeIngredientList widget", () {
    late final BuiltList<GAllRecipesData_recipes_ingredients> recipeIngredients;
    const ingredients = ["bananas", "chocolate soylent", "oats", "ice cubes"];
    const measurements = ["2", "2 scoops", "1/4 cup", "1 cup"];

    setUpAll(() {
      recipeIngredients = BuiltList.from([
        for (var i = 0; i < ingredients.length; i++)
          GAllRecipesData_recipes_ingredients((b) => b
            ..ingredient.name = ingredients[i]
            ..measurement = measurements[i])
      ]);
    });

    testWidgets('contains recipe ingredients', (tester) async {
      final widget = TestRecipeIngredientList(recipeIngredients);
      await tester.pumpWidget(widget);

      for (final ingredient in ingredients) {
        expect(find.text(ingredient), findsOneWidget);
      }
    });

    testWidgets('contains recipe measurements', (tester) async {
      final widget = TestRecipeIngredientList(recipeIngredients);
      await tester.pumpWidget(widget);

      for (final measurement in measurements) {
        expect(find.text(measurement), findsOneWidget);
      }
    });
  });

  group("RecipeStepList widget", () {
    late final BuiltList<GAllRecipesData_recipes_steps> recipeSteps;
    final steps = ["get bread", "spread peanut butter", "add banana"];

    setUpAll(() {
      recipeSteps = BuiltList.from(steps.map(
        (step) => GAllRecipesData_recipes_steps((c) => c..text = step),
      ));
    });

    testWidgets('contains recipe steps', (tester) async {
      final widget = TestRecipeStepList(recipeSteps);
      await tester.pumpWidget(widget);

      for (final step in steps) {
        expect(find.text(step), findsOneWidget);
      }
    });

    testWidgets('has indices for each step, indexing at 1', (tester) async {
      final widget = TestRecipeStepList(recipeSteps);
      await tester.pumpWidget(widget);

      for (var i = 1; i < steps.length + 1; i++) {
        expect(find.text(i.toString()), findsOneWidget);
      }
    });
  });
}
