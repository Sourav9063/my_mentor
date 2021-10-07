import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_mentor/database/models/mentor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_mentor/database/models/task.dart';
import 'package:my_mentor/database/models/user.dart';

class StorageFunctions {
  static Future<void> addMentor(Mentor mentor, UserClass user) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('Mentors')
          .doc(mentor.email)
          .set(mentor.toMap());
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(mentor.email)
          .collection('Novics')
          .doc(user.email)
          .set(user.toMap());
    } catch (e) {
      print("***\n");
      print(e);
    }
  }

  static Future<void> addTask(Task task,) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('Task')
          .add(task.toMap());
    } catch (e) {
      print("***\n");
      print(e);
    }
  }
}
