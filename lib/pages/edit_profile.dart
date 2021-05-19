import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook_app/screens/auth/firebase_methods.dart';
import 'package:cookbook_app/screens/home/home_screen.dart';
import 'package:cookbook_app/size_configs.dart';
import 'package:cookbook_app/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../constants.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage(this.title, {Key key, this.newUser, this.mobNo}) : super(key: key);

  final String title;
  final bool newUser;
  final String mobNo;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  SharedPreferences _prefs;

  TextEditingController _nameCont = TextEditingController();
  TextEditingController _mobNoCont = TextEditingController();
  TextEditingController _emailCont = TextEditingController();

  String name;
  String email;
  String pfpUrl;
  String mobNo;

  String nameError;
  String mobNoError;
  String emailError;

  File stockFile;

  String dpUrl;

  @override
  void initState() {
    _mobNoCont.text = widget.mobNo;
    setLocalData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.green[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: SizeConfigs.horizontalFractions * 100,
          height: SizeConfigs.verticalFractions * 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Stack(
                  children: [
                    Align(
                      child: Container(
                        padding: EdgeInsets.all(2.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              color: Colors.green[600],
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.green[100],
                          child: stockFile == null && pfpUrl.isEmptyOrNull
                              ? Icon(
                                  Icons.person,
                                  color: Colors.green[300],
                                  size: 70,
                                )
                              : Container(),
                          backgroundImage: (pfpUrl == '' || pfpUrl == null)
                              ? stockFile != null
                                  ? FileImage(stockFile)
                                  : null
                              : NetworkImage(pfpUrl),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.8, 0.8),
                      child: InkWell(
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              height: SizeConfigs.verticalFractions * 12,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ListTile(
                                    onTap: () async {
                                      try {
                                        PickedFile file = await ImagePicker().getImage(
                                          source: ImageSource.camera,
                                        );
                                        setState(() {
                                          stockFile = File(file.path);
                                          Navigator.pop(context);
                                        });
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    leading: Icon(Icons.camera),
                                    title: Text('Camera'),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                                  ),
                                  Divider(
                                    height: 0,
                                    color: Colors.black54,
                                  ),
                                  ListTile(
                                    onTap: () async {
                                      PickedFile file = await ImagePicker().getImage(
                                        source: ImageSource.gallery,
                                      );
                                      setState(() {
                                        stockFile = File(file.path);
                                        Navigator.pop(context);
                                      });
                                    },
                                    leading: Icon(Icons.photo_library),
                                    title: Text('Gallery'),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.green[200],
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              60.height,
              Align(
                alignment: Alignment(-0.9, 0),
                child: Text(
                  'PROFILE DETAILS',
                  style: TextStyle(
                    color: Colors.green[500],
                    fontWeight: FontWeight.w600,
                    fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
                  ),
                ),
              ),
              30.height,
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextFormField(
                      controller: _nameCont,
                      decoration: InputDecoration(hintText: 'Name', errorText: nameError),
                      cursorColor: Colors.green[800],
                      onChanged: (val) {
                        setState(() {
                          if (val.length > 0 || !_prefs.getString('username').isEmptyOrNull) {
                            nameError = null;
                          } else {
                            nameError = Constants.textFieldErrorText;
                          }
                        });
                      },
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                        color: Colors.green[700],
                      ),
                    ),
                    30.height,
                    TextFormField(
                      controller: _emailCont,
                      onChanged: (val) async {
                        _prefs = await SharedPreferences.getInstance();
                        setState(() {
                          if ((val.length > 0 && val.validateEmail()) ||
                              !_mobNoCont.text.isEmptyOrNull ||
                              !_prefs.getString('mobNo').isEmptyOrNull ||
                              !_prefs.getString('email').isEmptyOrNull) {
                            emailError = null;
                          } else {
                            emailError = Constants.emailErrorText;
                          }
                        });
                      },
                      decoration: InputDecoration(hintText: 'Email', errorText: emailError),
                      cursorColor: Colors.green[800],
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                        color: Colors.green[700],
                      ),
                    ),
                    70.height,
                    ElevatedButton(
                      style: Utils.getButtonStyle(context, width: null, height: null),
                      onPressed: () async {
                        _prefs = await SharedPreferences.getInstance();

                        try {
                          if (_nameCont.text.isEmptyOrNull && _prefs.getString('username').isEmptyOrNull) {
                            setState(() {
                              nameError = Constants.textFieldErrorText;
                            });
                          } else if ((_emailCont.text.isEmptyOrNull && _prefs.getString('email').isEmptyOrNull) &&
                              (_mobNoCont.text.isEmptyOrNull && _prefs.getString('mobNo').isEmptyOrNull)) {
                            print('Email error' + _prefs.getString('mobNo'));
                            setState(() {
                              nameError = null;
                              emailError = Constants.textFieldErrorText;
                            });
                          } else {
                            setState(() {
                              emailError = null;
                              nameError = null;
                            });
                            if (!(widget.newUser ?? false)) {
                              print('setting values for user ' + _prefs.getString('uid'));
                              if (stockFile != null) {
                                _prefs = await SharedPreferences.getInstance();

                                await FirebaseStorage.instance.ref(_prefs.getString('uid') + '.png').putFile(stockFile);
                                dpUrl = await FirebaseStorage.instance
                                    .ref(_prefs.getString('uid') + '.png')
                                    .getDownloadURL();

                                _prefs.setString('pfpUrl', dpUrl);
                                setState(() {
                                  pfpUrl = dpUrl;
                                });
                              }

                              fs.collection('users').doc(_prefs.getString('uid')).set(
                                {
                                  'name': _nameCont.text ?? _prefs.getString('username') ?? '',
                                  'email': _emailCont.text ?? _prefs.getString('email') ?? '',
                                  'mobNo': _mobNoCont.text ?? _prefs.getString('mobNo') ?? '',
                                  'pfp_url': pfpUrl ?? _prefs.getString('pfpUrl') ?? '',
                                },
                              ).then(
                                (value) async {
                                  _prefs.setBool('loggedIn', true);
                                  return HomeScreen().launch(context, isNewTask: true);
                                },
                              );
                            } else {
                              int lenOfDocs;
                              QuerySnapshot snap = await fs.collection('users').get();
                              lenOfDocs = snap.docs.length;

                              if (stockFile != null) {
                                _prefs = await SharedPreferences.getInstance();

                                await FirebaseStorage.instance.ref('user${lenOfDocs + 1}' + '.png').putFile(stockFile);

                                dpUrl = await FirebaseStorage.instance
                                    .ref('user${lenOfDocs + 1}' + '.png')
                                    .getDownloadURL();

                                _prefs.setString('pfpUrl', dpUrl);
                                setState(() {
                                  pfpUrl = dpUrl;
                                });
                              }
                              fs.collection('users').doc('user' + (lenOfDocs + 1).toString()).set({
                                'name': _nameCont.text ?? _prefs.getString('username') ?? '',
                                'email': _emailCont.text ?? _prefs.getString('email') ?? '',
                                'mobNo': _mobNoCont.text ?? _prefs.getString('mobNo') ?? '',
                                'pfp_url': pfpUrl ?? _prefs.getString('pfpUrl') ?? '',
                              }).then(
                                (value) async {
                                  await setPrefs();
                                  _prefs.setBool('loggedIn', true);
                                  _prefs.setString('uid', 'user${lenOfDocs + 1}');

                                  HomeScreen().launch(context, isNewTask: true);
                                  return Utils.normalToast(
                                    'Profile setup successful !',
                                    ToastGravity.BOTTOM,
                                  );
                                },
                              );
                            }
                          }
                        } catch (e, s) {
                          print(e.toString() + '\n' + s.toString());
                        }
                      },
                      child: Text('Submit'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void setLocalData() async {
    print('setting data');
    _prefs = await SharedPreferences.getInstance();

    setState(() {
      pfpUrl = _prefs.getString('pfpUrl') ?? '';
    });
  }

  Future<void> setPrefs() async {
    _prefs = await SharedPreferences.getInstance();

    _prefs.setString('username', _nameCont.text ?? _prefs.getString('username') ?? '');
    _prefs.setString('email', _emailCont.text ?? _prefs.getString('email') ?? 'Set your email');
    _prefs.setString('mobNo', _mobNoCont.text ?? _prefs.getString('mobNo') ?? '');

    return;
  }
}
