import 'dart:io';

import 'package:cookbook_app/constants.dart';
import 'package:cookbook_app/pages/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../size_configs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key key,
    this.mobNo,
  }) : super(key: key);

  final String mobNo;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPreferences _prefs;

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
    setLocalData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: SizeConfigs.horizontalFractions * 100,
          height: SizeConfigs.verticalFractions * 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Stack(
                          children: [
                            Align(
                              child: CircleAvatar(
                                radius: 50,
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
                            Align(
                              alignment: Alignment(0.8, 0.6),
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
                                    size: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(top: 30, bottom: 30, right: 60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name ?? '',
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.headline5.fontSize,
                                fontWeight: FontWeight.w600,
                                color: Colors.green[600],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.mail_outline,
                                  size: 18,
                                  color: Colors.green[200],
                                ),
                                10.width,
                                Text(email ?? 'Set your email'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  color: Colors.green[200],
                                  size: 18,
                                ),
                                10.width,
                                Text(mobNo ?? 'Set your mobile number first'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green[600],
                        ),
                        onPressed: () => EditProfilePage(Constants.editTitleForProfilePage).launch(context),
                      ),
                    ),
                  ],
                ),
              ),
              60.height,
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment(-0.9, 0),
                      child: Text(
                        'Favourite Dishes',
                        style: TextStyle(
                          color: Colors.green[400],
                          fontWeight: FontWeight.w600,
                          fontSize: Theme.of(context).textTheme.headline6.fontSize,
                        ),
                      ),
                    ),
                    10.height,
                    Container(
                      width: SizeConfigs.horizontalFractions * 100,
                      height: SizeConfigs.verticalFractions * 20,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, i) => Container(
                          width: SizeConfigs.horizontalFractions * 35,
                          height: SizeConfigs.verticalFractions * 10,
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black45),
                          ),
                          child: Center(
                            child: Text(i.toString()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setLocalData() async {
    print('setting data');
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      pfpUrl = _prefs.getString('pfpUrl') ?? '';
      name = _prefs.getString('username');
      email = _prefs.getString('email');
    });
  }
}
