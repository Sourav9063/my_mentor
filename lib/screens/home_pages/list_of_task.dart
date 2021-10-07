import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_mentor/database/models/task.dart';
import 'package:my_mentor/screens/clock_screen.dart';
import 'package:my_mentor/widgets/const.dart';
import 'package:my_mentor/widgets/widgets.dart';

class ListOfTaskPage extends StatefulWidget {
  ListOfTaskPage({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  _ListOfTaskPageState createState() => _ListOfTaskPageState();
}

class _ListOfTaskPageState extends State<ListOfTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xff000C18),
      child: SafeArea(
        // padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "TASK",
              style: kHeaderText.copyWith(color: Colors.white60),
              textAlign: TextAlign.left,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(widget.email)
                      .collection('Task')
                      .orderBy('beginTime')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      List<Task> tasks = snapshot.data!.docs
                          .map((e) => Task.fromMap(e.data()))
                          .toList();
                      return ListOfTask(
                        email: widget.email,
                        tasks: tasks,
                      );
                    }
                    return SpinkitFading();
                  }),
            ),
            SizedBox(height: kBottomNavigationBarHeight),
          ],
        ),
      ),
    );
  }
}

class ListOfTask extends StatelessWidget {
  const ListOfTask({Key? key, required this.tasks, required this.email})
      : super(key: key);
  final List<Task> tasks;
  final String email;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8),
          color: Colors.white12,
          child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          email == FirebaseAuth.instance.currentUser!.email!
                              ? ClockScreen(
                                  task: tasks[index],
                                )
                              : TaskDetails(),
                    ));
              },
              title: Text(tasks[index].name),
              subtitle: Text(tasks[index].beginTime.toString())),
        );
      },
    );
  }
}

class TaskDetails extends StatelessWidget {
  const TaskDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("Deatil Information of the Task done by the patient"));
  }
}
