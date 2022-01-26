import 'package:crypto_app/models/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  ThemeProvider(String theme) {
    if (theme == "light") {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }

  void toggleTheme() async {
    if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
      LocalStorage.saveTheme("light");
    } else {
      themeMode = ThemeMode.dark;
      LocalStorage.saveTheme("dark");
    }

    notifyListeners();
  }
}
