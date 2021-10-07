import 'package:flutter/material.dart';

class ScreenSize {
  static late MediaQueryData _mediaQueryData;
  static late double width;
  static late double height;
  static late double defaultSize;
  static late Orientation orientation;
  // _ScreenSize(){}
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}
