import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../size_configs.dart';
import 'dish_name.dart';
import 'fav_icon.dart';

class DishTile extends StatelessWidget {
  const DishTile({
    Key key,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfigs.horizontalFractions * 60,
      // color: Colors.black45,
      padding: EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 10,
      ),
      child: Stack(
        children: [
          Container(
            width: SizeConfigs.horizontalFractions * 60,
            margin: EdgeInsets.only(
              left: 30,
            ),
            decoration: BoxDecoration(
              color: Colors.green[200],
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  color: Colors.green[100],
                  offset: Offset(8, 6),
                ),
              ],
              borderRadius: BorderRadius.circular(25),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30, bottom: 10, top: 250, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 20,
                            color: Colors.green[500],
                          ),
                          20.width,
                          SizedBox(
                            width: SizeConfigs.horizontalFractions * 10,
                            child: DishName(
                              firstWord: title.split(" ")[0],
                              secondWord: title.split(" ")[1],
                            ),
                          )
                        ],
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                          color: Colors.green[50],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 50,
                  top: 20,
                  child: Image.network(
                    'https://cdn.pixabay.com/photo/2016/12/05/10/07/dish-1883501_960_720.png',
                    scale: 3,
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment(-0.9, -1.1),
            child: FavIcon(),
          ),
        ],
      ),
    );
  }
}
