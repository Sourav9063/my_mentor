import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_mentor/widgets/const.dart';
import 'package:my_mentor/widgets/modal_progress_hub.dart';
import 'package:my_mentor/widgets/spinkit.dart';
import 'package:my_mentor/widgets/widgets.dart';

import '../../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email = '';
  String _userName = '';
  String _password = '';
  bool verified = false;
  double aPEmail = 50;
  double aPPassword = 50;
  double aPUsername = 50;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.pink,
        body: ModalProgressHUD(
      inAsyncCall: spinner,
      opacity: .55,
      color: Colors.black,
      dismissible: true,
      progressIndicator: const SpinkitFading(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedPadding(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  padding:
                      EdgeInsets.symmetric(horizontal: aPUsername, vertical: 8),
                  child: TextFormField(
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                      setState(() {
                        aPEmail = 10;
                        //  aPEmail = 50;
                        aPUsername = 50;
                        aPPassword = 50;
                      });
                    },
                    // autovalidate: true,

                    validator: (value) {
                      if (value == '' || value == null) {
                        return 'Your name is required';
                      } else if (value.length < 4) {
                        return 'Too short';
                      }

                      return null;
                    },
                    onTap: () {
                      setState(() {
                        aPEmail = 50;
                        //  aPEmail = 50;
                        aPUsername = 10;
                        aPPassword = 50;
                      });
                    },
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      _userName = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your name', labelText: 'Username'),
                  ),
                ),
                AnimatedPadding(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  padding:
                      EdgeInsets.symmetric(horizontal: aPEmail, vertical: 4),
                  child: TextFormField(
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                      setState(() {
                        aPEmail = 50;
                        //  aPEmail = 50;
                        aPUsername = 50;
                        aPPassword = 10;
                      });
                    },
                    // autovalidate: true,
                    validator: (value) {
                      if (value == '' || value == null) {
                        return 'Your email is required';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Invalid Email';
                      }

                      return null;
                    },
                    onTap: () {
                      setState(() {
                        aPEmail = 10;
                        //  aPEmail = 50;
                        aPUsername = 50;
                        aPPassword = 50;
                      });
                    },

                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      _email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email', labelText: 'Email'),
                  ),
                ),
                AnimatedPadding(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  padding:
                      EdgeInsets.symmetric(horizontal: aPPassword, vertical: 8),
                  child: TextFormField(
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        aPEmail = 50;
                        //  aPEmail = 50;
                        aPUsername = 50;
                        aPPassword = 50;
                      });
                    },
                    onTap: () {
                      setState(() {
                        aPPassword = 10;
                        aPEmail = 50;
                        aPUsername = 50;
                        // aPPassword = 50;
                      });
                    },
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Can\'t you read!? At least 6 characters';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      _password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        // errorText: _email,

                        hintText: "Not less than 6 characters",
                        labelText: 'Password'),
                  ),
                ),
                ElevatedButton(
                    onPressed: verified
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              aPEmail = 50;
                              aPPassword = 50;
                            });
                            bool isAlright = _formKey.currentState!.validate();
                            // print(auth.currentUser.uid);
                            // auth.currentUser.uid != null
                            //     ? signUn(_email, _password)
                            //     : verifiedCheck();
                            if (isAlright) signUn(_email, _password);
                          },
                    child: const Text("Sign Up"))
              ],
            ),
          ),
        ),
      ),
    ));
  }

  final auth = FirebaseAuth.instance;
  bool spinner = false;
  spinnerState(bool value) {
    setState(() {
      spinner = value;
    });
  }

  void signUn(String email, String password) async {
    //  _email!=''? verifiedCheck():null;
    spinnerState(true);
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await auth.currentUser!.updateDisplayName(_userName);

      await auth.currentUser!.sendEmailVerification();

      spinnerState(false);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertsCompound(
      //         buttonTxt: 'Check',
      //         des:
      //             'Check your email and click the link in the description to verify',
      //         msg: 'Email Verification',
      //         color: Colors.greenAccent,
      //         function: () async {
      //           spinnerState(false);
      //           verifiedCheck();
      //           if (verified) Navigator.pop(context);
      //         },
      //       );
      //     });

      // UserDataSavedEmailPassword.saveuidSharedPref(auth.currentUser.uid);
    } on FirebaseAuthException catch (e) {
      spinnerState(false);
      showDialog(
        context: context,
        builder: (context) {
          return AlertsCompound(
            msg: 'Something Wrong',
            color: Colors.red.shade200,
            des: e.message,
            buttonTxt: 'OK',
            function: () {
              spinnerState(false);
              // spinner = false;
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }
}
