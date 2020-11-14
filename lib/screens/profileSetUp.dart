import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/sizingTools/sizeConfig.dart';

class ProfileSetUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ProfileState();

}
class _ProfileState extends State<ProfileSetUp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "profile set up",
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
      body: Container(
        child: Center(
          child: Text("Set up profile."),
        ),
      ),
    );
  }

}