import 'package:flutter/material.dart';
import 'package:youtimizer/Widgets/CustomButton.dart';
import 'package:youtimizer/Pages/Home.dart';
import 'package:youtimizer/Widgets/Loader.dart';
import 'package:youtimizer/Modal/Validation.dart';
import 'package:youtimizer/Modal/Authentication.dart';
import 'package:youtimizer/Widgets/Theme.dart';
import 'package:youtimizer/Modal/User.dart';
import 'package:youtimizer/Modal/CustomError.dart';
import 'package:flutter_html/flutter_html.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 16.0);
  final formKey = GlobalKey<FormState>();
  bool autoValid = false;
  bool isProgress = false;

  bool regSuccess = false;

  String regMsg =
      "Thank you for registering at youtimizer.com<br>\r\nYour registration has been sent to Youtimizer.com and <br>\r\nthey will contact you as soon as possible.<br>\r\nThank you again for your interest!<br>\r\nYoutimizer.com";

  Authentication authenticaion;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FocusNode first, last, username, email, pass, cpass;

  // TextEditController
  TextEditingController firstCtrl,
      lastCtrl,
      usernameCtrl,
      emailCtrl,
      passCtrl,
      cpassCtrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoValid = false;
    isProgress = false;
    regSuccess = false;

    authenticaion = Authentication();
    firstCtrl = TextEditingController();
    lastCtrl = TextEditingController();
    usernameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    passCtrl = TextEditingController();
    cpassCtrl = TextEditingController();

    first = FocusNode();
    last = FocusNode();
    username = FocusNode();
    email = FocusNode();
    pass = FocusNode();
    cpass = FocusNode();
  }

  signup(BuildContext context) async {
    setState(() => autoValid = true);
    unfocus();
    if (formKey.currentState.validate()) {
      setState(() => isProgress = true);

      Register register = Register(
        fname: firstCtrl.value.text,
        lname: lastCtrl.value.text,
        username: usernameCtrl.value.text,
        password: passCtrl.value.text,
        cpassword: cpassCtrl.value.text,
        email: emailCtrl.value.text,
      );

      var res = await authenticaion.singup(register).then((res) {
        print("SIGN UP RES $res");
        setState(() {
          isProgress = false;
          regSuccess = true;
          autoValid = false;
          regMsg = res;
        });

        formKey.currentState.reset();

        this.firstCtrl.clear();
        this.lastCtrl.clear();
        this.usernameCtrl.clear();
        this.emailCtrl.clear();
        this.passCtrl.clear();
        this.cpassCtrl.clear();
        setState(() => autoValid = false);
      }).catchError((e) {
        setState(() => isProgress = false);
        print("ERROR CALLED ${e}");

        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      });
    }
  }

  unfocus() {
    this.username?.unfocus();
    this.first?.unfocus();
    this.last?.unfocus();
    this.email?.unfocus();
    this.pass?.unfocus();
    this.cpass?.unfocus();
  }

  reset() {
    unfocus();
    this.firstCtrl.clear();
    this.lastCtrl.clear();
    this.usernameCtrl.clear();
    this.emailCtrl.clear();
    this.passCtrl.clear();
    this.cpassCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Stack(
      children: <Widget>[
        Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.lightBlue,
            appBar: AppBar(
              backgroundColor: Colors.lightBlue,
              elevation: 0.0,
            ),
            body: Form(
              key: formKey,
              autovalidate: autoValid,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(
                      height: 5.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    regSuccess ? success() : Container(),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Please register by filling out the fields velow. Your application will be send to our administrator and when approved, we will sent you as mail confirmtation.",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: first,
                        controller: firstCtrl,
                        textAlign: TextAlign.center,
                        decoration: textFormTheme(hintText: "First"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (text) {
                          first.unfocus();
                          FocusScope.of(context).requestFocus(last);
                        },
                        validator: (val) {
                          return CheckFieldValidation(
                              fieldName: "First",
                              fieldType: VALIDATION_TYPE.TEXT,
                              val: val);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: last,
                        controller: lastCtrl,
                        textAlign: TextAlign.center,
                        decoration: textFormTheme(hintText: "Last"),
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          return CheckFieldValidation(
                              fieldName: "Last",
                              fieldType: VALIDATION_TYPE.TEXT,
                              val: val);
                        },
                        onFieldSubmitted: (text) {
                          last.unfocus();
                          FocusScope.of(context).requestFocus(username);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: username,
                        controller: usernameCtrl,
                        textAlign: TextAlign.center,
                        decoration: textFormTheme(hintText: "Username"),
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          return CheckFieldValidation(
                              fieldName: "Username",
                              fieldType: VALIDATION_TYPE.TEXT,
                              val: val);
                        },
                        onFieldSubmitted: (text) {
                          username.unfocus();
                          FocusScope.of(context).requestFocus(email);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: email,
                        controller: emailCtrl,
                        textAlign: TextAlign.center,
                        decoration: textFormTheme(hintText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          return CheckFieldValidation(
                              fieldName: "Email",
                              fieldType: VALIDATION_TYPE.EMAIL,
                              val: val);
                        },
                        onFieldSubmitted: (text) {
                          email.unfocus();
                          FocusScope.of(context).requestFocus(pass);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: pass,
                        controller: passCtrl,
                        textAlign: TextAlign.center,
                        decoration: textFormTheme(hintText: "Password"),
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        validator: (val) {
                          return CheckFieldValidation(
                              fieldName: "Password",
                              fieldType: VALIDATION_TYPE.PASSWORD,
                              val: val);
                        },
                        onFieldSubmitted: (text) {
                          pass.unfocus();
                          FocusScope.of(context).requestFocus(cpass);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: cpass,
                        controller: cpassCtrl,
                        textAlign: TextAlign.center,
                        decoration: textFormTheme(hintText: "Confirm Password"),
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        validator: (val) {
                          return CheckFieldValidation(
                              fieldName: "Confirm password",
                              fieldType: VALIDATION_TYPE.CONFIRM_PASSWORD,
                              val: val,
                              password: passCtrl.value.text);
                        },
                        onFieldSubmitted: (text) {
                          cpass.unfocus();
                          signup(context);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomButton(
                      color: Colors.black,
                      name: "Signup",
                      onTap: (str) {
                        signup(context);
                      },
                      type: "Signup",
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Back to Login',
                              style: textStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            )),
        isProgress ? Loader() : Container()
      ],
    );
  }

  Widget success() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Align(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          alignment: Alignment.center,
          color: Colors.lightGreen,
          child: Html(
            data: regMsg,
            defaultTextStyle: TextStyle(color: Colors.white, fontSize: 14.0),
            linkStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    reset();
    // TODO: implement dispose
    super.dispose();
    firstCtrl.dispose();
    lastCtrl.dispose();
    usernameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    cpassCtrl.dispose();
  }
}
