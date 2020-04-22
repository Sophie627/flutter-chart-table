import 'package:flutter/material.dart';
import 'package:youtimizer/Widgets/CustomButton.dart';
import 'package:youtimizer/Pages/Login.dart';
import 'package:youtimizer/Pages/Signup.dart';

class Welcome extends StatefulWidget{
  createState() => WelcomeState();
}

class WelcomeState extends State<Welcome>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            CustomButton(
                color: Colors.white,
                type: "login",
                name: "Log In",
                onTap: (name){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                }
            ),
            SizedBox(height: 10.0,),
            CustomButton(
                color: Colors.white,
                type: "login",
                name: "Sign Up",
                onTap: (name){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                }
            )
          ],
        ),
      )
    );
  }
}