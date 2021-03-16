import 'package:flutter/material.dart';

import 'homepage/homepage.dart';

void main() {
  runApp(ShortcakeApp());
}

class ShortcakeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Shortcake', home: ShortcakeHomepage());
  }
}
