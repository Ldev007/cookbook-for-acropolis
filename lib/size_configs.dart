import 'package:flutter/cupertino.dart';

class SizeConfigs {
  static double verticalFractions;
  static double horizontalFractions;

  static void setFractions(BoxConstraints constraints) {
    verticalFractions = constraints.maxHeight / 100;
    horizontalFractions = constraints.maxWidth / 100;
  }
}
