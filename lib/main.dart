import 'package:flutter/material.dart';

import 'package:soco/ui/core/styles/themes.dart';
import 'package:soco/ui/core/ui/layouts/app_shell.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'soco',
      theme: SocoTheme.lightTheme,
      darkTheme: SocoTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AppShell(),
    );
  }
}
