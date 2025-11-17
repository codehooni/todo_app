import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/service/theme_database_service.dart';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

class ThemeNotifier extends Notifier<ThemeMode> {
  final ThemeDatabaseService themeDatabaseService = ThemeDatabaseService();

  @override
  ThemeMode build() {
    return themeDatabaseService.getThemeMode();
  }

  void setThemeMode(ThemeMode themeMode) {
    state = themeMode;
    themeDatabaseService.setThemeMode(themeMode);
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
    } else {
      setThemeMode(ThemeMode.light);
    }
  }
}
