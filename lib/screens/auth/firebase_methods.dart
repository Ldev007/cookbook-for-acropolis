import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook_app/constants.dart';
import 'package:cookbook_app/pages/add_dish.dart';
import 'package:cookbook_app/pages/edit_profile.dart';
import 'package:cookbook_app/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

final FirebaseFirestore fs = FirebaseFirestore.instance;

Future<void> checkProfileExistsOrNot(BuildContext context, {bool filterByMobNo, String mobNo, String email}) async {
  CollectionReference usrs = fs.collection('users');
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
          _prefs.setString(
              'email', qSnap.docs[0].data()['email'] != '' ? 'Set your email' : qSnap.docs[0].data()['email']);
          _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url'].toString());
          HomeScreen().launch(context, isNewTask: true);
        } else if (!qSnap.docs[0].data()['name'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['email'].toString().isEmptyOrNull) {
          _prefs.setString('username', qSnap.docs[0].data()['name']);
          _prefs.setString(
              'email', qSnap.docs[0].data()['email'] != '' ? 'Set your email' : qSnap.docs[0].data()['email']);
          EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
        } else if (!qSnap.docs[0].data()['email'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['pfp_url'].toString().isEmptyOrNull) {
          _prefs.setString(
              'email', qSnap.docs[0].data()['email'] != '' ? 'Set your email' : qSnap.docs[0].data()['email']);
          _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url'].toString());
          EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
        } else if (!qSnap.docs[0].data()['pfp_url'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['name'].toString().isEmptyOrNull) {
          _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url'].toString());
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
      _prefs.setString('email', 'Set your email');
      if (qSnap.docs.length > 0) {
        _prefs.setString('uid', qSnap.docs[0].id);
        if (!qSnap.docs[0].data()['name'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['mobNo'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['pfp_url'].toString().isEmptyOrNull) {
          _prefs.setString('username', qSnap.docs[0].data()['name']);
          _prefs.setString(
              'mobNo', qSnap.docs[0].data()['mobNo'] != '' ? qSnap.docs[0].data()['mobNo'] : 'Set your mobile number');
          _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url'].toString());
          HomeScreen().launch(context, isNewTask: true);
        } else if (!qSnap.docs[0].data()['name'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['mobNo'].toString().isEmptyOrNull) {
          _prefs.setString('username', qSnap.docs[0].data()['name']);
          _prefs.setString(
              'mobNo',
              qSnap.docs[0].data()['mobNo'] != ''
                  ? qSnap.docs[0].data()['mobNo'].toString()
                  : 'Set your mobile number ');
          EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
        } else if (!qSnap.docs[0].data()['mobNo'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['pfp_url'].toString().isEmptyOrNull) {
          _prefs.setString(
              'mobNo', qSnap.docs[0].data()['mobNo'] != '' ? 'Set your mobile number' : qSnap.docs[0].data()['mobNo']);
          _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url'].toString());
          EditProfilePage(Constants.setupTitleForProfilePage).launch(context, isNewTask: true);
        } else if (!qSnap.docs[0].data()['pfp_url'].toString().isEmptyOrNull &&
            !qSnap.docs[0].data()['name'].toString().isEmptyOrNull) {
          _prefs.setString('pfpUrl', qSnap.docs[0].data()['pfp_url'].toString());
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

Future<bool> checkIfFoodExistsOrNot({String dishName, String cuisineType}) async {
  QuerySnapshot<Map<String, dynamic>> dishes =
      await fs.collection('cuisines').doc(cuisineType).collection('dishes').where('name', isEqualTo: dishName).get();

  if (dishes.docs.length > 0) {
    return false;
  } else {
    return true;
  }
}

Future<bool> addDish({Map<String, String> dishData, String cuisine}) async {
  QuerySnapshot<Map<String, dynamic>> qs = await fs.collection('cuisines').doc(cuisine).collection('dishes').get();
  int len = qs.docs.length;

  return fs.collection('cuisines').doc(cuisine).collection('dishes').doc('dish${len + 1}').set(dishData).then(
        (value) => true,
      );
}
