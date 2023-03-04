import 'package:flutter/material.dart';
import 'package:primer_proyecto/provider/them_provider.dart';
import 'package:primer_proyecto/routes.dart';
import 'package:primer_proyecto/screens/login_screen.dart';
import 'package:primer_proyecto/screens/on_boarging_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(context)),
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
      theme: theme.getthemeData(),
      routes: getApplicationRoutes(),
      home: OnBoardingScreen(),
    );
  }
}
