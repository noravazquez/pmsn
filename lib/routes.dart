import 'package:flutter/material.dart';
import 'package:primer_proyecto/screens/dashboard_screen.dart';
import 'package:primer_proyecto/screens/login_screen.dart';
import 'package:primer_proyecto/screens/on_boarging_screen.dart';
import 'package:primer_proyecto/screens/register_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash': (BuildContext context) => DashboardScreen(),
    '/login': (BuildContext context) => LoginScreen(),
    '/onboarding': (BuildContext context) => OnBoardingScreen(),
  };
}
