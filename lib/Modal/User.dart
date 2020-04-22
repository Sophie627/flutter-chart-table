import 'package:flutter/material.dart';

class Response {
  String code;
  String msg;
  ResponseData responseData;

  Response({this.code, this.msg, this.responseData});

  factory Response.fromJSON(Map<String, dynamic> parsedJson) {
    print("###");
    print(parsedJson);
    return Response(
      code: parsedJson['code'],
      msg: parsedJson['msg'] != null ? parsedJson['msg'] : '',
      responseData: (parsedJson['data'] != null) ? ResponseData.fromJSON(parsedJson['data']) : ResponseData(),
    );
  }
}

class ResponseData {
  Map data;

  ResponseData({this.data});

  factory ResponseData.fromJSON(Map<String, dynamic> parsedJson) {
    print("@@@@@");
    print(parsedJson);
    return ResponseData(
      data: parsedJson,
    );
  }
}




/**
 * Register modal
 * */
class Register {
  String fname;
  String lname;
  String username;
  String password;
  String cpassword;
  String email;

  Register({
    @required this.fname,
    @required this.lname,
    @required this.username,
    @required this.password,
    @required this.cpassword,
    @required this.email,
  });
}

/*
* Login modal
* */
class UserLogin {
  String username;
  String password;

  UserLogin({
    @required this.password,
    @required this.username,
  });
}



class BettingModal{
  String fname;
  String lname;
  String email;
  String text;

  BettingModal({this.lname,this.text,this.fname,this.email});
}