import 'dart:async';

import 'package:flutter/material.dart';

import 'base_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Base()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/images/landing_page.png'),
    );
  }
}
