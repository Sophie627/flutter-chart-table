import 'package:flutter/material.dart';


class Loader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.black45,
      child: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white,),
      ),
    );
  }
}