import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/navigation/router_paths.dart';
import 'package:myapp/screens/home_page.dart';
import 'package:myapp/screens/login_page.dart';
import 'package:myapp/screens/profile_page.dart';
import 'package:myapp/screens/signup_page.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RoutePaths.Profile:
        return MaterialPageRoute(builder: (_) => ProfileSetUp());
      case RoutePaths.SignUp:
        return MaterialPageRoute(builder: (_) => SignupPage());
    }
  }
}
