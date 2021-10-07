import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_mentor/database/cloud_storage/storage_fun.dart';
import 'package:my_mentor/database/models/mentor.dart';
import 'package:my_mentor/database/models/user.dart';
import 'package:my_mentor/helper/screen_size.dart';
import 'package:my_mentor/screens/home_pages/add_tast_page.dart';
import 'package:my_mentor/screens/home_pages/list_of_task.dart';
import 'package:my_mentor/widgets/bounce_animated_nav_bar.dart';
import 'package:my_mentor/widgets/const.dart';
import 'package:my_mentor/widgets/tap_shrink_button.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  late PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          ListOfTaskPage(email: FirebaseAuth.instance.currentUser!.email!),
          Container(
            color: Colors.blue,
            child: const Center(child: Text("1")),
          ),
          AddTaskPage(),
          AddMentor(),
          Container(
            color: Colors.blue,
            child: const Center(child: Text("1")),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: BounceNavBar(
        items: [
          BounceAnimatedNavBarItem(
            widget: Icon(
              Icons.list,
              color: Colors.white,
            ),
            foregroundColor: Colors.purple,
            // backgroundColor: Colors.purpleAccent,
          ),
          BounceAnimatedNavBarItem(
            widget: Icon(
              Icons.search,
              color: Colors.white,
            ),
            foregroundColor: Colors.blue,
            // backgroundColor: Colors.blueAccent,
          ),
          BounceAnimatedNavBarItem(
            widget: Icon(
              Icons.add,
              color: Colors.white,
            ),
            foregroundColor: const Color(0xfff44552),
            // backgroundColor: Colors.pinkAccent.shade400,
            // backgroundColor:
            //     Color.lerp(Colors.pinkAccent, Colors.black, .6)!
          ),
          BounceAnimatedNavBarItem(
            widget: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            foregroundColor: Colors.indigo,
            // backgroundColor: Colors.indigoAccent,
          ),
          BounceAnimatedNavBarItem(
            widget: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            foregroundColor: Colors.deepPurpleAccent,
            // backgroundColor: Colors.deepPurple,
          ),
        ],
        onTabChanged: (value) {
          pageController.animateToPage(value,
              duration: Duration(milliseconds: 1200),
              curve: Curves.easeInOutCubic);
        },
      ),
    );
  }
}

class AddMentor extends StatelessWidget {
  AddMentor({
    Key? key,
  }) : super(key: key);
  late String name = '';
  late String _email = '';
  late String _relation = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.blue.shade900,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              // height:
              child: Stack(
                children: [
                  Center(
                    child: LottieBuilder.network(
                        "https://assets6.lottiefiles.com/private_files/lf30_4FGi6N.json",
                        width: ScreenSize.width * .7,
                        height: ScreenSize.height * .4),
                  ),
                  Align(
                    alignment: Alignment(-1, .75),
                    child: Text(
                      "MENTOR",
                      style: kHeaderText.copyWith(color: Colors.white38),
                    ),
                  ),
                ],
              ),
            ),
            Text('Doctor, Helth advisor, Trainer etc'),
            // Divider(),
            SizedBox(height: 10),
            // const Center(child: Text("0")),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == '' || value == null) {
                  return 'Name is required';
                }

                return null;
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                name = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Name of mentor', labelText: 'Name'),
            ),
            SizedBox(height: 8),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                _email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email', labelText: 'Email'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == '' || value == null) {
                  return 'Relationship is required';
                }

                return null;
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                _relation = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Relationship with mentor', labelText: 'Relation'),
            ),
            TapShrinkButton(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  bool val = _formKey.currentState!.validate();
                  if (val) {
                    await StorageFunctions.addMentor(
                        Mentor(name: name, email: _email, relation: _relation),
                        UserClass(
                            name:
                                FirebaseAuth.instance.currentUser!.displayName!,
                            email: FirebaseAuth.instance.currentUser!.email!));
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(8),
                    child: const Center(child: Text("Add as Mentor")))),
            const Divider(
              color: Colors.white70,
            ),
            TextButton(onPressed: () async {}, child: Text("QR Code")),
            SizedBox(height: kBottomNavigationBarHeight),
          ],
        ),
      ),
    );
  }
}
