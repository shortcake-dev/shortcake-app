import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcake_app/feature/routing/router_delegate.dart';
import 'package:shortcake_app/graphql/api_client.dart';

class ShortcakeClient extends StatelessWidget {
  // https://github.com/slovnicki/beamer/issues/193#issuecomment-821095836
  final _routerDelegate = ShortcakeDelegate();

  @override
  Widget build(BuildContext context) {
    return Provider<ShortcakeApi>(
      create: (_) => ShortcakeApi('http://localhost:8000'),
      child: MaterialApp.router(
        title: 'Shortcake',
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate,
      ),
    );
  }
}
