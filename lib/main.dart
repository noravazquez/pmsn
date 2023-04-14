import 'package:flutter/material.dart';
import 'package:primer_proyecto/provider/flags_provider.dart';
import 'package:primer_proyecto/provider/them_provider.dart';
import 'package:primer_proyecto/routes.dart';
import 'package:primer_proyecto/screens/category_screen.dart';
import 'package:primer_proyecto/screens/on_boarging_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final themeSelect = sharedPreferences.getInt('theme') ?? 0;
  runApp(MyApp(themeSelect: themeSelect));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.themeSelect, super.key});

  final int themeSelect;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeProvider(themeSelect, context)),
        ChangeNotifierProvider(create: (_) => FlagsProvider())
      ],
      child: PMSNApp(),
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: theme.getThemeData(),
      routes: getApplicationRoutes(),
      home: OnBoardingScreen(),
    );
  }
}
