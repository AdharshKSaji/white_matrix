import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:white_matrix/view/loginscreen/loginscreen.dart';
import 'package:white_matrix/view/scarchscreen/scarchersceen.dart';






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
          builder: (context) =>LoginScreen()
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/images/Animation - 1724427440298.json',
          width: 200.0,  
          height: 200.0, 
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
