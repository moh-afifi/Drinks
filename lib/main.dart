import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'screens/weekly_home.dart';
import 'screens/login.dart';
import 'screens/home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: Weekly(),
//        title: new Text('Drinks',
//          style: new TextStyle(
//              color: Colors.purple,
//              fontWeight: FontWeight.bold,
//              fontSize: 40.0
//          ),),
        image: Image.asset('images/splash2.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 150.0,
        loaderColor: Colors.purple
    );
  }
}