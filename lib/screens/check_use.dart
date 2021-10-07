import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_mentor/screens/home_pages/mentor/mentor_homepage.dart';
import 'package:my_mentor/screens/user_home.dart';
import 'package:my_mentor/widgets/tap_shrink_button.dart';

class CheckUse extends StatefulWidget {
  const CheckUse({Key? key}) : super(key: key);

  @override
  _CheckUseState createState() => _CheckUseState();
}

class _CheckUseState extends State<CheckUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TapShrinkButton(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const UserHomeScreen(),
                    ));
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.blue,
                  ),
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(8),
                  child: Center(child: Text("User")))),
          TapShrinkButton(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ModeratorHomeScreen(),
                    ));
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.blue,
                  ),
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(8),
                  child: Center(child: Text("Mentor"))))
        ],
      ),
    );
  }
}
