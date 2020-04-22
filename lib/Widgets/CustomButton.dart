import 'package:flutter/material.dart';

typedef VoidCallback(String type);

class CustomButton extends StatelessWidget {
  String name;
  String type;
  VoidCallback onTap;
  Color color;
  TextStyle textStyle;

  CustomButton(
      {@required this.name, this.onTap, this.type, @required this.color,this.textStyle})
      : assert(name != null, onTap != null);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Align(
      alignment: Alignment.center,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        disabledColor: Colors.grey,
        onPressed: (onTap != null) ? (){onTap(type);} : null,
        child: Container(
          height: 35.0,
          alignment: Alignment.center,
          child: Text(name,style: textStyle,),
        ),
      ),
    );
  }
}
