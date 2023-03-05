import 'package:flutter/material.dart';
import 'package:primer_proyecto/settings/styles_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;
  ThemeProvider(int theme, BuildContext context) {
    setThemeData(theme, context);
  }

  getThemeData() => this._themeData;
  setThemeData(int? index, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (index) {
      case 1:
        _themeData = StylesSettings.darkTheme(context);
        sharedPreferences.setInt('theme', 1);
        break;
      case 2:
        _themeData = StylesSettings.skyTheme(context);
        sharedPreferences.setInt('theme', 2);
        break;
      case 3:
      default:
        _themeData = StylesSettings.lightTheme(context);
        sharedPreferences.setInt('theme', 0);
        break;
    }
    notifyListeners();
  }
}
