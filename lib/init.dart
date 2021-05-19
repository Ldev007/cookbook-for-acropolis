import 'package:cookbook_app/screens/auth/auth_one.dart';
import 'package:cookbook_app/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Initialise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Widget>(
          future: checkUsersAuth(context),
          builder: (context, initSnap) => Center(
            child: CircularProgressIndicator(strokeWidth: 1.5),
          ),
        ),
      ),
    );
  }

  Future<Widget> checkUsersAuth(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if ((_prefs.getBool('loggedIn') ?? false)) {
      return HomeScreen().launch(
        context,
        isNewTask: true,
      );
    } else {
      return AuthOne().launch(
        context,
        isNewTask: true,
      );
    }
  }
}
