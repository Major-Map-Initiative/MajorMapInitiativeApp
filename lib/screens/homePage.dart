import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/sizingTools/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:myapp/BaseAuth.dart';
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
  final String eventsFeedEndpoint = "https://o94b6gq4pf.execute-api.us-west-2.amazonaws.com/qa";
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dio dio = new Dio();
  final String eventsFeedEndpoint = "https://o94b6gq4pf.execute-api.us-west-2.amazonaws.com/qa";
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Container(
          color: Colors.grey.withOpacity(.3) ,
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
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
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
            color:Colors.black,
            fontFamily: "Comfortaa",
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            children: <Widget>[
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 4),
          ),
          Center(
            child: Text("Upcoming Important Dates",
            style:   TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 4,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontFamily: "Comfortaa"),
            ),
          ),
          Container(
            height: SizeConfig.safeBlockVertical * 15,
            padding: EdgeInsets.only(left: SizeConfig.safeBlockVertical * 3, right:SizeConfig.safeBlockVertical * 3 ),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                semanticChildCount: 10,
                children: [
                    FutureBuilder(
                      future:  dio.get(eventsFeedEndpoint),
                      builder: (context, snapshot){
                        if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                          var rawResponse =  (snapshot.data as Response).data;
                          String stringResponse= "";
                            for(String event in rawResponse.values){
                              stringResponse += (event +'\n');
                            }
                            return Center(
                              child: Text(
                                stringResponse,
                              textAlign: TextAlign.center,
                              style:   TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 3,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Comfortaa")),
                            );
                        }else{
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  Padding(
                    padding: EdgeInsets.all(2.0),
                  ),

                ],
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(bottom: SizeConfig.safeBlockHorizontal * 20),
          ),
          Row(
            children: [
              Expanded(
                child: Card(
          color: Color(0xFF182B49),
                  shape: RoundedRectangleBorder(
                      side: new BorderSide(color:   Color(0xFF182B49),
                      width: 1.0),
                      borderRadius: BorderRadius.circular(4.0)),
                  margin: EdgeInsets.all(10.0),
                  semanticContainer: false,
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(minHeight: 100, maxHeight: 210),
                    child: Center(
                      child: Text(
                        "class lookup",
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          letterSpacing: 2,
                          color: Colors.yellow,
                          fontFamily: "Comfortaa",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color:Color(0xFF182B49), width: 1.0),),
                  margin: EdgeInsets.all(10.0),

                  semanticContainer: false,
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(minHeight: 100, maxHeight: 210),
                    child: Center(
                      child: Text(
                        "class history",
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          letterSpacing: 2,
                          color: Color(0xFF182B49),
                          fontFamily: "Comfortaa",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Card(
                  color: Colors.yellow,
                  margin: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color: Color(0xFF182B49), width: 1.0),),
                  semanticContainer: false,
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(minHeight: 100, maxHeight: 210),
                    child: Center(
                      child: Text(
                        "view calendar",
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          letterSpacing: 2,
                          color: Color(0xFF182B49),
                          fontFamily: "Comfortaa",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  color: Color(0xFF182B49),

                  semanticContainer: false,
                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color:  Colors.yellow
                    , width: 1.0),),
                  child: Container(
                    width: double.infinity,

                    constraints: BoxConstraints(minHeight: 100, maxHeight: 210),
                    child: Center(
                      child: Text(
                        "view events",
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          letterSpacing: 2,
                          color: Colors.yellow,
                          fontFamily: "Comfortaa",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockVertical ),
          ),
              Text(
                sayHello(),
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 2,
                  letterSpacing: 2,
                  fontFamily: "Comfortaa",
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
              fontFamily: "Comfortaa",
            ),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
          ),
        ]),
      ),
    );
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
      await widget.auth.signOut();
      widget.logoutCallback();
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
