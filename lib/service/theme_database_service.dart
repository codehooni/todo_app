import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ThemeDatabaseService {
  final Box _box = Hive.box('theme_mode');

  ThemeMode getThemeMode() {
    if (_box.isEmpty) {
      return ThemeMode.system;
    }
    final themeIndex = _box.values.first as int;
    return ThemeMode.values[themeIndex];
  }

  void setThemeMode(ThemeMode themeMode) {
    _box.clear();
    _box.add(themeMode.index);
  }
}
