import 'package:flutter/material.dart';

import 'package:soco/styles/themes.dart';
import 'package:soco/shared/layouts/app_shell.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'soco',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Automatically matches device theme
      home: const AppShell(),
    );
  }
}
