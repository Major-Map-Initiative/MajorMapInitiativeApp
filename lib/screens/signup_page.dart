import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/providers/user_provider.dart';

class SignupPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SignupPageState();

}

class _SignupPageState extends State<SignupPage> {
  UserProvider _userProvider;

  final _emailFieldController = TextEditingController();

  final _passwordFieldController = TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = UserProvider();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup Page"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 250, maxHeight: 520),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Create Account",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
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

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    onPressed: () async {


                       if( await _userProvider.signUp(_emailFieldController.text,
                            _passwordFieldController.text)){
                         successDialog(context);

                       }else{
                         errorDialog(context);
                       }


                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue,
                    minWidth: 275,
                    child: Text("Create account"),
                  ),
                ),

              ],
            ),
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
      title: Text("Account Error"),
      content: Text(
          "Unable to create an account. Verify credentials or email format."),
      actions: [
        okButton,
      ],
    ) : AlertDialog(
      title: Text("Account Error"),
      content: Text(
          "Unable to create an account. Verify credentials or email format."),
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
  CupertinoAlertDialog successDialog(BuildContext context) {
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
      title: Text("Success"),
      content: Text(
          "Please navigate to sign in page."),
      actions: [
        okButton,
      ],
    ) : AlertDialog(
      title: Text("Success"),
      content: Text(
          "Please navigate to sign in page."),
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