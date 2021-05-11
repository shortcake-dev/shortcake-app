import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:shortcake_app/feature/recipe_page/graphql/complete_recipe.data.gql.dart';

class RecipeCard extends StatelessWidget {
  final GCompleteRecipeData_recipe recipe;

  RecipeCard(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(recipe.name),
        if (recipe.description != null) Text(recipe.description!),
        Text('[Ingredients]'),
        RecipeIngredientList(recipe.ingredients),
        Text('[Steps]'),
        RecipeStepList(recipe.steps),
        Text(''),
      ],
    );
  }
}

class RecipeStepList extends StatelessWidget {
  final BuiltList<GCompleteRecipeData_recipe_steps> steps;

  RecipeStepList(this.steps);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          ListTile(
            leading: Text('${i + 1}'),
            title: Text(steps[i].text),
          )
      ],
    );
  }
}

class RecipeIngredientList extends StatelessWidget {
  final BuiltList<GCompleteRecipeData_recipe_ingredients> ingredients;

  RecipeIngredientList(this.ingredients);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ingredients
          .map((ingredient) => ListTile(
                leading: Text(ingredient.measurement),
                title: Text(ingredient.ingredient.name),
              ))
          .toList(),
    );
  }
}
