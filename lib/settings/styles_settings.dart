import 'package:flutter/material.dart';

class StylesSettings {
  static ThemeData lightTheme(BuildContext? context) {
    final theme = ThemeData.light();
    return theme.copyWith(
        colorScheme: Theme.of(context!).colorScheme.copyWith(
              primary: Color.fromARGB(255, 172, 214, 218),
            ),
        iconTheme: IconThemeData(color: Color.fromRGBO(27, 32, 49, 1)),
        textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)));
  }

  static ThemeData darkTheme(BuildContext? context) {
    final theme = ThemeData.dark();
    return theme.copyWith(
        colorScheme: Theme.of(context!).colorScheme.copyWith(
              primary: Color.fromARGB(255, 22, 48, 44),
            ),
        iconTheme: IconThemeData(color: Colors.black26),
        textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.grey)));
  }

  static ThemeData skyTheme(BuildContext? context) {
    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context!)
          .colorScheme
          .copyWith(primary: Color.fromRGBO(249, 230, 226, 1)),
      dialogBackgroundColor: Color.fromRGBO(177, 207, 235, 1),
      buttonTheme:
          ButtonThemeData(buttonColor: Color.fromRGBO(90, 133, 169, 1)),
      backgroundColor: Color.fromRGBO(191, 187, 203, 1),
      iconTheme: IconThemeData(color: Colors.blueGrey),
      textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.blueGrey)),
    );
  }
}
