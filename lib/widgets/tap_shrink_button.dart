import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TapShrinkButton extends StatefulWidget {
  const TapShrinkButton(
      {Key? key,
      required this.onTap,
      required this.child,
      this.shrinkfactor = .7})
      : assert(shrinkfactor >= 0 && shrinkfactor <= 1, "from 1 to 0"),
        super(key: key);
  final VoidCallback onTap;
  final Widget child;
  final double shrinkfactor;

  @override
  _TapShrinkButtonState createState() => _TapShrinkButtonState();
}

class _TapShrinkButtonState extends State<TapShrinkButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: kLongPressTimeout,
      reverseDuration: Duration(milliseconds: 200));
  late Animation<double> shrink =
      Tween<double>(begin: 1, end: widget.shrinkfactor).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
          reverseCurve: Cubic(.15, -.5, .5, .0)));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.scale(
              scale: shrink.value,
              child: child,
            ),
        child: GestureDetector(
            onTapDown: (details) {
              _controller.forward().whenComplete(() {
                _controller.reverse().whenComplete(widget.onTap);
              });
            },
            onTapUp: (details) {
              _controller.reverse();
            },
            child: widget.child));
  }
}
