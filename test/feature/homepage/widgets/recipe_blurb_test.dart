import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shortcake_app/feature/homepage/graphql/recipe_summaries.data.gql.dart';
import 'package:shortcake_app/feature/homepage/widgets/recipe_blurb.dart';

class TestRecipeBlurb extends RecipeBlurb {
  TestRecipeBlurb(GRecipeSummariesData_recipes recipeSummary)
      : super(recipeSummary);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Material(child: super.build(context)));
  }
}

void main() {
  group('RecipeBlurb widget', () {
    const recipeId = 'some_id';
    const recipeName = 'Water';
    const recipeDescription = 'Keeping it simple 💦';

    testWidgets('displays recipe title', (tester) async {
      final recipeSummary = GRecipeSummariesData_recipes(
        (b) => b
          ..id = recipeId
          ..name = recipeName
          ..description = recipeDescription,
      );

      final widget = TestRecipeBlurb(recipeSummary);
      await tester.pumpWidget(widget);

      expect(find.text(recipeName), findsOneWidget);
    });

    testWidgets('displays recipe description', (tester) async {
      final recipeSummary = GRecipeSummariesData_recipes(
        (b) => b
          ..id = recipeId
          ..name = recipeName
          ..description = recipeDescription,
      );

      final widget = TestRecipeBlurb(recipeSummary);
      await tester.pumpWidget(widget);

      expect(find.text(recipeDescription), findsOneWidget);
    });

    testWidgets('works for recipes without description', (tester) async {
      final recipeSummary = GRecipeSummariesData_recipes(
        (b) => b
          ..id = recipeId
          ..name = recipeName
          ..description = null,
      );

      final widget = TestRecipeBlurb(recipeSummary);
      await tester.pumpWidget(widget);

      expect(find.text(recipeName), findsOneWidget);
    });
  });
}
