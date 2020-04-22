import 'package:flutter/material.dart';
import 'package:youtimizer/Modal/User.dart';
import 'package:youtimizer/Modal/Authentication.dart';
import 'package:youtimizer/Widgets/Theme.dart';
import 'package:youtimizer/Widgets/CustomButton.dart';
import 'package:youtimizer/Modal/Validation.dart';

final bgColor = const Color(0xff99cc33);

class BattingPage extends StatefulWidget {
//  GlobalKey<ScaffoldState> scaffoldKey;

//  BattingPage({this.scaffoldKey});

  createState() => BattingPageState();
}

class BattingPageState extends State<BattingPage> {
  bool autoValid = false;
  bool isProgress = false;

  FocusNode email, fname, lname, text;
  TextEditingController emailCtrl, fnameCtrl, lnameCtrl, textCtrl;

  TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 16.0);
  TextStyle textInputStyle = TextStyle(fontSize: 14.0);

  final formKey = GlobalKey<FormState>();

  Authentication authentication = Authentication();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoValid = false;

    email = FocusNode();
    lname = FocusNode();
    fname = FocusNode();
    text = FocusNode();

    emailCtrl = TextEditingController();
    fnameCtrl = TextEditingController();
    lnameCtrl = TextEditingController();
    textCtrl = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email?.dispose();
    fname?.dispose();
    lname?.dispose();
    text?.dispose();

    emailCtrl?.dispose();
    lnameCtrl?.dispose();
    fnameCtrl?.dispose();
    textCtrl?.dispose();

  }

  onSubmit(BuildContext context) async {
    unfocus();
    setState(() => autoValid = true);

    if (formKey.currentState.validate()) {
      BettingModal bettingPage = BettingModal(
        email: emailCtrl.value.text,
        text: textCtrl.value.text,
        fname: fnameCtrl.value.text,
        lname: lnameCtrl.value.text,
      );

      setState(() {
        isProgress = true;
      });
      authentication.sendBettingTip(bettingPage).then((res) {

        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Betting tip sent successfully."),
          ),
        );

        formKey.currentState.reset();
        this.emailCtrl.clear();
        this.textCtrl.clear();
        this.fnameCtrl.clear();
        this.lnameCtrl.clear();

        setState(() {
          autoValid = false;
          isProgress = false;
        });
        unfocus();

      }).catchError((e) {
        setState(() => isProgress = false);
        print("ERROR CALLED ${e}");

        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      });
    }
  }

  unfocus() {
    email.unfocus();
    text.unfocus();
    fname.unfocus();
    lname.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: formKey,
        autovalidate: autoValid,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            Text(
              "Send Betting Tip".toUpperCase(),
              style: TextStyle(fontSize: 23.0, color: Colors.white,fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              style: textInputStyle,
              focusNode: fname,
              controller: fnameCtrl,
              onFieldSubmitted: (val) {
                fname.unfocus();
                FocusScope.of(context).requestFocus(lname);
              },
              textInputAction: TextInputAction.next,
              validator: (val) {
                return CheckFieldValidation(
                    fieldName: "First name",
                    fieldType: VALIDATION_TYPE.TEXT,
                    val: val);
              },
              decoration: textFormTheme(hintText: "First Name"),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              style: textInputStyle,
              focusNode: lname,
              controller: lnameCtrl,
              onFieldSubmitted: (val) {
                lname.unfocus();
                FocusScope.of(context).requestFocus(email);
              },
              validator: (val) {
                return CheckFieldValidation(
                    fieldName: "Last name",
                    fieldType: VALIDATION_TYPE.TEXT,
                    val: val);
              },
              textInputAction: TextInputAction.next,
              decoration: textFormTheme(hintText: "Last Name"),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              style: textInputStyle,
              focusNode: email,
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (val) {
                email.unfocus();
                FocusScope.of(context).requestFocus(text);
              },
              validator: (val) {
                return CheckFieldValidation(
                    fieldName: "Email",
                    fieldType: VALIDATION_TYPE.EMAIL,
                    val: val);
              },
              textInputAction: TextInputAction.next,
              decoration: textFormTheme(hintText: "Email Address"),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              style: textInputStyle,
              focusNode: text,
              controller: textCtrl,
              onFieldSubmitted: (val) {
                text.unfocus();
                onSubmit(context);
              },
              validator: (val) {
                return CheckFieldValidation(
                    fieldName: "Text",
                    fieldType: VALIDATION_TYPE.TEXT,
                    val: val);
              },
              textInputAction: TextInputAction.done,
              decoration: textFormTheme(hintText: "Text"),
            ),
            SizedBox(
              height: 10.0,
            ),
            CustomButton(
              color: bgColor,
              name: isProgress ? "Sending " : "SEND",
              onTap: isProgress
                  ? null
                  : (str) {
                      onSubmit(context);
                    },
              type: "send",
              textStyle: textStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 35.0,
              child: Image.asset("images/bettinglogo.png"),
            )
          ],
        ),
      ),
    );
  }
}
