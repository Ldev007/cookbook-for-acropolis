import 'package:cookbook_app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../size_configs.dart';

class Login extends StatelessWidget {
  TextEditingController textEditingCont = TextEditingController();

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () async {
              final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

              final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

              final credential = GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken,
              );

              toast('Login successfull !');

              HomeScreen().launch(context);

              return await FirebaseAuth.instance.signInWithCredential(credential);
            },
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
                  GoogleLogoWidget(),
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
            onPressed: () async {
              FirebaseAuth auth = FirebaseAuth.instance;
              PhoneAuthCredential creds;
              String verifCode;
              String smsCode;

              await auth.verifyPhoneNumber(
                phoneNumber: '+918770062967',
                verificationCompleted: (phoneAuthCredential) {
                  creds = phoneAuthCredential;
                },
                codeSent: (verificationId, forceResendingToken) {
                  toast('Code has been sent');
                  verifCode = verificationId;
                },
                codeAutoRetrievalTimeout: (s) => toast(s),
                verificationFailed: (error) => toast(error.toString()),
              );

              showModalBottomSheet(
                context: context,
                builder: (cx) => SingleChildScrollView(
                  child: Container(
                    width: SizeConfigs.horizontalFractions * 100,
                    height: SizeConfigs.verticalFractions * 25,
                    padding: EdgeInsets.fromLTRB(35, 10, 35, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Enter OTP below',
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.headline5.fontSize,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        PinCodeTextField(
                          controller: textEditingCont,
                          focusNode: focusNode,
                          onChanged: (val) => null,
                          length: 6,
                          appContext: context,
                          showCursor: false,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            activeFillColor: Colors.green[100],
                            activeColor: Colors.green[300],
                            selectedColor: Colors.green[500],
                            selectedFillColor: Colors.green[500],
                            inactiveColor: Colors.green[200],
                            inactiveFillColor: Colors.green[200],
                            borderRadius: BorderRadius.circular(15),
                            borderWidth: 1.5,
                            fieldHeight: 55,
                            fieldWidth: 50,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          autoDisposeControllers: false,
                          autoDismissKeyboard: false,
                          onSubmitted: (value) async {
                            smsCode = value;

                            PhoneAuthCredential cred =
                                PhoneAuthProvider.credential(verificationId: verifCode, smsCode: smsCode);

                            await auth.signInWithCredential(creds ?? cred);

                            HomeScreen().launch(context);

                            return toast('Login successfull !');
                          },
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                              BorderSide(color: Colors.black54),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(150, 45)),
                            backgroundColor: MaterialStateProperty.all(Colors.green[100]),
                          ),
                          onPressed: () async {
                            focusNode.unfocus();
                          },
                          child: Text('Submit'),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
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
