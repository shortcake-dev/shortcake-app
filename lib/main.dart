import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcake/shortcake.dart';

import 'homepage/homepage.dart';

void main() {
  runApp(ShortcakeClient());
}

class ShortcakeClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<ShortcakeApi>(
      create: (_) => ShortcakeApi("http://localhost:8000"),
      child: MaterialApp(title: 'Shortcake', home: ShortcakeHomepage()),
    );
  }
}
