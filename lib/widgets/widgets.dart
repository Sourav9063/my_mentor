import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_mentor/helper/screen_size.dart';
import 'package:my_mentor/widgets/spinkit.dart';

class AlertsCompound extends StatelessWidget {
  final Color? color;
  final String msg;
  final String? des;
  final String buttonTxt;
  final Function? function;
  const AlertsCompound(
      {Key? key,
      required this.msg,
      required this.des,
      this.function,
      required this.buttonTxt,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: color,
      title: Text(msg),
      content: Text(des!),
      actions: <Widget>[
        TextButton(
          child: Text(buttonTxt),
          onPressed: function as void Function()?,
        )
      ],
    );
  }
}
class SpinkitFading extends StatelessWidget {
  final String? msg;

  const SpinkitFading({Key? key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
            child: Container(
              height: ScreenSize.height,
              width: ScreenSize.width,
              color: Colors.black.withOpacity(.7),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: ScreenSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: SpinKitFadingCube(
                      size: ScreenSize.width * .17,
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index % 3 == 0
                                ? Colors.red
                                : Color(0xffffb8b24),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    msg == null ? 'Loading...' : msg!,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}