import 'package:built_collection/built_collection.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shortcake_app/feature/homepage/widgets/recipe_card.dart';
import 'package:shortcake_app/feature/homepage/graphql/all_recipes.data.gql.dart';
import 'package:shortcake_app/feature/homepage/graphql/all_recipes.req.gql.dart';
import 'package:shortcake_app/feature/homepage/graphql/all_recipes.var.gql.dart';
import 'package:shortcake_app/graphql/api_client.dart';

class ShortcakeHomepage extends StatefulWidget {
  @override
  _ShortcakeHomepageState createState() => _ShortcakeHomepageState();
}

class _ShortcakeHomepageState extends State<ShortcakeHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Operation(
        client: Provider.of<ShortcakeApi>(context, listen: false),
        operationRequest: GAllRecipesReq(),
        builder: (
          BuildContext context,
          OperationResponse<GAllRecipesData, GAllRecipesVars>? response,
          Object? error, // TODO: When is this not null?
        ) {
          if (response == null) {
            return Text("response is null");
          } else if (response.linkException != null) {
            return Text(response.linkException.toString());
          } else if (response.graphqlErrors != null) {
            return Text(response.graphqlErrors.toString());
          } else if (response.loading) {
            return Text("loading");
          }

          final recipes = response.data?.recipes ?? BuiltList();

          return ListView(
            children: recipes.map((recipe) => RecipeCard(recipe)).toList(),
          );
        },
      ),
    );
  }
}
