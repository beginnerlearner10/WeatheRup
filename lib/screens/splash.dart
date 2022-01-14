import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_flutter/screens/weather_app.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>WeatherApp()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              'WeatheRup',
              style: GoogleFonts.aclonica(
                fontSize:50.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 50.0,),
          Center(
            child: SpinKitSpinningLines(
              size: 100.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.0,),
          Container(
            child: Text(
              'Loading...',
              style: GoogleFonts.aclonica(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
                letterSpacing: 3.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
