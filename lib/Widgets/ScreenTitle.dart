import 'package:flutter/material.dart';

class ScreenTitle extends StatefulWidget {
  String title;

  ScreenTitle({this.title});
  
  @override
  _ScreenTitleState createState() => new _ScreenTitleState();
}

class _ScreenTitleState extends State<ScreenTitle> {

  @override
  Widget build(BuildContext context) {
    return new Padding(padding: EdgeInsets.only(bottom: 5.0), 
      child: Container(
        height: 60.0,
        color: Color(0xFFFF6500),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
    );
  }
}