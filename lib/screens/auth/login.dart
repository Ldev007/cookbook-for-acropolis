import 'package:flutter/material.dart';

import '../../size_configs.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () => null,
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
            child: SizedBox(
              width: SizeConfigs.horizontalFractions * 50,
              child: Row(
                children: [
                  Text(
                    'Login with google',
                  ),
                  SizedBox(width: 15),
                  Image.network(
                    'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png',
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
          Text(
            'OR',
            style: TextStyle(
              color: Colors.green[100],
              fontWeight: FontWeight.w200,
              fontSize: Theme.of(context).textTheme.headline5.fontSize,
            ),
          ),
          TextButton(
            onPressed: () => null,
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
            child: SizedBox(
              width: SizeConfigs.horizontalFractions * 50,
              child: FittedBox(
                child: Row(
                  children: [
                    Text(
                      'Login with OTP',
                    ),
                    SizedBox(width: 15),
                    Icon(Icons.perm_phone_msg_outlined),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
