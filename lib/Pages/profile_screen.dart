import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:youtimizer/Modal/Shared.dart';
import 'package:youtimizer/Modal/notificationItem.dart';
import 'package:youtimizer/Widgets/Loader.dart';
import 'package:youtimizer/Modal/Authentication.dart';
import 'package:youtimizer/Widgets/AppDrawer.dart';
import 'package:youtimizer/Widgets/ScreenTitle.dart';

final bgColor = const Color(0xff99cc33);
final Map<String, Item> _items = <String, Item>{};
Item _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['notification'] ?? message;
  final String title = data['title'];
  final String body = data['body'];
  final Item item = _items.putIfAbsent(title, () => Item(title: title, body: body))
    ..status = data['status'];
  return item;
}

class ProfileScreen extends StatefulWidget {
  int uid;

  ProfileScreen({this.uid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Widget _buildDialog(BuildContext context, Item item) {
    return AlertDialog(
      title: Text(item.title),
      content: Text(item.body),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        // FlatButton(
        //   child: const Text('SHOW'),
        //   onPressed: () {
        //     Navigator.pop(context, true);
        //   },
        // ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, _itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = _itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }
  
  Shared shared = Shared();
  Authentication authentication = Authentication();
  bool inProgress = true;
  String email = '';
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchUser(widget.uid);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          // TODO optional
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  fetchUser(uid) async {
    setState(() => inProgress = true);
    authentication.fetchUserData(uid).then((res) {
      print("User");
      print(res);

      setState(() {
        email = res['data']['user_email'];
      });
      print("Email ${email}");
    });
    setState(() => inProgress = false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Container(
          height: 35.0,
          child: Image.asset("images/logo.png"),
        ),
        centerTitle: false,
      ),
      backgroundColor: Colors.black,
      endDrawer: AppDrawer(uid: widget.uid),
      body: inProgress
          ? Loader()
          : email != null
              ? ProfileScreenView(
                  email: email,
                )
              : Container(
                  child: Center(
                    child: Text("No data found",style: TextStyle(color: Colors.white),),
                  )
                ),
    );
  }
}

class ProfileScreenView extends StatelessWidget {
  String email;

  ProfileScreenView({this.email});

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return ListView(
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      children: <Widget>[
        ScreenTitle(title: "User Profile"),
         SizedBox(
          height: 15.0,
        ),
        Container(
          padding: EdgeInsets.only(top: 15.0),
          child: Text('Email: ${email}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 15.0),
          child: Text('Push Notification',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 15.0),
          child: Text('Weekly Email Notification',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 15.0),
          child: Text('Monthly Email Report',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: 100.0,
          color: Colors.black,
          child: Image.asset("images/logo.png"),
        ),
      ],
    );
  }

}
