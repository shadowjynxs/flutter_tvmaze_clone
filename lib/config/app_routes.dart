import 'package:flutter/material.dart';
import 'package:tvmaze/presentation/screens/home_screen.dart';
import 'package:tvmaze/presentation/screens/search_screen.dart';
import 'package:tvmaze/presentation/screens/splash_screen.dart';

class AppRoutes {
  static const String homeScreen = "/homeScreen";
  static const String searchScreen = "/searchScreen";
  static const String splashScreen = "/splashScreen";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case searchScreen:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
