import 'package:flutter/material.dart';
import 'package:myapp/root.dart';
import 'package:myapp/screens/LoginSignUpPage.dart';
import 'package:myapp/screens/homePage.dart';
import 'package:myapp/screens/LoginSignUpPage.dart';

import 'BaseAuth.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    brightness: Brightness.dark,
  ),
  home:new RootPage(auth: new Auth())
));


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return homePage();
  }
}
