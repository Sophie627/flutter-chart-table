import 'package:flutter/material.dart';

InputDecoration textFormTheme({String hintText}) {
  return InputDecoration(
    contentPadding:
    EdgeInsets.only(top: 8.0, bottom: 8.0, right: 10.0, left: 10.0),
    hintText: hintText,
    fillColor: Colors.white,
    filled: true,
    errorStyle: TextStyle(
      color: Colors.red,
      fontSize: 14.0,

    ),
    focusedBorder: InputBorder.none,
    border: InputBorder.none,
  );
}

