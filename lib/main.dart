import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_mentor/helper/screen_size.dart';

import 'package:my_mentor/screens/auth/sign_up.dart';
import 'package:my_mentor/screens/check_use.dart';
import 'package:my_mentor/widgets/blur_dialogue.dart';
import 'package:my_mentor/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryIconTheme:
              IconTheme.of(context).copyWith(color: Colors.white)),
      color: const Color(0xfff44552),
      home: const Init(),
    );
  }
}

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return const HomePage();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
          body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SomethingWentWrong();
          } else if (snapshot.data == null) {
            return const SignUpScreen();
          } else if (snapshot.data != null) {
            if (snapshot.data!.emailVerified == false) {
              return Container(
                color: Colors.blueGrey.shade900,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                          "Check your email and click the link to verify your account"),
                    ),
                    IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.currentUser!.reload();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                      },
                      icon: const Icon(Icons.replay_outlined),
                    ),
                    TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                        },
                        child: Text("Send Verification Mail")),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ));
                        },
                        child: Text("Sign Up with other Email"))
                  ],
                ),
              );
            } else {
              return const CheckUse();
            }
          }
          return const Center(
            child: SpinkitFading(),
          );
        },
      )),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  final String errorMsg;
  const SomethingWentWrong(
      {Key? key, this.errorMsg = 'Something Went Wrong. Restart the App.'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.white,
              size: ScreenSize.width * .55,
            ),
            const Text(
              'Error',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              errorMsg,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            IconButton(
              icon: const Icon(
                Icons.replay_rounded,
                color: Colors.white,
                size: 50,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
