
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/tools/router_paths.dart';
import 'package:myapp/tools/sizeConfig.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserProvider _userProvider;

  final _emailFieldController = TextEditingController();

  final _passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   // _userProvider = Provider.of<UserProvider(context);
    SizeConfig().init(context);
    return Scaffold(
      body: buildLoginForm(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
   _userProvider = UserProvider();
  }

  Center buildLoginForm() {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 250, maxHeight: 500),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo title
              Image.asset("assets/MMI_Logo.png"),
              // Email Input
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                      style: TextStyle(textBaseline: TextBaseline.alphabetic),
                      decoration: InputDecoration(
                        hintText: "Email",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: _emailFieldController,
                      keyboardType: TextInputType.emailAddress,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                      style: TextStyle(textBaseline: TextBaseline.alphabetic),
                      decoration: InputDecoration(
                        hintText: "Password",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      obscureText: true,
                      controller: _passwordFieldController,
                    )),
              ),
              Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlatButton(
                  onPressed: () {
                    print("Hello world");
                    _userProvider.login(_emailFieldController.text, _passwordFieldController.text).then((userId){

                    _userProvider.isLoggedIn().then((loggedIn){
                     if(loggedIn){
                       Navigator.pushNamed(context, RoutePaths.Home);
                     }else{
                       errorDialog(context);
                     }
                    });
                    });

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue,
                  minWidth: 275,
                  child: Text("Log In"),
                ),
              ),
              Text("Create an account")
            ],
          ),
        ),
      ),
    );
  }

  CupertinoAlertDialog errorDialog(BuildContext context) {
    // set up the button
    Widget okButton = Platform.isIOS ? CupertinoButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ) : FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ) ;

    // set up the AlertDialog
    Widget alert = Platform.isIOS ? CupertinoAlertDialog(
      title: Text("Unable To Sign You In"),
      content: Text(
          "Be sure you are using the correct credentials. Otherwise create an account."),
      actions: [
        okButton,
      ],
    ) : AlertDialog(
      title: Text("Unable To Sign You In"),
      content: Text(
          "Be sure you are using the correct credentials. Otherwise create an account."),
      actions: [
        okButton,
      ],
    ) ;

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
