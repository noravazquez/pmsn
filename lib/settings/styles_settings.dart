import 'package:flutter/material.dart';

class StylesSettings {
  static ThemeData lightTheme(BuildContext? context) {
    final theme = ThemeData.light();
    return theme.copyWith(
        colorScheme: Theme.of(context!).colorScheme.copyWith(
            primary: Color.fromARGB(255, 172, 214, 218),
            secondary: Colors.cyan),
        iconTheme: IconThemeData(color: Color.fromRGBO(27, 32, 49, 1)),
        textTheme: TextTheme(
            bodyMedium: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(color: Colors.black),
            labelLarge: TextStyle(fontSize: 18.0, color: Colors.black),
            titleLarge: TextStyle(fontSize: 20.0, color: Colors.black),
            titleMedium: TextStyle(fontSize: 22.0, color: Colors.black)));
  }

  static ThemeData darkTheme(BuildContext? context) {
    final theme = ThemeData.dark();
    return theme.copyWith(
        colorScheme: Theme.of(context!).colorScheme.copyWith(
            primary: Color.fromARGB(255, 22, 48, 44),
            secondary: Color.fromRGBO(45, 80, 75, 1)),
        iconTheme: IconThemeData(color: Colors.white70),
        textTheme: TextTheme(
            bodyMedium: TextStyle(
                fontSize: 15.0,
                color: Colors.white60,
                fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(color: Colors.white),
            labelLarge: TextStyle(fontSize: 18.0, color: Colors.white),
            titleLarge: TextStyle(fontSize: 20.0, color: Colors.white60),
            titleMedium: TextStyle(fontSize: 22.0, color: Colors.white70)));
  }

  static ThemeData skyTheme(BuildContext? context) {
    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context!).colorScheme.copyWith(
          primary: Color.fromRGBO(199, 186, 245, 1),
          secondary: Color.fromRGBO(250, 226, 224, 1)),
      dialogBackgroundColor: Color.fromRGBO(199, 208, 215, 1),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Color.fromRGBO(199, 208, 215, 1)),
      iconTheme: IconThemeData(color: Color.fromRGBO(79, 91, 103, 1)),
      textTheme: TextTheme(
          bodyMedium: TextStyle(
              fontSize: 15.0,
              color: Color.fromRGBO(101, 120, 137, 1),
              fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Color.fromRGBO(79, 91, 103, 1)),
          labelLarge:
              TextStyle(fontSize: 18.0, color: Color.fromRGBO(79, 91, 103, 1)),
          titleLarge: TextStyle(
              fontSize: 20.0, color: Color.fromRGBO(101, 120, 137, 1)),
          titleMedium: TextStyle(
              fontSize: 22.0, color: Color.fromRGBO(101, 120, 137, 1))),
    );
  }
}
