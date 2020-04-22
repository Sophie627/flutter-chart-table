import 'package:flutter/material.dart';
import 'package:youtimizer/Root.dart';
import 'package:youtimizer/Pages/Welcome.dart';
import 'package:youtimizer/Pages/Home.dart';
import 'package:youtimizer/Pages/gain_screen.dart';
import 'package:youtimizer/Pages/profile_screen.dart';

void main() => runApp(MainPage());

class MainPage extends StatefulWidget{
  createState() => MainPageState();
}

class MainPageState extends State<MainPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Root(),
      routes: <String, WidgetBuilder>{
        '/root': (BuildContext context) => new Root(),
        '/home': (BuildContext context) => new Home(),
        '/gain': (BuildContext context) => new GainScreen(),
        '/profile': (BuildContext context) => new ProfileScreen(),
      },
    );
  }
}