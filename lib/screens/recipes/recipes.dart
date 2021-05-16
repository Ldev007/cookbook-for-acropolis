import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook_app/screens/auth/firebase_methods.dart';
import 'package:cookbook_app/screens/recipes/components/animated_title.dart';
import 'package:cookbook_app/screens/recipes/components/dish_tile.dart';
import 'package:cookbook_app/size_configs.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'components/cuisine_box.dart';

class Recipes extends StatefulWidget {
  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  String currentTitle = 'Indonesian';

  String pastTitle = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment(-0.6, 0),
              child: AnimatedTitle(
                currentTitle: currentTitle,
                pastTitle: pastTitle,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: fs.collection('cuisines').doc(currentTitle).collection('dishes').snapshots(),
                builder: (ctx, dishSnap) {
                  if (dishSnap.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dishSnap.data.docs.length,
                      itemBuilder: (context, i) {
                        return DishTile(
                          title: !dishSnap.data.docs[i]['name'].toString().contains(" ")
                              ? 'Dish ' + dishSnap.data.docs[i]['name'].toString()
                              : dishSnap.data.docs[i]['name'].toString(),
                          description: 'A salad is a dish usually consisting'
                              'of a mixture of small pieces of vegetables.',
                        );
                      },
                    );
                  } else if (dishSnap.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Loading dishes'),
                        10.height,
                        CircularProgressIndicator(
                          strokeWidth: 1.5,
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: fs.collection('cuisines').snapshots(),
                builder: (ctx, cuisineSnap) {
                  if (cuisineSnap.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cuisineSnap.data.docs.length,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (ctx, i) {
                        return CuisineBox(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                pastTitle = currentTitle;
                                currentTitle = cuisineSnap.data.docs[i].id;
                              });
                            },
                            child: SizedBox(
                              width: SizeConfigs.horizontalFractions * 25,
                              child: Center(
                                child: Text(
                                  cuisineSnap.data.docs[i].id,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Theme.of(context).textTheme.headline5.fontSize,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10,
                                        color: Colors.green[500],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (cuisineSnap.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Loading cuisines'),
                        10.height,
                        CircularProgressIndicator(
                          strokeWidth: 1.5,
                        )
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
