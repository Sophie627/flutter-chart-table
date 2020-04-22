import 'package:flutter/material.dart';

class ScreenSelect extends StatefulWidget {
  String title;
  bool color;

  ScreenSelect({this.title, this.color});
  
  @override
  _ScreenSelectState createState() => new _ScreenSelectState();
}

class _ScreenSelectState extends State<ScreenSelect> {

  @override
  Widget build(BuildContext context) {
    Color btncolor;

    if (widget.color) btncolor = Color(0xFFFF6500);
    else btncolor = Colors.black;

    return Padding(
      padding: EdgeInsets.only(top: 5.0),
      child: new Container(
        height: 35.0,
        color: btncolor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}