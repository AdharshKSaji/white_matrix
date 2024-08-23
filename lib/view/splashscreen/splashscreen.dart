import 'package:flutter/material.dart';
import 'package:white_matrix/view/homescreen/homescreen.dart';

import 'package:white_matrix/view/loginscreen/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key, this.islogged = false});
  final bool islogged;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>HomeScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "",
          scale: 5.0,
        ),
      ),
    );
  }
}
