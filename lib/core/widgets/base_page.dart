import 'package:flutter/material.dart';

/// Should serve as the root widget of all pages within the application
class ShortcakePage extends StatelessWidget {
  final Widget body;

  ShortcakePage({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: AppBar(
        title: const Text('Shortcake'),
        leading: const Icon(Icons.cake),
      ),
    );
  }
}
