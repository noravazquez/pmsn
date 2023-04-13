import 'package:flutter/material.dart';
import 'package:primer_proyecto/screens/add_post_screen.dart';
import 'package:primer_proyecto/screens/category_screen.dart';
import 'package:primer_proyecto/screens/dashboard_screen.dart';
import 'package:primer_proyecto/screens/events_screen.dart';
import 'package:primer_proyecto/screens/list_popular_videos.dart';
import 'package:primer_proyecto/screens/login_screen.dart';
import 'package:primer_proyecto/screens/movies_favs_screen.dart';
import 'package:primer_proyecto/screens/on_boarging_screen.dart';
import 'package:primer_proyecto/screens/register_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash': (BuildContext context) => DashboardScreen(),
    '/login': (BuildContext context) => LoginScreen(),
    '/onboarding': (BuildContext context) => OnBoardingScreen(),
    '/add': (BuildContext context) => AddPostScreen(),
    '/events': (BuildContext context) => Eventos(),
    '/popular': (BuildContext context) => ListPopularVideo(),
    '/moviesFavs': (BuildContext context) => MoviesFavsScreen(),
    '/categoryBooks': (BuildContext context) => CategoryScreen(),
  };
}
