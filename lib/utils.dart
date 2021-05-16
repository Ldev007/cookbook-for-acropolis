import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Utils {
  static InputDecoration getTextFieldDecoration(String hintTxt) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green[300]),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green[700]),
        borderRadius: BorderRadius.circular(15),
      ),
      hintText: hintTxt,
      hintStyle: TextStyle(
        color: Colors.green[700],
      ),
    );
  }

  static ButtonStyle getButtonStyle(BuildContext ctx, {double width, double height}) {
    return ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.green[400]),
      textStyle: MaterialStateProperty.all(TextStyle(
        fontSize: Theme.of(ctx).textTheme.headline6.fontSize,
        fontWeight: FontWeight.w400,
      )),
      minimumSize: MaterialStateProperty.all(Size(width ?? 170, height ?? 55)),
      side: MaterialStateProperty.all(BorderSide(color: Colors.green[600])),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
    );
  }

  static errorToast(String text, ToastGravity gravity) {
    toast(text, bgColor: Colors.red[700], gravity: gravity);
  }

  static normalToast(String text, ToastGravity gravity) {
    toast(text, gravity: gravity);
  }
}
