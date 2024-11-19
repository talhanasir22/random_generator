import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeContainer extends StatefulWidget{
  const ThemeContainer({super.key, this.child});

  final child;

  @override
  State<ThemeContainer> createState() => _ThemeContainerState();
}

class _ThemeContainerState extends State<ThemeContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [
        Colors.purple.shade300,
        Colors.blue.shade700,
        Colors.blueGrey,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
    ),
    ),
      child: widget.child,
    );
  }
}