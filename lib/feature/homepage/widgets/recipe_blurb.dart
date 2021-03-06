import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:shortcake_app/feature/homepage/graphql/recipe_summaries.data.gql.dart';

class RecipeBlurb extends StatelessWidget {
  final GRecipeSummariesData_recipes recipeSummary;

  RecipeBlurb(this.recipeSummary);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Beamer.of(context).beamToNamed('recipes/${recipeSummary.id}');
      },
      child: Card(
        child: Column(
          children: [
            Text(recipeSummary.name),
            if (recipeSummary.description != null)
              Text(recipeSummary.description!),
          ],
        ),
      ),
    );
  }
}
