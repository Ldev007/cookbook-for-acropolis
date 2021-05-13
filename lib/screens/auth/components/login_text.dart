import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AuthText extends StatelessWidget {
  const AuthText({
    Key key,
    @required this.titlePageCont,
    @required this.contentPageCont,
  }) : super(key: key);

  final PageController titlePageCont;
  final PageController contentPageCont;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 60, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              titlePageCont.animateToPage(
                0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInSine,
              );
              contentPageCont.animateToPage(
                0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInSine,
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.green[100],
            ),
          ),
          AutoSizeText(
            'Login or Sign-Up',
            textAlign: TextAlign.center,
            maxFontSize: 50,
            minFontSize: 28,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.green[100],
            ),
          ),
        ],
      ),
    );
  }
}
