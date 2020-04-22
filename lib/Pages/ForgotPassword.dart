import 'package:flutter/material.dart';
import 'package:youtimizer/Widgets/CustomButton.dart';
import 'package:youtimizer/Modal/Validation.dart';
import 'package:youtimizer/Pages/Login.dart';
import 'package:youtimizer/Widgets/Theme.dart';
import 'package:youtimizer/Modal/Authentication.dart';
import 'package:youtimizer/Modal/CustomError.dart';
import 'package:youtimizer/Widgets/Loader.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 16.0);

  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool autoValid = false;
  bool inPregress = false;

  TextEditingController email;
  FocusNode emailFocus;
  Authentication authentication;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoValid = false;
    inPregress = false;
    emailFocus = FocusNode();
    email = TextEditingController();
    authentication = Authentication();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email?.dispose();
    emailFocus?.dispose();
  }

  resetPassword() async {
    emailFocus.unfocus();
    setState(() => autoValid = true );

    if (formKey.currentState.validate()) {
      try {
        setState(()=>inPregress = true);
        var res = await authentication.forgotPassword(email: email.value.text);
        setState(()=>inPregress = false);
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(res),
          ),
        );
        formKey.currentState.reset();
        emailFocus.unfocus();
        email.clear();
        setState(()=>autoValid = false);

      } on CustomError catch (e) {
        setState(()=>inPregress = false);
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          backgroundColor: Colors.lightBlue,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              autovalidate: autoValid,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Forgotten Password?",
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w700,
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
                      focusNode: emailFocus,
                      controller: email,
                      onFieldSubmitted: (val) {
                        print("SUNMIT DATA");
                        resetPassword();
                      },
                      validator: (val) {
                        return CheckFieldValidation(
                          val: val,
                          fieldName: "Username or email",
                          fieldType: VALIDATION_TYPE.TEXT,
                        );
                      },
                      textAlign: TextAlign.center,
                      decoration: textFormTheme(hintText: "Username or email"),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomButton(
                    color: Colors.black,
                    name: "Reset Password",
                    onTap: (str) {
                      emailFocus.unfocus();
                      resetPassword();
                    },
                    type: "Reset Password",
                    textStyle: textStyle,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Back to login',
                            style: textStyle,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        inPregress ? Loader() : Container()
      ],
    );
  }
}
