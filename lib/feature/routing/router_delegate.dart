import 'package:beamer/beamer.dart';
import 'package:shortcake_app/feature/homepage/homepage.dart';
import 'package:shortcake_app/feature/recipe_page/recipe_page.dart';

class ShortcakeRouterDelegate extends BeamerRouterDelegate {
  ShortcakeRouterDelegate()
      : super(
          locationBuilder: SimpleLocationBuilder(routes: {
            '/': (context) => ShortcakeHomepage(),
            '/recipes/:recipeId': (context) => RecipePage(
                context.currentBeamLocation.state.pathParameters['recipeId']!),
          }),
        );
}
