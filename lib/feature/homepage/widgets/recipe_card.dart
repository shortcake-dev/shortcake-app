import 'package:built_collection/built_collection.dart';
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
        for (final ingredient in recipe.ingredients)
          Text(ingredient.ingredient.name),
        Text('[Steps]'),
        RecipeStepList(recipe.steps),
        Text(''),
      ],
    );
  }
}

class RecipeStepList extends StatelessWidget {
  final BuiltList<GAllRecipesData_recipes_steps> steps;

  RecipeStepList(this.steps);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final entry in steps.asMap().entries)
          ListTile(
            leading: Text("${entry.key}"),
            title: Text(entry.value.text),
          )
      ],
    );
  }
}
