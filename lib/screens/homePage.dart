
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/appIcons_icons.dart';
import 'package:myapp/sizingTools/sizeConfig.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:myapp/appIcons_icons.dart' as prefix;
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:myapp/BaseAuth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/icons.dart' as defaultIcons;

class homePage extends StatefulWidget {
  homePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}
class _HomePageState extends State<homePage> {
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {

    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(

        //backgroundColor: Colors.white,
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 2),
            children: <Widget>[
              SizedBox(height: SizeConfig.safeBlockVertical * .01,),
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
                    letterSpacing: 6,
                    fontFamily: "Comfortaa",
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
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
                title: Text('Profile',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                    fontFamily: "Comfortaa",
                  ),
                ),
                leading: (
                    Icon(
                      defaultIcons.Icons.home,
                    )
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Classes',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                    fontFamily: "Comfortaa",
                  ),
                ),
                leading: (
                Icon(
                  defaultIcons.Icons.book,
                )
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
                title: Text('Settings',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                    fontFamily: "Comfortaa",
                  ),
                ),
                leading: (
                    Icon(
                      defaultIcons.Icons.settings,
                    )
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Log out',
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 4,
                    fontFamily: "Comfortaa",
                  ),
                ),
                leading: (
                    Icon(
                      defaultIcons.Icons.exit_to_app,
                    )
                ),
                onTap: () {
                  signOut();
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            "major map initiative",
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 5,
              letterSpacing: 4,
              fontFamily: "Comfortaa",
            ),
          ),
          backgroundColor: MaterialColor(
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
          centerTitle: true,
        ),
        body:
        Center(
          child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
                ),
                Row(
          mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        sayHello(),
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                    letterSpacing: 2,
                    fontFamily: "Comfortaa",
                    color: Colors.grey.withOpacity(1),
                  ),
                ),
                ]),
                Padding(
                  padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 2),
                ),
                Container(
                  height: SizeConfig.safeBlockVertical * 25,
                  margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
                  alignment: Alignment.centerLeft,
               //   color: Colors.white,
                  padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 3),
                  child: ListView(
                    shrinkWrap: true,
                    semanticChildCount: 10,
                    children: [
                      Text(
                        "Upcoming Important Dates",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:  SizeConfig.safeBlockHorizontal * 4 ,
                      ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(
                        "First day of classes is October 1st",
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(
                        "Financial aid disbursement day is October 2nd ",
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(
                        "Among Us MMI game night is October 3rd",
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(
                        "Last day to waitlist a class is October 15th",
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(
                        "Last day to drop a class is November 12th",
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom:SizeConfig.safeBlockHorizontal * 14),
                ),
                Expanded(
                child: Container(
                  alignment: Alignment.center,
                  color: MaterialColor(
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
                  margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
                  padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: double.infinity),
                  child: FlatButton(
                    color: MaterialColor(
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
                  child: Text(
                    "quick class lookup",
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 4 ,
                      letterSpacing: 2,
                      fontFamily: "Comfortaa",
                    ),
                  ),
                    onPressed: (){
                    expenses(context);
                    },
                  ),
                  ),
                ),
                ),
                Expanded(
                child: Container(
                  margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
                  alignment: Alignment.center,
                  color: Colors.yellow,
                  padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: double.infinity),
                    child: FlatButton(
                  child: Text(
                    "view class history",
                    style: TextStyle(
                      fontSize:  SizeConfig.safeBlockHorizontal * 4,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Comfortaa",
                    ),
                  ),
                    onPressed: (){},
                  ),
                  ),
                ),
                ),
                Expanded(
                child: Container(
                  margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
                  alignment: Alignment.center,
                  color: MaterialColor(
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
                  padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: double.infinity),
                    child: FlatButton(
                  child: Text(
                    "view events",
                    style: TextStyle(
                      fontSize:  SizeConfig.safeBlockHorizontal * 4,
                      letterSpacing: 2,
                      fontFamily: "Comfortaa",
                    ),
                  ),
                    onPressed: (){},
                  ),
                  ),
                ),
                ),
                Expanded(
                child: Container(
                  margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
                  alignment: Alignment.center,
                  color: Colors.yellow,
                  padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: double.infinity),
                    child: FlatButton(
                    child: Text(
                    "view calendar",
                    style: TextStyle(
                      fontSize:  SizeConfig.safeBlockHorizontal * 4,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Comfortaa",
                    ),
                  ),
                    onPressed: () {},
                ),
                ),
                ),
                ),

                Padding(
                  padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
                ),
               Text(
                  tellDate(),
                  style: TextStyle(
                    fontSize:  SizeConfig.safeBlockHorizontal * 2,
                    letterSpacing: 2,
                    fontFamily: "Comfortaa",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 2),
                ),
                ]),
              ),
        );

  }
  String sayHello(){
    String hello;


    DateTime today = new DateTime.now();
    int hour = today.hour;

    if(hour < 12){
      hello = "Good morning";
    }
    else if (hour < 18){
      hello = "Good afternoon";
    }
    else{
      hello = "Good evening";
    }
    return hello + " Peter.";
  }
String tellDate(){
  DateTime today = new DateTime.now();
  int month = today.month;
  int year = today.year;
  int weekday = today.weekday;
  int day = today.day;

  String toReturn = "It is " + tellWeekday(weekday) + ", " + tellMonth(month) + " " + day.toString() + " " + year.toString();
  return toReturn;

}

String tellWeekday(int weekday){
    if(weekday == DateTime.sunday){
      return "Sunday";
    }else if(weekday == DateTime.monday){
      return "Monday";
    }else if(weekday == DateTime.tuesday){
      return "Tuesday";
    }else if(weekday == DateTime.wednesday){
      return "Wednesday";
    }else if(weekday == DateTime.thursday){
      return "Thursday";
    }else if(weekday == DateTime.friday){
      return "Friday";
    }else {
      return "Saturday";
    }
}

String tellMonth(int month){
    if(month == 1){
      return "January";
    }else if(month == 2){
      return "February";
    }else if(month == 3){
      return "March";
    }else if(month == 4){
      return "April";
    }else if(month == 5){
      return "May";
    }else if(month == 6){
      return "June";
    }else if(month == 7){
      return "July";
    }else if(month == 8){
      return "August";
    }else if(month == 9){
      return "September";
    }else if(month == 10){
      return "October";
    }else if(month == 11){
      return "November";
    }else{
      return "December";
    }

}
  String tellTime(){
    String appendix;
    String time;
    DateTime today = new DateTime.now();
    int hour = today.hour;

    appendix = (hour < 12) ? "am" : "pm";

    hour = hour %  12;
    int minute = today.minute;

    String minuteString = (minute < 10) ? "0" + minute.toString() : minute.toString();
    time = hour.toString() + ":" + minuteString + " " + appendix;
    return time;
  }

  void expenses(BuildContext context){
    var alert = AlertDialog(
      title: Text("Welcome to expenses."),
      content: Text("No expenses logged yet"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context){
        return alert;
      }
    );
  }
}