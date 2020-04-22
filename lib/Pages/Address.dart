import 'package:flutter/material.dart';
import 'package:youtimizer/Modal/Authentication.dart';
import 'package:flutter_html/flutter_html.dart';



class Address extends StatelessWidget{
  String address;
  Address({this.address});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(
          "ADDRESS".toUpperCase(),
          style: TextStyle(
              fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 10.0,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            alignment: Alignment.center,
            child: Center(
              child:Html(
                customTextStyle: (node, textStyle) {
                  print(node);
                  print(textStyle);
                },
                data:address,
                defaultTextStyle:
                TextStyle(color: Colors.white, fontSize: 14.0),
                linkStyle: TextStyle(
                  color: Colors.white,
                ),
              )
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
//
//class Address extends StatefulWidget {
//  createState() => AddressState();
//}
//
//class AddressState extends State<Address> {
//  Authentication authentication = Authentication();
//  bool isLoading = false;
//  String address;
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    fetchAddress();
//  }
//
//  fetchAddress() {
//    authentication.fetchAddressData().then((res) {
//      print(res);
//      setState(()=>isLoading = true);
//      setState((){
//        address = res;
//      });
//
//    }).catchError((e) {
//
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Column(
//      children: <Widget>[
//        SizedBox(
//          height: 10.0,
//        ),
//        Text(
//          "ADDRESS".toUpperCase(),
//          style: TextStyle(
//              fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.w700),
//        ),
//        SizedBox(
//          height: 10.0,
//        ),
//        Align(
//          alignment: Alignment.center,
//          child: Container(
//            width: MediaQuery.of(context).size.width / 2,
//            alignment: Alignment.center,
//            child: Center(
//              child: isLoading ? Html(
//                customTextStyle: (node, textStyle) {
//                  print(node);
//                  print(textStyle);
//                },
//                data:
//                '<center>Address<br>Youtimizer<br>Flat 3, 75 Wigmore St,<br>London W1U 1QB<br>United Kingdom</center>',
//                defaultTextStyle:
//                TextStyle(color: Colors.white, fontSize: 14.0),
//                linkStyle: TextStyle(
//                  color: Colors.white,
//                ),
//              ) : Container(),
//            ),
//          ),
//        ),
//        SizedBox(
//          height: 10.0,
//        ),
//      ],
//    );
//  }
//}
