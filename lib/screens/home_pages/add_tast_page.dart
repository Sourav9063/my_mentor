import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_mentor/database/cloud_storage/storage_fun.dart';
import 'package:my_mentor/database/models/task.dart';
import 'package:my_mentor/helper/screen_size.dart';
import 'package:my_mentor/widgets/const.dart';
import 'package:my_mentor/widgets/tap_shrink_button.dart';

class AddTaskPage extends StatefulWidget {
  AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late String taskName;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  final TextEditingController stc = TextEditingController();
  final TextEditingController etc = TextEditingController();

  late String ex;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      color: Colors.pinkAccent.shade700,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  LottieBuilder.network(
                      "https://assets6.lottiefiles.com/packages/lf20_42B8LS.json"),
                  Text(
                    "TASK",
                    style: kHeaderText.copyWith(color: Colors.white60),
                  ),
                ],
              ),
            ),

            Text("Medication, Exersice, Walking, Sleeping etc"),
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
                taskName = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Name of Task', labelText: 'Task'),
            ),
            SizedBox(height: 8),
            TextFormField(
              readOnly: true,

              controller: stc,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == '' || value == null) {
                  return "Start Time is required";
                }
                //  else if (!RegExp(
                //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                //     .hasMatch(value)) {
                //   return 'Invalid Email';
                // }

                return null;
              },
              onTap: () async {
                var time = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                if (time != null) {
                  startTime = time;
                }
                stc.text = startTime.format(context);
                print(time.toString());
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              // onChanged: (value) {
              //   _email = value;
              // },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Start time of the task', labelText: 'Start Time'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              readOnly: true,
              controller: etc,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == '' || value == null) {
                  return 'End time is required';
                }

                return null;
              },
              onTap: () async {
                // showDatePicker(context: context, initialDate: DateTime.now());
                var time = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                if (time != null) {
                  endTime = time;
                }
                etc.text = endTime.format(context);
                print(time.toString());
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              // onChanged: (value) {
              //   _relation = value;
              // },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'End time of the task', labelText: 'End Time'),
            ),
            TapShrinkButton(
                onTap: () async {
                  // FocusScope.of(context).unfocus();
                  bool val = _formKey.currentState!.validate();
                  if (val) {
                    await StorageFunctions.addTask(Task(
                        name: taskName,
                        beginTime: startTime.format(context),
                        endTime: endTime.format(context)));
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(8),
                    child: const Center(child: Text("Add Task")))),
            SizedBox(height: kBottomNavigationBarHeight),

            // const Divider(
            //   color: Colors.white70,
            // ),
            // TextButton(onPressed: () async {}, child: Text("QR Code"))
          ],
        ),
      ),
    );
  }
}
