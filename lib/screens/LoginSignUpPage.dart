import 'package:flutter/material.dart';
import 'package:myapp/sizingTools/sizeConfig.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:myapp/BaseAuth.dart';
import 'package:myapp/appIcons_icons.dart' as prefix;

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage>{
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade900),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade900),
            ),
            hintText: 'Email',
            labelStyle: TextStyle(color: Colors.black),
            icon: new Icon(
              prefix.Icons.uniF1A9,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
        cursorColor: Colors.white,
      ),
    );
  }
  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showEmailInput(),
              showPasswordInput(),
              showPrimaryButton(),
              showSecondaryButton(),
              showErrorMessage(),
            ],
          ),
        ));
  }
  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(
            _isLoginForm ? 'create an account' : 'Have an account? Sign in',
            style: new TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3,
              letterSpacing: 0,
              color: Colors.black.withOpacity(1),
              fontFamily: "Comfortaa",
            )),
        onPressed: toggleFormMode);
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new FlatButton(
            color: Colors.yellow,
            child: new Text(
                _isLoginForm ? 'login' : 'Create an account',
                style: new TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 5,
    letterSpacing: 1,
    fontWeight: FontWeight.bold,
    color: Colors.white.withOpacity(1),
    fontFamily: "Comfortaa",
            ),
            ),
            onPressed: validateAndSubmit,
          ),
        ));
  }
  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade900),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade900),
            ),
            hintText: 'Password',
            labelStyle: TextStyle(color: Colors.black),
            icon: new Icon(
              prefix.Icons.uniF1C7,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
        cursorColor: Colors.white,
      ),
    );
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new Scaffold(
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
        appBar: AppBar(
          title: Text(
            "major map initiative",
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 5,
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
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
        body: Stack(
          children: <Widget>[
          Column(
        mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Container(
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
              padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 3),
              child: FadeAnimatedTextKit(
                text: ["welcome"],
                isRepeatingAnimation: true,
                repeatForever: true,
                textStyle: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 8,
                  letterSpacing: 3,
                  color: Colors.grey.withOpacity(1),
                  fontFamily: "Comfortaa",
                ),
              ),
            ),
          ]),
            _showForm(),
          ],
        ));
  }
}