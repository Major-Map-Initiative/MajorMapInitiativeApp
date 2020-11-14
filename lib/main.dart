import 'package:flutter/material.dart';
import 'package:myapp/root.dart';
import 'package:myapp/screens/LoginSignUpPage.dart';
import 'package:myapp/screens/homePage.dart';
import 'package:myapp/screens/LoginSignUpPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BaseAuth.dart';
import 'navigation/router.dart' as myRouter;
var showProfileSetUp = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await isFirstRun();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: myRouter.Router.generateRoute,
      home: new RootPage(auth: new Auth(), showProfileSetUp: showProfileSetUp,)
  ));
}
Future<bool> isFirstRun() async {
  final preferences = await SharedPreferences.getInstance();
  showProfileSetUp = (preferences.getBool('showProfileSetup') ?? false);
  return (preferences.getBool('firstRun') ?? true);
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
