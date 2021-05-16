import 'package:flutter/material.dart';

class CuisineBox extends StatelessWidget {
  const CuisineBox({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: this.child,
    );
  }
}
