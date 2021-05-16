import 'package:flutter/material.dart';

class FavIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
