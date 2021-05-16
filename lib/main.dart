import 'package:cookbook_app/size_configs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cookbook_app/init.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rasoi',
      theme: ThemeData(
        primarySwatch: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green[300]),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[700]),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green[700]),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[700]),
            borderRadius: BorderRadius.circular(15),
          ),
          hintStyle: TextStyle(
            color: Colors.green[700],
          ),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.green[600],
          ),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green[400]),
            textStyle: MaterialStateProperty.all(TextStyle(
              fontSize: Theme.of(context).textTheme.headline6.fontSize,
              fontWeight: FontWeight.w400,
            )),
            minimumSize: MaterialStateProperty.all(Size(170, 55)),
            side: MaterialStateProperty.all(BorderSide(color: Colors.green[600])),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.green[100]),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 15,
            )),
            textStyle: MaterialStateProperty.all(TextStyle(
              fontSize: Theme.of(context).textTheme.headline5.fontSize,
              fontWeight: FontWeight.w400,
            )),
            side: MaterialStateProperty.all(BorderSide(color: Colors.green[100])),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
          ),
        ),
      ),
      home: LayoutBuilder(
        builder: (context, constraints) {
          Firebase.initializeApp();
          SizeConfigs.setFractions(constraints);
          return Initialise();
        },
      ),
    );
  }
}
