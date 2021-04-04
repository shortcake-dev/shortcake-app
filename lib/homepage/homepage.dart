import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';
import 'package:shortcake/shortcake.dart';

class ShortcakeHomepage extends StatefulWidget {
  @override
  _ShortcakeHomepageState createState() => _ShortcakeHomepageState();
}

class _ShortcakeHomepageState extends State<ShortcakeHomepage> {
  late Future<QueryResult> _introspectionFuture;

  @override
  void initState() {
    super.initState();

    final shortcakeApi = Provider.of<ShortcakeApi>(context, listen: false);
    _introspectionFuture = shortcakeApi.introspect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _introspectionFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('none');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('loading');
            case ConnectionState.done:
              return Text(snapshot.data.toString());
            default:
              return Text('default');
          }
        },
      ),
    );
  }
}
