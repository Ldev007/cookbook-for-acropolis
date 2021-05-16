import 'package:cookbook_app/size_configs.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Recipes extends StatefulWidget {
  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  final List<String> cuisines = [
    'Indonesian',
    'Turkish',
    'Thai',
    'Spanish',
    'Moroccan',
    'Japanese',
    'Indian',
    'Italian',
    'French',
    'Chinese',
  ];

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
              child: AnimatedCrossFade(
                firstChild: Text.rich(
                  TextSpan(
                    text: currentTitle.substring(0, currentTitle.length - 4),
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline3.fontSize,
                      color: Colors.green[400],
                      fontWeight: FontWeight.w200,
                    ),
                    children: [
                      TextSpan(
                        text: currentTitle.substring(currentTitle.length - 4),
                        style: TextStyle(
                          color: Colors.green[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                secondChild: Text(pastTitle),
                duration: Duration(milliseconds: 500),
                crossFadeState: CrossFadeState.showFirst,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, i) {
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
                                          child: Text.rich(
                                            TextSpan(
                                              text: 'Blue\n',
                                              style: TextStyle(
                                                fontSize: Theme.of(context).textTheme.headline5.fontSize,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.green[600],
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Salad',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green[800],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            overflow: TextOverflow.visible,
                                            softWrap: false,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      'A salad is a dish usually consisting'
                                      'of a mixture of small pieces of vegetables.',
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
                          child: Container(
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.green[600],
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.green[400],
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cuisines.length,
                padding: EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (ctx, i) => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.green[300],
                      )
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        pastTitle = currentTitle;
                        currentTitle = cuisines[i];
                      });
                    },
                    child: SizedBox(
                      width: SizeConfigs.horizontalFractions * 25,
                      child: Center(
                        child: Text(
                          cuisines[i],
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
