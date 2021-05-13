import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      'Welcome !',
      textAlign: TextAlign.center,
      maxFontSize: 50,
      minFontSize: 35,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.green[100],
      ),
    );
  }
}
