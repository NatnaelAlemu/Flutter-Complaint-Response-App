import 'package:flutter/material.dart';
import 'package:frontend/screens/errorScreen.dart';
import 'package:frontend/screens/screens.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    String? route = settings.name;

    switch (route) {
      case ('/'):
        return MaterialPageRoute(builder: (context) => Homepage());
      case (SignupScreen.routeName):
        return MaterialPageRoute(builder: (context) => SignupScreen());
      case (ComplaintScreen.routeName):
        return MaterialPageRoute(builder: (context) => ComplaintScreen());
      default:
        return MaterialPageRoute(builder: (context) => ErrorScreen());

    }
  }
}
