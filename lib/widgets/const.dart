import 'package:flutter/material.dart';
import 'package:my_mentor/helper/screen_size.dart';

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.black54,

  errorStyle: TextStyle(fontWeight: FontWeight.bold),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(width: 4.0, color: Colors.red),
  ),

  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(18)),
    borderSide: BorderSide(width: 0.0),
  ),

  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
  // border: OutlineInputBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
  // ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(18)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff7b2cbf), width: 4.0),
    borderRadius: BorderRadius.all(Radius.circular(50.0)),
  ),
);

var kHeaderText = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: ScreenSize.height * .1,
);
