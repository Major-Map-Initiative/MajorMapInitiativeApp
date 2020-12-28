// import 'package:flutter/material.dart';
// import 'package:myapp/screens/LoginSignUpPage.dart';
// import 'package:myapp/services/firebase_authentication_service.dart';
// import 'package:myapp/screens/home_page.dart';
// import 'package:myapp/screens/profile_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'navigation/route_paths.dart';
//
// enum AuthStatus {
//   NOT_DETERMINED,
//   NOT_LOGGED_IN,
//   LOGGED_IN,
//   FIRST_LOGIN,
// }
//
// class RootPage extends StatefulWidget {
//   RootPage({this.auth, this.showProfileSetUp});
//
//   final BaseAuth auth;
//   final bool showProfileSetUp;
//
//   @override
//   State<StatefulWidget> createState() => new _RootPageState();
// }
//
// class _RootPageState extends State<RootPage> {
//   AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
//   String _userId = "";
//   bool showProfileSetUp;
//   @override
//   void initState() {
//     super.initState();
//     showProfileSetUp = widget.showProfileSetUp;
//     widget.auth.getCurrentUser().then((user) {
//       setState(() {
//         if (user != null) {
//           _userId = user?.uid;
//         }
//         authStatus =
//         user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
//       });
//     });
//   }
//
//   void loginCallback() {
//     widget.auth.getCurrentUser().then((user) {
//       setState(() {
//         _userId = user.uid.toString();
//       });
//     });
//     setState(() {
//       authStatus = AuthStatus.LOGGED_IN;
//     });
//   }
//
//   void logoutCallback() {
//     setState(() {
//       authStatus = AuthStatus.NOT_LOGGED_IN;
//       _userId = "";
//     });
//   }
//
//   Widget buildWaitingScreen() {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     switch (authStatus) {
//       case AuthStatus.NOT_DETERMINED:
//         return buildWaitingScreen();
//         break;
//       case AuthStatus.NOT_LOGGED_IN:
//         return new LoginSignupPage(
//           auth: widget.auth,
//           loginCallback: loginCallback,
//         );
//         break;
//       case AuthStatus.LOGGED_IN:
//         if (_userId.length > 0 && _userId != null  )  {
//
//             if(showProfileSetUp){
//               return new ProfileSetUp();
//             }else{
//               return new HomePage(
//                 userId: _userId,
//                 auth: widget.auth,
//                 logoutCallback: logoutCallback,
//               );
//             }
//
//         } else
//           return buildWaitingScreen();
//         break;
//         default:
//         return buildWaitingScreen();
//     }
//   }
//
//
//   void setFirstRun() async {
//     final preferences = await SharedPreferences.getInstance();
//     preferences.setBool('firstRun', false);
//     preferences.setBool('showProfileSetup', true);
//   }
//
//
// }