import 'package:cookbook_app/size_configs.dart';
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
        primarySwatch: Colors.blue,
      ),
      home: LayoutBuilder(
        builder: (context, constraints) {
          SizeConfigs.setFractions(constraints);
          return Initialise();
        },
      ),
    );
  }
}
