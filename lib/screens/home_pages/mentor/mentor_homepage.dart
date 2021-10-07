import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_mentor/database/models/user.dart';
import 'package:my_mentor/widgets/bounce_animated_nav_bar.dart';
import 'package:my_mentor/widgets/const.dart';
import 'package:my_mentor/widgets/widgets.dart';

import '../../clock_screen.dart';
import '../list_of_task.dart';

class ModeratorHomeScreen extends StatefulWidget {
  const ModeratorHomeScreen({Key? key}) : super(key: key);

  @override
  _ModeratorHomeScreenState createState() => _ModeratorHomeScreenState();
}

class _ModeratorHomeScreenState extends State<ModeratorHomeScreen> {
  late PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          ListOfUsers(),
          ListOfTaskPage(email: FirebaseAuth.instance.currentUser!.email!),
          Container(
            color: Colors.blue,
            child: const Center(child: Text("1")),
          ),
          // AddTaskPage(),
          // AddMentor(),
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

class ListOfUsers extends StatelessWidget {
  const ListOfUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('Novics')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<UserClass> users = snapshot.data!.docs
              .map((e) => UserClass.fromMap(e.data()))
              .toList();
          return ListOfNovics(
            users: users,
          );
        }
        return SpinkitFading();
      },
    );
  }
}

class ListOfNovics extends StatelessWidget {
  const ListOfNovics({Key? key, required this.users}) : super(key: key);
  final List<UserClass> users;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            "PATIENTS",
            style: kHeaderText.copyWith(color: Colors.white38),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  color: Colors.white12,
                  child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ListOfTaskPage(
                                email: users[index].email,
                              ),
                            ));
                      },
                      title: Text(users[index].name),
                      subtitle: Text(users[index].email)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
