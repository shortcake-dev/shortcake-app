import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shortcake/shortcake.dart';

class ShortcakeHomepage extends StatefulWidget {
  @override
  _ShortcakeHomepageState createState() => _ShortcakeHomepageState();
}

class _ShortcakeHomepageState extends State<ShortcakeHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<ShortcakeApi>(context, listen: false).introspect(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('none');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('active/waiting');
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
