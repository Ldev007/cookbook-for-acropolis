import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook_app/screens/auth/firebase_methods.dart';
import 'package:cookbook_app/size_configs.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../constants.dart';

class AddDish extends StatefulWidget {
  @override
  _AddDishState createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  File stockFile;

  String dishType;
  String cuisineType;

  TextEditingController _nameCont = TextEditingController();
  TextEditingController _timeCont = TextEditingController();
  TextEditingController _descriptionCont = TextEditingController();

  String errorText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'ADD A DISH',
          ),
        ),
        backgroundColor: Colors.green[300],
        body: SingleChildScrollView(
          child: Container(
            width: SizeConfigs.horizontalFractions * 100,
            height: SizeConfigs.verticalFractions * 91,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: stockFile == null
                            ? AssetImage('')
                            : FileImage(
                                stockFile,
                              ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          child: stockFile == null
                              ? Icon(
                                  Icons.image,
                                  color: Colors.green[100],
                                  size: 150,
                                )
                              : Container(),
                        ),
                        Align(
                          alignment: Alignment(0.9, 0.9),
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
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green[50],
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.green[700],
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.edit_outlined,
                                color: Colors.green[600],
                                size: 30,
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
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: _nameCont,
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.headline6.fontSize,
                            color: Colors.green[800],
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.short_text),
                            hintText: 'Name of dish',
                            hintStyle: TextStyle(
                              color: Colors.green[300],
                              fontSize: Theme.of(context).textTheme.headline6.fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _timeCont,
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.headline6.fontSize,
                            color: Colors.green[800],
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.timer),
                            suffixText: 'MINS',
                            hintText: 'Time',
                            hintStyle: TextStyle(
                              color: Colors.green[400],
                              fontSize: Theme.of(context).textTheme.headline6.fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _descriptionCont,
                          maxLines: 2,
                          maxLength: 80,
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.headline6.fontSize,
                            color: Colors.green[800],
                          ),
                          decoration: InputDecoration(
                            counterStyle: TextStyle(
                              fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                            prefixIcon: Icon(Icons.description_outlined),
                            hintText: 'Description',
                            hintStyle: TextStyle(
                              color: Colors.green[400],
                              fontSize: Theme.of(context).textTheme.headline6.fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: fs.collection('dish_types').snapshots(),
                          builder: (context, typeSnap) {
                            print('types' + typeSnap.data.docs.toString());
                            if (typeSnap.hasData) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green[600]),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: DropdownButton(
                                  value: dishType,
                                  underline: Container(),
                                  isExpanded: true,
                                  hint: Text(
                                    'Select the type of dish',
                                    style: TextStyle(
                                      color: Colors.green[400],
                                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  iconEnabledColor: Colors.green[400],
                                  onChanged: (val) => setState(() {
                                    dishType = val;
                                  }),
                                  dropdownColor: Colors.green[50],
                                  items: List.generate(
                                    typeSnap.data.docs.length,
                                    (i) => DropdownMenuItem<String>(
                                      value: typeSnap.data.docs[i].id,
                                      child: Text(
                                        typeSnap.data.docs[i].id,
                                        style: TextStyle(
                                          color: Colors.green[800],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: fs.collection('cuisines').snapshots(),
                          builder: (context, typeSnap) {
                            print('types' + typeSnap.data.docs.toString());
                            if (typeSnap.hasData) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green[600]),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: DropdownButton(
                                  value: cuisineType,
                                  underline: Container(),
                                  isExpanded: true,
                                  hint: Text(
                                    'Select the cuisine',
                                    style: TextStyle(
                                      color: Colors.green[400],
                                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  iconEnabledColor: Colors.green[400],
                                  onChanged: (val) => setState(() {
                                    cuisineType = val;
                                  }),
                                  dropdownColor: Colors.green[50],
                                  items: List.generate(
                                    typeSnap.data.docs.length,
                                    (i) => DropdownMenuItem<String>(
                                      value: typeSnap.data.docs[i].id,
                                      child: Text(
                                        typeSnap.data.docs[i].id,
                                        style: TextStyle(
                                          color: Colors.green[800],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Text(errorText ?? '', style: TextStyle(color: Colors.red)),
                        ElevatedButton(
                          onPressed: () {
                            if (_nameCont.text.isEmptyOrNull ||
                                _timeCont.text.isEmptyOrNull ||
                                _descriptionCont.text.isEmptyOrNull) {
                              setState(() {
                                errorText = '*All fields are to be filled correctly';
                              });
                            } else {
                              setState(() {
                                errorText = null;
                              });
                              
                            }
                          },
                          child: Text('Add dish'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
