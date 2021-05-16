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
  if (filterByMobNo) {
    qSnap = await usrs.where('phoneNo', isEqualTo: '+91' + mobNo).get();
  } else {
    qSnap = await usrs.where('email', isEqualTo: email).get();
  }

  SharedPreferences _prefs = await SharedPreferences.getInstance();

  if (qSnap.docs.length > 0) {
    print(qSnap.docs[0].id.toString());
    _prefs.setString('uid', qSnap.docs[0].id.toString());
    if (qSnap.docs[0].data()['name'] != '' && qSnap.docs[0].data()['email'] != '' && qSnap.docs[0].data()['pfpUrl']) {
      _prefs.setString('username', qSnap.docs[0].data()['name']);
      _prefs.setString('email', qSnap.docs[0].data()['email']);
      _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url']);
      HomeScreen().launch(context, isNewTask: true);
    } else if (qSnap.docs[0].data()['name'] != '') {
      _prefs.setString('username', qSnap.docs[0].data()['name']);
      EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
    } else if (qSnap.docs[0].data()['email' != '']) {
      _prefs.setString('username', qSnap.docs[0].data()['email']);
      EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
    } else if (qSnap.docs[0].data()['pfp_url'] != '') {
      _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url']);
    } else {
      EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
    }
  } else {
    EditProfilePage(Constants.setupTitleForProfilePage, newUser: true).launch(context, isNewTask: true);
  }

  return;
}

checkDuplicacy(String email) {}
