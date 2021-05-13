import 'dart:ui';

import 'package:cookbook_app/screens/auth/components/login_text.dart';
import 'package:cookbook_app/screens/auth/components/welcome_text.dart';
import 'package:cookbook_app/screens/auth/components/info.dart';
import 'package:cookbook_app/size_configs.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class AuthOne extends StatefulWidget {
  @override
  _AuthOneState createState() => _AuthOneState();
}

class _AuthOneState extends State<AuthOne> {
  PageController titlePageCont = PageController();

  PageController contentPageCont = PageController();

  bool showButton = true;

  @override
  void initState() {
    titlePageCont.addListener(() {
      if (titlePageCont.page == 0.0) {
        setState(() {
          showButton = true;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mjl8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  width: SizeConfigs.horizontalFractions * 100,
                  height: SizeConfigs.verticalFractions * 100,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
            Center(
              child: Container(
                width: SizeConfigs.horizontalFractions * 80,
                height: SizeConfigs.verticalFractions * 40,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(
                                child: PageView(
                                  physics: NeverScrollableScrollPhysics(),
                                  controller: titlePageCont,
                                  children: [
                                    WelcomeText(),
                                    AuthText(
                                      titlePageCont: titlePageCont,
                                      contentPageCont: contentPageCont,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                indent: 70,
                                endIndent: 70,
                                color: Colors.green[100],
                                thickness: 0,
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 45),
                            child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: contentPageCont,
                              children: [
                                Info(
                                  titlePageCont: titlePageCont,
                                  contentPageCont: contentPageCont,
                                ),
                                Login(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
