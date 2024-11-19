import 'package:flutter/material.dart';
import 'package:random_generator/ThemeContainer.dart';

class PlaceholderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ThemeContainer(child: Column()),
    );
  }
}