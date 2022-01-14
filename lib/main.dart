import 'package:flutter/material.dart';
import 'package:weather_app_flutter/screens/splash.dart';
import 'package:weather_app_flutter/screens/weather_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future main() async{
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}
