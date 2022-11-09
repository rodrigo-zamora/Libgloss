import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:libgloss/screens/new_books/home_new.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }
  
  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }
  
  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => HomeNew()
      )
    ); 
  }
  
  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset("assets/images/icon/icon.png"),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Text(
                "Splash Screen",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}