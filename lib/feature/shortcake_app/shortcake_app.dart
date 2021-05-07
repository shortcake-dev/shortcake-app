import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:shortcake_app/feature/homepage/homepage.dart';
import 'package:shortcake_app/feature/recipe_page/recipe_page.dart';

class ShortcakeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shortcake',
      routeInformationParser: BeamerRouteInformationParser(),
      routerDelegate: BeamerRouterDelegate(
        locationBuilder: SimpleLocationBuilder(
          routes: {
            '/': (context) => ShortcakeHomepage(),
            '/recipes/:recipeId': (context) => RecipePage(
                context.currentBeamLocation.state.pathParameters['recipeId']!),
          },
        ),
      ),
    );
  }
}
