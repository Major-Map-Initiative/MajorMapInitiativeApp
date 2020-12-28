import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/navigation/router_paths.dart';
import 'package:myapp/navigation/router.dart' as appRouter;
import 'package:myapp/screens/profile_page.dart';
import 'package:myapp/tools/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_authentication_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/icons.dart' as defaultIcons;
import 'dart:convert';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  final String eventsFeedEndpoint =
      "https://o94b6gq4pf.execute-api.us-west-2.amazonaws.com/qa";
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  Dio dio = new Dio();
  final String eventsFeedEndpoint =
      "https://o94b6gq4pf.execute-api.us-west-2.amazonaws.com/qa";
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return !Platform.isIOS
        ? Scaffold(
            appBar: AppBar(
              leading: Container(),
              centerTitle: true,
              title: Text("Major Map Initiative"),
              actions: [
                IconButton(
                  icon: Icon(defaultIcons.Icons.person),
                  onPressed: () {
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (_) => ProfileSetUp()),
                    );
                  },
                )
              ],
            ),
            body: Center(),
            bottomNavigationBar: BottomNavigationBar(
              onTap: _onItemTapped,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(defaultIcons.Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(defaultIcons.Icons.map),
                  label: "Degree Map",
                ),
                BottomNavigationBarItem(
                  icon: Icon(defaultIcons.Icons.people),
                  label: "Community",
                ),
                BottomNavigationBarItem(
                  icon: Icon(defaultIcons.Icons.calendar_today),
                  label: "Calendar",
                )
              ],
              currentIndex: _selectedIndex,
            ),
          )
        : CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              onTap: (index) {},
              backgroundColor: CupertinoColors.lightBackgroundGray,
              activeColor: MaterialColor(
                0xFF182B49,
                <int, Color>{
                  50: Color(0xFF182B49),
                  100: Color(0xFF182B49),
                  200: Color(0xFF182B49),
                  300: Color(0xFF182B49),
                  400: Color(0xFF182B49),
                  500: Color(0xFF182B49),
                  600: Color(0xFF182B49),
                  700: Color(0xFF182B49),
                  800: Color(0xFF182B49),
                  900: Color(0xFF182B49),
                },
              ),
              inactiveColor: CupertinoColors.inactiveGray,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(defaultIcons.Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(defaultIcons.Icons.map),
                  label: "Degree Roadmap",
                ),
                BottomNavigationBarItem(
                  icon: Icon(defaultIcons.Icons.people),
                  label: "Community",
                ),
                BottomNavigationBarItem(
                  icon: Icon(defaultIcons.Icons.calendar_today),
                  label: "Calendar",
                )
              ],
            ),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoTabView(
                onGenerateRoute: appRouter.Router.generateRoute,
                builder: (BuildContext context) {
                  return CupertinoPageScaffold(
                    //   backgroundColor: CupertinoColors.darkBackgroundGray,
                    navigationBar: CupertinoNavigationBar(
                        middle: Text(
                          'Major Map Initiative',
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: CupertinoButton(
                          child: Icon(
                            defaultIcons.Icons.person,
                            //color: CupertinoColors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              new CupertinoPageRoute(
                                  fullscreenDialog: true,
                                  builder: (_) => ProfileSetUp()),
                            );
                          },
                        )),
                    child: Center(
                      child: CupertinoButton(
                        child: const Text('Next page'),
                        onPressed: () {
                          Navigator.pushNamed(context, RoutePaths.Profile);
                          // Navigator.of(context).push(
                          //   CupertinoPageRoute<void>(
                          //     builder: (BuildContext context) {
                          //       return CupertinoPageScaffold(
                          //         navigationBar: CupertinoNavigationBar(
                          //           middle: Text('Page 2 of tab $index'),
                          //         ),
                          //         child: Center(
                          //           child: CupertinoButton(
                          //             child: const Text('Back'),
                          //             onPressed: () { Navigator.of(context).pop(); },
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // );
                        },
                      ),
                    ),
                  );
                },
              );
            });
  }


  signOut() async {
    try {
      UserProvider().logOut();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
          ModalRoute.withName(RoutePaths.Login));
    } catch (e) {
      print(e);
    }
  }

}
