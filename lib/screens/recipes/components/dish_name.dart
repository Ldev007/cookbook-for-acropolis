import 'package:flutter/material.dart';

class DishName extends StatelessWidget {
  const DishName({
    Key key,
    @required this.firstWord,
    @required this.secondWord,
  }) : super(key: key);

  final String firstWord;
  final String secondWord;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '$firstWord\n',
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline5.fontSize,
          fontWeight: FontWeight.w300,
          color: Colors.green[600],
        ),
        children: [
          TextSpan(
            text: secondWord,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
        ],
      ),
      overflow: TextOverflow.visible,
      softWrap: false,
    );
  }
}
