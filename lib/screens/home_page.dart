import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/navigation/router_paths.dart';
import 'package:myapp/navigation/router.dart' as appRouter;
import 'package:myapp/screens/LoginSignUpPage.dart';
import 'package:myapp/screens/profile.dart';
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
    
    return !Platform.isIOS ?
    Scaffold(
    appBar: AppBar(
      leading: Container(),
      centerTitle: true,
      title: Text("Major Map Initiative"),
     actions: [IconButton(
       icon: Icon(defaultIcons.Icons.person),
       onPressed: (){
         Navigator.of(context ).push(
           new MaterialPageRoute(
               fullscreenDialog: true,
               builder: (_) => ProfileSetUp()
           ),
         );
       },
     )],
    ),
      body: Center(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(defaultIcons.Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon:  Icon(defaultIcons.Icons.map),
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

    ) :  CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          onTap: (index){

          },
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
    items: <BottomNavigationBarItem> [
    BottomNavigationBarItem(
      icon: Icon(defaultIcons.Icons.home),
      label: "Home",
    ),
      BottomNavigationBarItem(
        icon:  Icon(defaultIcons.Icons.map),
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
    tabBuilder: (BuildContext context, int index){
      return CupertinoTabView(
        onGenerateRoute: appRouter.Router.generateRoute,
        builder: (BuildContext context) {
          return CupertinoPageScaffold(
         //   backgroundColor: CupertinoColors.darkBackgroundGray,
            navigationBar: CupertinoNavigationBar(
              middle: Text('Major Map Initiative',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              trailing: CupertinoButton(
                child: Icon(defaultIcons.Icons.person,
                  //color: CupertinoColors.black,
                ),
                onPressed: (){
                  Navigator.of(context ).push(
                    new CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (_) => ProfileSetUp()
                    ),
                  );                },
              )
            ),
            child: Center(
              child: CupertinoButton(
                child: const Text('Next page'),
                onPressed: () {
                  Navigator.pushNamed(context,RoutePaths.Profile);
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

  String sayHello() {
    String hello;

    DateTime today = new DateTime.now();
    int hour = today.hour;

    if (hour < 12) {
      hello = "Good morning";
    } else if (hour < 18) {
      hello = "Good afternoon";
    } else {
      hello = "Good evening";
    }
    return hello + " Peter.";
  }

  String tellDate() {
    DateTime today = new DateTime.now();
    int month = today.month;
    int year = today.year;
    int weekday = today.weekday;
    int day = today.day;

    String toReturn = "It is " +
        tellWeekday(weekday) +
        ", " +
        tellMonth(month) +
        " " +
        day.toString() +
        " " +
        year.toString();
    return toReturn;
  }

  signOut() async {
    try {
      UserProvider().logOut();
      Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (_) => LoginPage()), ModalRoute.withName(RoutePaths.Login));
    } catch (e) {
      print(e);
    }
  }

  String tellWeekday(int weekday) {
    if (weekday == DateTime.sunday) {
      return "Sunday";
    } else if (weekday == DateTime.monday) {
      return "Monday";
    } else if (weekday == DateTime.tuesday) {
      return "Tuesday";
    } else if (weekday == DateTime.wednesday) {
      return "Wednesday";
    } else if (weekday == DateTime.thursday) {
      return "Thursday";
    } else if (weekday == DateTime.friday) {
      return "Friday";
    } else {
      return "Saturday";
    }
  }

  String tellMonth(int month) {
    if (month == 1) {
      return "January";
    } else if (month == 2) {
      return "February";
    } else if (month == 3) {
      return "March";
    } else if (month == 4) {
      return "April";
    } else if (month == 5) {
      return "May";
    } else if (month == 6) {
      return "June";
    } else if (month == 7) {
      return "July";
    } else if (month == 8) {
      return "August";
    } else if (month == 9) {
      return "September";
    } else if (month == 10) {
      return "October";
    } else if (month == 11) {
      return "November";
    } else {
      return "December";
    }
  }

  String tellTime() {
    String appendix;
    String time;
    DateTime today = new DateTime.now();
    int hour = today.hour;

    appendix = (hour < 12) ? "am" : "pm";

    hour = hour % 12;
    int minute = today.minute;

    String minuteString =
        (minute < 10) ? "0" + minute.toString() : minute.toString();
    time = hour.toString() + ":" + minuteString + " " + appendix;
    return time;
  }

  void expenses(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Welcome to expenses."),
      content: Text("No expenses logged yet"),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
