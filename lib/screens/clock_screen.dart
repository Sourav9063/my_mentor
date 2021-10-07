import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_mentor/database/models/task.dart';
import 'package:my_mentor/widgets/const.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late Timer ticker;
  final duration = Duration(seconds: 1);
  int minutes = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ticker = Timer.periodic(duration, (timer) {
      print(TimeOfDay.now().minute);
      setState(() {
        minutes = minutes + 1;
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        ticker = Timer.periodic(duration, (timer) {
          print(TimeOfDay.now().minute);
          setState(() {
            minutes = minutes + 1;
          });
        });
        ;
        break;
      case AppLifecycleState.inactive:
        ticker.cancel();
        break;
      case AppLifecycleState.paused:
        ticker.cancel();
        break;
      case AppLifecycleState.detached:
        ticker.cancel();
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ticker.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000C38),
      body: SafeArea(
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                (minutes ~/ 60).toString() + ":" + (minutes % 60).toString(),
                style: kHeaderText,
              ),
              Text(widget.task.beginTime),
              Text(widget.task.endTime),
            ],
          ),
        ),
      ),
    );
  }
}
