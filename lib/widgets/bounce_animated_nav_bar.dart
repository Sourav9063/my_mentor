import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// https://www.youtube.com/watch?v=RVBJPXjgm9E&t=608s&ab_channel=diegoveloper
//15:11

class BounceNavBar extends StatefulWidget {
  const BounceNavBar(
      {Key? key,
      required this.items,
      required this.onTabChanged,
      this.movementWidth = 75.0,
      this.movementHeight = 60.0,
      this.initialIndex = 0})
      : super(key: key);
  final List<BounceAnimatedNavBarItem> items;
  final ValueChanged<int> onTabChanged;
  final int initialIndex;
  final double movementWidth;
  final double movementHeight;

  @override
  _BounceNavBarState createState() => _BounceNavBarState();
}

class _BounceNavBarState extends State<BounceNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animeNavBarIn;
  late Animation _animeNavBarOut;
  late Animation _animeCircle;
  late Animation _animatedColor;
  late Animation _animeItemEleOut;
  late Animation _animeItemEleIn;
  late int currentIndex;
  late Color _nextColor = widget.items[widget.initialIndex].backgroundColor;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _animeNavBarIn =
        CurveTween(curve: Interval(0.0, .6, curve: Curves.decelerate))
            .animate(_controller);
    _animeNavBarOut =
        CurveTween(curve: Interval(0.6, 1, curve: Curves.bounceOut))
            .animate(_controller);
    _animeCircle =
        CurveTween(curve: Interval(0.0, .7, curve: Curves.linear)).animate(
      _controller,
    );
    _animatedColor = ColorTween(
            begin: widget.items[widget.initialIndex].backgroundColor,
            end: widget.items[widget.initialIndex].backgroundColor)
        .animate(CurvedAnimation(
            parent: _controller,
            curve: Interval(.5, 1, curve: Curves.easeOutCubic)));
    _animeItemEleOut =
        CurveTween(curve: Interval(0.1, .6, curve: Curves.easeInCubic))
            .animate(_controller);
    _animeItemEleIn =
        CurveTween(curve: Interval(0.6, 1, curve: Curves.bounceOut))
            .animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double currentWidth = width;
    // double currentHeight = kBottomNavigationBarHeight;
    double currentEle = 0.0;

    print("NavBar build");
    return SizedBox(
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            currentWidth = width -
                (widget.movementWidth * _animeNavBarIn.value) +
                (widget.movementWidth * _animeNavBarOut.value);

            currentEle = -widget.movementHeight * _animeItemEleOut.value +
                (widget.movementHeight - kBottomNavigationBarHeight / 3) *
                    _animeItemEleIn.value;

            return Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(08),
              // height: currentHeight,
              width: currentWidth - 20,
              decoration: BoxDecoration(
                  color: _animatedColor.value,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.items.length,
                  (index) {
                    final innerWidget = CircleAvatar(
                      backgroundColor: widget.items[index].foregroundColor,
                      radius: 20,
                      child: widget.items[index].widget,
                    );
                    return currentIndex == index
                        ? Expanded(
                            child: CustomPaint(
                              painter: _CirclePainter(
                                  widget.items[index].backgroundColor,
                                  progress: _animeCircle.value),
                              child: Transform.translate(
                                offset: Offset(0.0, currentEle),
                                child: innerWidget,
                              ),
                            ),
                          )
                        : Expanded(
                            child: GestureDetector(
                            onTap: () {
                              _animatedColor = ColorTween(
                                      begin: _nextColor,
                                      end: widget.items[index].backgroundColor)
                                  .animate(CurvedAnimation(
                                      parent: _controller,
                                      curve: Interval(.5, 1,
                                          curve: Curves.easeOutCubic)));
                              widget.onTabChanged(index);
                              setState(() {
                                currentIndex = index;
                              });

                              _controller
                                  .forward(from: 0.0)
                                  .whenCompleteOrCancel(() {
                                _nextColor =
                                    widget.items[index].backgroundColor;
                              });
                            },
                            child: innerWidget,
                          ));
                  },
                ),
              ),
            );
          }),
    );
  }
}

class BounceAnimatedNavBarItem {
  ///the widget of that item
  final Widget widget;

  ///circle color
  final Color foregroundColor;

  ///navbar color
  late Color backgroundColor;

  BounceAnimatedNavBarItem({
    required this.widget,
    required this.foregroundColor,
  }) : backgroundColor = Color.lerp(foregroundColor, Colors.black, .5)!;
}

class _CirclePainter extends CustomPainter {
  final double progress;
  final Color color;

  _CirclePainter(this.color, {required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 30 * progress;
    const strockwidth = 10.0;
    final curStrockWidth = strockwidth * (1 - progress);
    if (progress < 1.0) {
      canvas.drawCircle(
          center,
          radius,
          Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = curStrockWidth);
    }
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_CirclePainter oldDelegate) => true;
}

// Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: CircleAvatar(
//                           backgroundColor: Colors.yellow.withOpacity(.6),
//                           radius: 20,
//                           child: GestureDetector(
//                             child: Icon(Icons.person),
//                             onTap: () {
//                               _endColor = Colors.yellow.withOpacity(.6);
//                               _animatedColor =
//                                   ColorTween(begin: _beginColor, end: _endColor)
//                                       .animate(_controller);

//                               _controller.forward(from: 0.0).whenComplete(() {
//                                 _beginColor = Colors.yellow.withOpacity(.6);
//                               });
//                             },
//                           ),
//                         ),
//                       ),
// onTap: () {
//                                   _endColor = Colors.blue.withOpacity(.6);
//                                   _animatedColor = ColorTween(
//                                           begin: _beginColor, end: _endColor)
//                                       .animate(_controller);

//                                   _controller.forward(from: 0.0).whenComplete(
//                                     () {
//                                       _beginColor =
//                                           Colors.blue.withOpacity(.6);
//                                     },
//                                   );
//                                 },