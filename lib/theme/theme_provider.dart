import 'package:flutter/material.dart';
import 'package:pdf_reader/theme/themes.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode;

  ThemeProvider() : isDarkMode = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;

  ThemeData get currentTheme => isDarkMode ? darkMode : lightMode;

  void changeTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  void updateThemeBasedOnSystem() {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
    notifyListeners();
  }
}
