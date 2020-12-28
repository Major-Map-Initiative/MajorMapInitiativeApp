import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/root.dart';
import 'package:myapp/screens/home_page.dart';
import 'package:myapp/screens/login_page.dart';
import 'package:myapp/screens/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:myapp/navigation/router_paths.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/firebase_authentication_service.dart';
import 'navigation/router.dart' as myRouter;

var showProfileSetUp = false;
bool loggedInUser;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loggedInUser = await checkIfLoggedIn();
  runApp(MajorMapInitiativeApp());
}

Future<bool> isFirstRun() async {
  final preferences = await SharedPreferences.getInstance();
  showProfileSetUp = (preferences.getBool('showProfileSetup') ?? false);
  return (preferences.getBool('firstRun') ?? true);
}

Future<bool> checkIfLoggedIn() async {
  return UserProvider().isLoggedIn();
}

class MajorMapInitiativeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: List<SingleChildWidget>.of([
        ChangeNotifierProvider<UserProvider>(
          create: (_) {
            return UserProvider();
          },
          lazy: false,
        )
      ]),
      child: MaterialApp(
          title: "Major Map Initiative App",
          debugShowCheckedModeBanner: false,
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
              fontFamily: "SFPro",
              primaryColor: MaterialColor(
                0xFF182B49,
                <int, Color>{},
              ),
              textTheme: TextTheme(
                headline6: TextStyle(color: Colors.black),
                bodyText1: TextStyle(color: Colors.black),
                headline1: TextStyle(color: Colors.black),
              ),
              appBarTheme: AppBarTheme(
                  color: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                  textTheme: TextTheme(
                    headline6: TextStyle(color: Colors.black, fontSize: 20),
                    bodyText1: TextStyle(color: Colors.black),
                    headline1: TextStyle(color: Colors.black),
                  )),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.grey.shade200,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey,
                unselectedLabelStyle: TextStyle(color: Colors.grey),
                showUnselectedLabels: true,
                selectedItemColor: MaterialColor(
                  0xFF182B49,
                  <int, Color>{},
                ),
              ),
              cupertinoOverrideTheme:
                  CupertinoThemeData(primaryColor: CupertinoColors.black)),
          darkTheme: ThemeData(
            fontFamily: "SFPro",
            primaryColor: MaterialColor(
              0xFF182B49,
              <int, Color>{},
            ),
            textTheme: TextTheme(
                bodyText1: TextStyle(color: Colors.white),
                headline1: TextStyle(color: Colors.white),
                button: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
                color: Colors.grey.shade900,
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                textTheme: TextTheme(
                  headline6: TextStyle(color: Colors.white, fontSize: 20),
                  button: TextStyle(color: Colors.white),
                  bodyText1: TextStyle(color: Colors.white),
                  headline1: TextStyle(color: Colors.white),
                )),
            scaffoldBackgroundColor: Colors.grey.shade900,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.grey.shade900,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey.shade200,
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              showUnselectedLabels: true,
              selectedItemColor: Colors.blue,
            ),
            cupertinoOverrideTheme: CupertinoThemeData(
              primaryColor: CupertinoColors.white,
              scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
              barBackgroundColor: CupertinoColors.darkBackgroundGray,
              textTheme: CupertinoTextThemeData(
                navActionTextStyle: TextStyle(color: CupertinoColors.white),
                navTitleTextStyle: TextStyle(color: CupertinoColors.white),
              ),
            ),
          ),
          initialRoute: loggedInUser ? RoutePaths.Home : RoutePaths.Login,
          onGenerateRoute: myRouter.Router.generateRoute,
          routes: {RoutePaths.Profile: (context) => LoginPage()},
          onUnknownRoute: (RouteSettings setting) {
            String unknownRoute = setting.name;
            return new MaterialPageRoute(builder: (context) => ProfileSetUp());
          }),
    );
  }
}
