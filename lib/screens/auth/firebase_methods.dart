import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook_app/constants.dart';
import 'package:cookbook_app/pages/edit_profile.dart';
import 'package:cookbook_app/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

final FirebaseFirestore fs = FirebaseFirestore.instance;

Future<void> checkProfileExistsOrNot(BuildContext context, {bool filterByMobNo, String mobNo, String email}) async {
  CollectionReference usrs = FirebaseFirestore.instance.collection('users');
  QuerySnapshot<Map<String, dynamic>> qSnap;

  SharedPreferences _prefs = await SharedPreferences.getInstance();

  try {
    if (!filterByMobNo) {
      qSnap = await usrs.where('email', isEqualTo: email).get();
      if (qSnap.docs.length > 0) {
        _prefs.setString('uid', qSnap.docs[0].id);
        if (!qSnap.docs[0].data()['name'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['email'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['pfpUrl'].toString().isEmptyOrNull) {
          print(qSnap.docs[0].data());
          _prefs.setString('username', qSnap.docs[0].data()['name']);
          _prefs.setString('email', qSnap.docs[0].data()['email']);
          _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url']);
          HomeScreen().launch(context, isNewTask: true);
        } else if (!qSnap.docs[0].data()['name'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['email'].toString().isEmptyOrNull) {
          _prefs.setString('username', qSnap.docs[0].data()['name']);
          _prefs.setString('email', qSnap.docs[0].data()['email']);
          EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
        } else if (!qSnap.docs[0].data()['email'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['pfp_url'].toString().isEmptyOrNull) {
          _prefs.setString('email', qSnap.docs[0].data()['email']);
          _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url']);
          EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
        } else if (!qSnap.docs[0].data()['pfp_url'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['name'].toString().isEmptyOrNull) {
          _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url']);
          _prefs.setString('username', qSnap.docs[0].data()['name']);
          EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
        } else {
          EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
        }
      } else {
        EditProfilePage(
          Constants.setupTitleForProfilePage,
          newUser: true,
          mobNo: mobNo,
        ).launch(context, isNewTask: true);
      }
    } else {
      qSnap = await usrs.where('mobNo', isEqualTo: mobNo).get();
      if (qSnap.docs.length > 0) {
        _prefs.setString('uid', qSnap.docs[0].id);
        if (!qSnap.docs[0].data()['name'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['mobNo'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['pfpUrl'].toString().isEmptyOrNull) {
          _prefs.setString('username', qSnap.docs[0].data()['name']);
          _prefs.setString('mobNo', qSnap.docs[0].data()['mobNo']);
          _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url']);
          HomeScreen().launch(context, isNewTask: true);
        } else if (!qSnap.docs[0].data()['name'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['mobNo'].toString().isEmptyOrNull) {
          _prefs.setString('username', qSnap.docs[0].data()['name']);
          _prefs.setString('mobNo', qSnap.docs[0].data()['mobNo']);
          EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
        } else if (!qSnap.docs[0].data()['mobNo'.toString().isEmptyOrNull] &&
            !qSnap.docs[0].data()['pfp_url'].toString().isEmptyOrNull) {
          _prefs.setString('mobNo', qSnap.docs[0].data()['email']);
          _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url']);
          EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
        } else if (!qSnap.docs[0].data()['pfp_url'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['name'].toString().isEmptyOrNull) {
          _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url']);
          _prefs.setString('username', qSnap.docs[0].data()['name']);
          EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
        } else {
          EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
        }
      } else {
        EditProfilePage(
          Constants.setupTitleForProfilePage,
          newUser: true,
          mobNo: mobNo,
        ).launch(context, isNewTask: true);
      }
    }
  } catch (e, s) {
    print(e.toString() + s.toString());
  }

  return;
}