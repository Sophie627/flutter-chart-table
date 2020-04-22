import 'package:flutter/material.dart';
import 'package:youtimizer/Modal/Shared.dart';
import 'package:youtimizer/Pages/Login.dart';
import 'package:youtimizer/Pages/Home.dart';

class Root extends StatefulWidget{
  createState() => RootState();
}

class RootState extends State<Root>{

  Shared shared = Shared();

  Widget defaultWidget = Center(
    child: Text("Loading...."),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }


  checkLogin()async{
    int uid = await shared.getSave();
    setState(() {
      defaultWidget = (uid != null) ? Home(uid: uid,) : Login();
    });
    print("UID $uid");
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body: defaultWidget,
    );
  }
}