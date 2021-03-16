import 'package:flutter/material.dart';

void main() {
  runApp(ShortcakeApp());
}

class ShortcakeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shortcake',
      home: ShortcakeHomePage()
    );
  }
}

class ShortcakeHomePage extends StatelessWidget {
  ShortcakeHomePage(): super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text('Shortcake')
    );
  }
}
