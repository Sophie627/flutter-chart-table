import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  
  @override
  _TopBarState createState() => new _TopBarState();
}

class _TopBarState extends State<TopBar> {

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      title: Container(
        height: 35.0,
        child: Image.asset("images/logo.png"),
      ),
      centerTitle: false,
    );
  }
}