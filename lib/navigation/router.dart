import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/navigation/route_paths.dart';
import 'package:myapp/screens/LoginSignUpPage.dart';
import 'package:myapp/screens/homePage.dart';
import 'package:myapp/screens/login_page.dart';
import 'package:myapp/screens/profileSetUp.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RoutePaths.LoginProfile:
        return MaterialPageRoute(builder: (_) => ProfileSetUp());
    }
  }
}