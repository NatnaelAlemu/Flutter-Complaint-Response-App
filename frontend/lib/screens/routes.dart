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
      case AdminScreen.routeName:
        return MaterialPageRoute(builder: (context) => AdminScreen());
      case AddComplaint.routeName:
        return MaterialPageRoute(builder: (_) => AddComplaint());
      case AllAndFixedComplaintScreen.routeName:
        return MaterialPageRoute(builder: (_) => AllAndFixedComplaintScreen());
      default:
        return MaterialPageRoute(builder: (context) => ErrorScreen());
    }
  }
}
