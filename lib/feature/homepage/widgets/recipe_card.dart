import 'package:flutter/material.dart';
import 'package:shortcake_app/feature/homepage/graphql/all_recipes.data.gql.dart';

class RecipeCard extends StatelessWidget {
  final GAllRecipesData_recipes recipe;

  RecipeCard(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(recipe.name),
        if (recipe.description != null) Text(recipe.description!),
        Text('[Ingredients]'),
        for (var ingredient in recipe.ingredients)
          Text(ingredient.ingredient.name),
        Text('[Steps]'),
        for (var step in recipe.steps) Text(step.text),
        Text(''),
      ],
    );
  }
}
