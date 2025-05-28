import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'routes_name.dart';
import 'package:bloc_project/views/view.dart';

class Routes {

  static Route<dynamic>? genrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      default:
        MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text('No route Generated'),
                  ),
                ));
    }
    return null;
  }
}
