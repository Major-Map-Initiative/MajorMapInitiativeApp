import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/tools/router_paths.dart';
import 'package:myapp/tools/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_authentication_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/icons.dart' as defaultIcons;
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String eventsFeedEndpoint =
      "https://o94b6gq4pf.execute-api.us-west-2.amazonaws.com/qa";
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dio dio = new Dio();
  final String eventsFeedEndpoint =
      "https://o94b6gq4pf.execute-api.us-west-2.amazonaws.com/qa";
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return !Platform.isIOS ?
    Scaffold(

      backgroundColor: Colors.grey.shade900,
      //backgroundColor: Colors.grey.shade100,
      drawer: Drawer(
        child: Container(
          color: Colors.blueGrey,
          child: ListView(
            padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 2),
            children: <Widget>[
              SizedBox(
                height: SizeConfig.safeBlockVertical * .01,
              ),
              Container(
                height: SizeConfig.safeBlockVertical * 17,
                child: DrawerHeader(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "major map initiative",
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                            letterSpacing: 1,
                            fontFamily: "Comfortaa",
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
                        ),
                        Text(
                          "Peter Gonzalez",
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 2,
                            letterSpacing: 4,
                            fontFamily: "Comfortaa",
                          ),
                        )
                      ]),
                ),
              ),
              ListTile(
                title: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                    fontFamily: "Comfortaa",
                  ),
                ),
                leading: (Icon(
                  defaultIcons.Icons.home,
                )),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Classes',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                    fontFamily: "Comfortaa",
                  ),
                ),
                leading: (Icon(
                  defaultIcons.Icons.book,
                )),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Degree Road Map',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                    fontFamily: "Comfortaa",
                  ),
                ),
                leading: Icon(
                  defaultIcons.Icons.map,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Community',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                    fontFamily: "Comfortaa",
                  ),
                ),
                leading: Icon(
                  defaultIcons.Icons.people,
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                    fontFamily: "Comfortaa",
                  ),
                ),
                leading: (Icon(
                  defaultIcons.Icons.settings,
                )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                    fontFamily: "Comfortaa",
                  ),
                ),
                leading: (Icon(
                  defaultIcons.Icons.exit_to_app,
                )),
                onTap: () {
                  signOut();

                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.blueGrey,
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 0.5,
          ),
        ),
        title: Text(
          "major map initiative",
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 6,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "Comfortaa",
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 4),
          ),
          Center(
            child: Text(
              "Upcoming Important Dates",
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                  letterSpacing: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Comfortaa"),
            ),
          ),
          Container(
            height: SizeConfig.safeBlockVertical * 15,
            padding: EdgeInsets.only(
                left: SizeConfig.safeBlockVertical * 3,
                right: SizeConfig.safeBlockVertical * 3),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                semanticChildCount: 10,
                children: [
                  FutureBuilder(
                    future: dio.get(eventsFeedEndpoint),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        var rawResponse = (snapshot.data as Response).data;
                        String stringResponse = "";
                        for (String event in rawResponse.values) {
                          stringResponse += (event + " 11/1 " + '\n');
                        }
                        return Center(
                          child: Text(stringResponse,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                  fontSize: SizeConfig.safeBlockHorizontal * 3,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Comfortaa")),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          // Card(
          //   elevation: 20.0,
          //   child: Container(
          //     child: Center(child: Text("Degree Roadmap")),
          //     color: Colors.black,
          //     //Image.asset("assets/degree_roadmap.jpg"),
          //     height: 100,
          //     width: 200,
          //   ),
          // ),
          Padding(padding: EdgeInsets.only(bottom: 70.0)),
          CarouselSlider(scrollDirection: Axis.horizontal, height: 264, items: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 10.0,
              child: Container(
                width: 282,
                child: Column(children: [
                  Container(
                    child: Image.asset("assets/classes.jpg"),
                    height: 200,
                    width: 400,
                  ),
                  ListTile(
                    title: Center(child: Text("Class Lookup")),
                    tileColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0)),
                  )
                ]),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10.0,
              shadowColor: Colors.grey,
              child: Container(
                width: 282,
                child: Column(children: [
                  Container(
                    child: Image.asset("assets/class_history.jpg"),
                    height: 200,
                    width: 400,
                  ),
                  ListTile(
                    title: Center(child: Text("Class History")),
                    tileColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0)),
                  )
                ]),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10.0,
              shadowColor: Colors.grey,
              child: Container(
                width: 282,
                child: Column(children: [
                  Container(
                    child: Image.asset("assets/calendar.jpg"),
                    height: 200,
                    width: 400,
                  ),
                  ListTile(
                    title: Center(child: Text("Calendar")),
                    tileColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0)),
                  )
                ]),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10.0,
              shadowColor: Colors.grey,
              child: Container(
                width: 282,
                child: Column(children: [
                  Container(
                    child: Image.asset("assets/events.jpg"),
                    height: 200,
                    width: 400,
                  ),
                  ListTile(
                    title: Center(child: Text("Events")),
                    tileColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0)),
                  )
                ]),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockVertical),
          ),
          Text(
            sayHello(),
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 2,
              letterSpacing: 2,
              fontFamily: "Comfortaa",
              color: Colors.white
            ),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockVertical * .5),
          ),
          Text(
            tellDate(),
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 2,
              letterSpacing: 2,
              color: Colors.white,
              fontFamily: "Comfortaa",
            ),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
          ),
        ]),
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
                onPressed: (){},
              )
            ),
            child: Center(
              child: CupertinoButton(
                child: const Text('Next page'),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute<void>(
                      builder: (BuildContext context) {
                        return CupertinoPageScaffold(
                          navigationBar: CupertinoNavigationBar(
                            middle: Text('Page 2 of tab $index'),
                          ),
                          child: Center(
                            child: CupertinoButton(
                              child: const Text('Back'),
                              onPressed: () { Navigator.of(context).pop(); },
                            ),
                          ),
                        );
                      },
                    ),
                  );
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
      Navigator.pushNamed(context, RoutePaths.Login);
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
