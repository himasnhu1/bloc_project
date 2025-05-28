import 'dart:async';

import 'package:bloc_project/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(
            context, RouteName.loginScreen, (route) => false));
  }
}
