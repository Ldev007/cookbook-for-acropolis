import 'package:auto_size_text/auto_size_text.dart';
import 'package:cookbook_app/size_configs.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({
    Key key,
    @required this.titlePageCont,
    @required this.contentPageCont,
  }) : super(key: key);

  final PageController titlePageCont;
  final PageController contentPageCont;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: AutoSizeText(
              'Rasoi is an app which signifies Indian traditional recipes and cusines.Using this app you can learn how to cook various dishes easily !',
              textAlign: TextAlign.center,
              minFontSize: 25,
              maxFontSize: 40,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.green[100],
              ),
            ),
          ),
          SizedBox(
            width: SizeConfigs.horizontalFractions * 40,
            child: TextButton(
              onPressed: () {
                titlePageCont.animateToPage(
                  1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInSine,
                );
                contentPageCont.animateToPage(
                  1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInSine,
                );
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                side: MaterialStateProperty.all(BorderSide(color: Colors.green[100])),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.green[200],
                    ),
                  ),
                  Text(
                    ' OR ',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Sign-Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.green[200],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
