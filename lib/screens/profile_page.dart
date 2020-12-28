import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/navigation/router_paths.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/screens/login_page.dart';
import 'package:myapp/tools/sizeConfig.dart';
import 'package:provider/provider.dart';

class ProfileSetUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileSetUp> {
  UserProvider _userProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = Provider.of<UserProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Profile"),
        ),
        child: Center(
          child: CupertinoButton(
            child: Text("Log Out"),
            color: CupertinoColors.systemRed,
            onPressed: () {
              _userProvider.logOut();
              if (Platform.isAndroid) {
                Navigator.pushNamed(context, RoutePaths.Login);
              } else {
                Navigator.of(context, rootNavigator: true).pop(context);
              }
            },
          ),
        ));
  }
}
