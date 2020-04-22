import 'package:flutter/material.dart';
import 'package:youtimizer/Pages/Login.dart';
import 'package:youtimizer/Pages/Home.dart';
import 'package:youtimizer/Pages/gain_screen.dart';
import 'package:youtimizer/Pages/profile_screen.dart';
import 'package:youtimizer/Modal/Shared.dart';

class AppDrawer extends StatefulWidget {
  int uid;

  AppDrawer({this.uid});
  @override
  _AppDrawerState createState() => new _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Shared shared = Shared();
  

  logout() async {
    await shared.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        ModalRoute.withName("/"));
  }

  @override
  Widget build(BuildContext context) {
    
    return new Drawer(
      child: Container(
        color: Colors.black.withOpacity(0.9),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 130.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFFFF6500),
                ),
                child: Text(
                    'YouTimizer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,  
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),
            ),
            ListTile(
              // leading: Icon(Icons.brush),
              title: Text('Club Performance',
               style: TextStyle(
                 color: Colors.white
               )
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home(uid: widget.uid)),
                  ModalRoute.withName("/home"));
              },
            ),
            ListTile(
              // leading: Icon(Icons.brush),
              title: Text('Gain and Deposit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => GainScreen(uid: widget.uid)),
                  ModalRoute.withName("/gain"));
              },
            ),
            ListTile(
              // leading: Icon(Icons.brush),
              title: Text('User Profile',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen(uid: widget.uid)),
                  ModalRoute.withName("/profile"));
              },
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new,
                color: Colors.white,
              ),
              title: Text('Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                logout();
                Navigator.pop(context);
                // _scaffoldKey.currentState.openEndDrawer();
              },
            ),
          ],
        ),
      ),
    );
  }
}