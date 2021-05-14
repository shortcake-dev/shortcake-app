import 'package:flutter/material.dart';
import 'package:shortcake_app/core/graphql_widget.dart';
import 'package:shortcake_app/feature/recipe_page/graphql/complete_recipe.data.gql.dart';
import 'package:shortcake_app/feature/recipe_page/graphql/complete_recipe.req.gql.dart';
import 'package:shortcake_app/feature/recipe_page/widgets/recipe_card.dart';

class RecipePage extends StatelessWidget {
  final String recipeId;

  RecipePage(this.recipeId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GraphQLWidget(
        operationRequest: GCompleteRecipeReq(
          (b) => b..vars.recipe_id = recipeId,
        ),
        onData: (GCompleteRecipeData data) => RecipeCard(data.recipe),
        onLoading: (_) => Text('Loading'),
      ),
    );
  }
}
