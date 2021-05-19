import 'package:cookbook_app/screens/auth/firebase_methods.dart';
import 'package:cookbook_app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:cookbook_app/utils.dart';
import '../../size_configs.dart';

class Login extends StatelessWidget {
  final TextEditingController otpCont = TextEditingController();
  final TextEditingController _mobNoCont = TextEditingController();
  final PageController _otpVerifyCont = PageController();
  final FocusNode _fNodeForOtp = FocusNode();
  final FocusNode _fNodeForMobNo = FocusNode();

  @override
  Widget build(BuildContext context) {
    _fNodeForMobNo.requestFocus();

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

              checkProfileExistsOrNot(
                context,
                filterByMobNo: false,
                email: googleUser.email,
              );

              return await FirebaseAuth.instance.signInWithCredential(credential);
            },
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
              String verifId;
              String smsCode;

              showModalBottomSheet(
                context: context,
                builder: (cx) => SingleChildScrollView(
                  child: Container(
                    width: SizeConfigs.horizontalFractions * 100,
                    height: SizeConfigs.verticalFractions * 25,
                    padding: EdgeInsets.fromLTRB(35, 10, 35, 20),
                    child: PageView(
                      controller: _otpVerifyCont,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Enter mobile number below',
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.headline5.fontSize,
                                color: Colors.green[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextField(
                              controller: _mobNoCont,
                              focusNode: _fNodeForMobNo,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(hintText: 'Mobile Number'),
                              buildCounter: (context, {currentLength, isFocused, maxLength}) => Container(),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!_mobNoCont.text.isEmptyOrNull && _mobNoCont.text.length == 10) {
                                  await auth.verifyPhoneNumber(
                                    phoneNumber: '+91' + _mobNoCont.text,
                                    verificationCompleted: (phoneAuthCredential) {
                                      creds = phoneAuthCredential;
                                    },
                                    codeSent: (verificationId, forceResendingToken) {
                                      toast('Code has been sent');
                                      verifId = verificationId;
                                    },
                                    codeAutoRetrievalTimeout: (s) => null,
                                    verificationFailed: (error) {
                                      print(error.toString());
                                      toast(error.toString());
                                    },
                                  );
                                  _otpVerifyCont.nextPage(
                                    duration: Duration(milliseconds: 1000),
                                    curve: Curves.easeInSine,
                                  );
                                  _fNodeForOtp.requestFocus();
                                } else {
                                  Utils.errorToast('Enter a valid mobile number', ToastGravity.TOP);
                                }
                              },
                              child: Text('Send OTP'),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 80),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.green[800],
                                    ),
                                    onPressed: () => _otpVerifyCont.previousPage(
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.easeInSine,
                                    ),
                                  ),
                                  // 564897
                                  Text(
                                    'Enter OTP below',
                                    style: TextStyle(
                                      fontSize: Theme.of(context).textTheme.headline5.fontSize,
                                      color: Colors.green[800],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PinCodeTextField(
                              controller: otpCont,
                              focusNode: _fNodeForOtp,
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
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  if (!otpCont.text.isEmptyOrNull) {
                                    smsCode = otpCont.text;

                                    PhoneAuthCredential cred = PhoneAuthProvider.credential(
                                      verificationId: verifId,
                                      smsCode: smsCode,
                                    );

                                    await auth.signInWithCredential(creds ?? cred);

                                    await checkProfileExistsOrNot(
                                      context,
                                      filterByMobNo: true,
                                      mobNo: '+91' + _mobNoCont.text,
                                    );

                                    return toast('Login successfull !');
                                  } else {
                                    Utils.errorToast(
                                      'Enter a valid OTP',
                                      ToastGravity.TOP,
                                    );
                                  }
                                } catch (e) {
                                  print(e.toString());
                                  Utils.errorToast(
                                    'Incorrect OTP entered !',
                                    ToastGravity.TOP,
                                  );
                                }
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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