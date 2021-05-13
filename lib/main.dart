import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:shortcake_app/feature/shortcake_app/shortcake_app.dart';

void main() {
  Beamer.setPathUrlStrategy();
  runApp(ShortcakeClient());
}
