import 'dart:async';
import 'package:flutter/material.dart';

import 'main.dart';

class SplashPage extends StatefulWidget{
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color(0xFF3533CD),
      child:  const Center(
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Color(0xFF3533CD),
            backgroundImage: AssetImage('assets/Images/Logo.png',),
          )
      ),
    );
  }
}
