import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shortcake_app/core/widgets/graphql_widget.dart';
import 'package:shortcake_app/core/widgets/base_page.dart';
import 'package:shortcake_app/feature/homepage/graphql/recipe_summaries.data.gql.dart';
import 'package:shortcake_app/feature/homepage/graphql/recipe_summaries.req.gql.dart';
import 'package:shortcake_app/feature/homepage/widgets/recipe_blurb.dart';

class ShortcakeHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShortcakePage(
      body: GraphQLWidget(
        operationRequest: GRecipeSummariesReq(),
        onData: (GRecipeSummariesData data) => ListView(
          children: data.recipes.map((recipe) => RecipeBlurb(recipe)).toList(),
        ),
        onLoading: (_) => Text('loading'),
      ),
    );
  }
}
