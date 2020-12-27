import 'package:flutter/material.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/root.dart';
import 'package:myapp/screens/LoginSignUpPage.dart';
import 'package:myapp/screens/homePage.dart';
import 'package:myapp/screens/LoginSignUpPage.dart';
import 'package:myapp/screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:myapp/tools/router_paths.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/firebase_authentication_service.dart';
import 'navigation/router.dart' as myRouter;
var showProfileSetUp = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await isFirstRun();
  runApp(MajorMapInitiativeApp());
}
Future<bool> isFirstRun() async {
  final preferences = await SharedPreferences.getInstance();
  showProfileSetUp = (preferences.getBool('showProfileSetup') ?? false);
  return (preferences.getBool('firstRun') ?? true);
}


class MajorMapInitiativeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: List<SingleChildWidget>.of([ ChangeNotifierProvider<UserProvider>(
        create: (_){
          return UserProvider();
        },
        lazy: false,
      )]),
      child: MaterialApp(
        title: "Major Map Initiative App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "SFPro"),
        initialRoute:  RoutePaths.Login,
        onGenerateRoute: myRouter.Router.generateRoute,
      ),
    );
  }
}
