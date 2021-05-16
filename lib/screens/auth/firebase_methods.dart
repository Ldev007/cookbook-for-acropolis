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

  if (!filterByMobNo) {
    qSnap = await usrs.where('email', isEqualTo: email).get();
    if (qSnap.docs.length > 0) {
      if (qSnap.docs[0].data()['name'] != '' &&
          qSnap.docs[0].data()['email'] != '' &&
          qSnap.docs[0].data()['pfpUrl'] != '') {
        _prefs.setString('username', qSnap.docs[0].data()['name']);
        _prefs.setString('email', qSnap.docs[0].data()['email']);
        _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url']);
        HomeScreen().launch(context, isNewTask: true);
      } else if (qSnap.docs[0].data()['name'] != '' && qSnap.docs[0].data()['email'] != '') {
        _prefs.setString('username', qSnap.docs[0].data()['name']);
        _prefs.setString('email', qSnap.docs[0].data()['email']);
        EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
      } else if (qSnap.docs[0].data()['email' != ''] && qSnap.docs[0].data()['pfp_url'] != '') {
        _prefs.setString('email', qSnap.docs[0].data()['email']);
        _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url']);
        EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
      } else if (qSnap.docs[0].data()['pfp_url'] != '' && qSnap.docs[0].data()['name'] != '') {
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
      if (qSnap.docs[0].data()['name'] != '' &&
          qSnap.docs[0].data()['mobNo'] != '' &&
          qSnap.docs[0].data()['pfpUrl'] != '') {
        _prefs.setString('username', qSnap.docs[0].data()['name']);
        _prefs.setString('mobNo', qSnap.docs[0].data()['mobNo']);
        _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url']);
        HomeScreen().launch(context, isNewTask: true);
      } else if (qSnap.docs[0].data()['name'] != '' && qSnap.docs[0].data()['mobNo'] != '') {
        _prefs.setString('username', qSnap.docs[0].data()['name']);
        _prefs.setString('mobNo', qSnap.docs[0].data()['mobNo']);
        EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
      } else if (qSnap.docs[0].data()['mobNo' != ''] && qSnap.docs[0].data()['pfp_url'] != '') {
        _prefs.setString('mobNo', qSnap.docs[0].data()['email']);
        _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url']);
        EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
      } else if (qSnap.docs[0].data()['pfp_url'] != '' && qSnap.docs[0].data()['name'] != '') {
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

  return;
}

checkDuplicacy(String email) async {
  QuerySnapshot qSnap = await fs.collection('users').get();
}
