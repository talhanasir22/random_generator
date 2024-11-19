import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:random_generator/DragableWidget.dart';

class InfiniteDragableSlider extends StatefulWidget {
  const InfiniteDragableSlider({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.index = 0,
  });

  final Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final int index;

  @override
  State<InfiniteDragableSlider> createState() => _InfiniteDragableSliderState();
}

class _InfiniteDragableSliderState extends State<InfiniteDragableSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late int index;
  final double defaultAngle18Degree = -pi * 0.1;

  SlideDirection slidedirection = SlideDirection.left;

  Offset getOffset(int stackIndex) {
    return {
      0: Offset(lerpDouble(0,-70, controller.value)!, 30),
      1: Offset(lerpDouble(-70,70, controller.value)!, 30),
      2: Offset(70, 30) * (1- controller.value),
    }[stackIndex] ??
        Offset(MediaQuery.of(context).size.width * controller.value *
            (slidedirection == SlideDirection.left ? -1 :1),
            0);
  }

  double getAngle(int stackIndex) =>
      {
        0: lerpDouble(0, defaultAngle18Degree, controller.value),
        1: lerpDouble(defaultAngle18Degree, -defaultAngle18Degree, controller.value),
        2: lerpDouble(-defaultAngle18Degree, 0, controller.value),
      }[stackIndex] ??
          0.0;

  double getScale(int stackIndex) =>
      {
        0: lerpDouble(0.6, 0.9, controller.value),
        1: lerpDouble(0.9, 0.95, controller.value),
        2: lerpDouble(0.95, 1, controller.value),
      }[stackIndex] ??
          1.0;

  void onSlideOut(SlideDirection direction) {
    slidedirection  = direction;
    controller.forward();
  }

  void animationListener() {
    if (controller.isCompleted) {
      setState(() {
        if (widget.itemCount == ++index) {
          index = 0;
        }
      });
      controller.reset();
    }
  }

  @override
  void initState() {
    super.initState();

    // Initialize the index with the passed value from the widget
    index = widget.index;

    // Initialize the AnimationController
    controller =
    AnimationController(vsync: this, duration: kThemeAnimationDuration)
      ..addListener(animationListener);
  }

  @override
  void dispose() {
    controller
      ..removeListener(animationListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context,_) {
        return Stack(
          children: List.generate(
            4,
                (stackIndex) {
              final modIndex = (index + 3 - stackIndex) % widget.itemCount;
              return Transform.translate(
                offset: getOffset(stackIndex),
                child: Transform.scale(
                  scale: getScale(stackIndex),
                  child: Transform.rotate(
                    angle: getAngle(stackIndex),
                    child: DrageableWidget(
                      onSlideOut: onSlideOut,
                      child: widget.itemBuilder(context, modIndex),
                      isEnabled: stackIndex == 3,
                    ),
                  ), // Transform.rotate
                ), // Transform.scale
              ); // Transform.translate
            },
          ),
        );

      },
    );
  }
}
