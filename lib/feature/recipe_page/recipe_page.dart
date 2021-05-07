import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcake_app/feature/recipe_page/graphql/complete_recipe.data.gql.dart';
import 'package:shortcake_app/feature/recipe_page/graphql/complete_recipe.req.gql.dart';
import 'package:shortcake_app/feature/recipe_page/graphql/complete_recipe.var.gql.dart';
import 'package:shortcake_app/feature/recipe_page/widgets/recipe_card.dart';
import 'package:shortcake_app/graphql/api_client.dart';

class RecipePage extends StatefulWidget {
  final String recipeId;
  // late final GCompleteRecipeData_recipe recipe;

  RecipePage(this.recipeId);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Operation(
        client: Provider.of<ShortcakeApi>(context, listen: false),
        operationRequest: GCompleteRecipeReq(
          (b) => b..vars.recipe_id = widget.recipeId,
        ),
        builder: (
          BuildContext context,
          OperationResponse<GCompleteRecipeData, GCompleteRecipeVars>? response,
          Object? error, // TODO: When is this not null?
        ) {
          if (response == null) {
            return Text('response is null');
          } else if (response.linkException != null) {
            return Text(response.linkException.toString());
          } else if (response.graphqlErrors != null) {
            return Text(response.graphqlErrors.toString());
          } else if (response.loading) {
            return Text('loading');
          }

          final recipe = response.data?.recipe;

          return RecipeCard(recipe!); // TODO: Can recipe be null?
        },
      ),
    );
  }
}
