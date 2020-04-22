import 'package:flutter/material.dart';
import 'package:youtimizer/Widgets/CustomButton.dart';
import 'package:youtimizer/Pages/Home.dart';
import 'package:youtimizer/Pages/Signup.dart';
import 'package:youtimizer/Pages/ForgotPassword.dart';
import 'package:youtimizer/Modal/Validation.dart';
import 'package:youtimizer/Widgets/Loader.dart';
import 'package:youtimizer/Modal/Authentication.dart';
import 'package:youtimizer/Widgets/Theme.dart';
import 'package:youtimizer/Modal/CustomError.dart';
import 'package:youtimizer/Modal/User.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool rememberMe = false;
  bool _autoValid = false;
  bool isProgress = false;

  Authentication authenticaion;
  TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 16.0);

  FocusNode email;
  FocusNode password;

  // TextEditController
  TextEditingController emailCtrl;
  TextEditingController passwordCtrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rememberMe = false;
    _autoValid = false;
    isProgress = false;
    authenticaion = Authentication();
    email = FocusNode();
    password = FocusNode();

    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _autoValid = false;
    super.dispose();
    email.dispose();
    password.dispose();

    emailCtrl.dispose();
    passwordCtrl.dispose();
  }

  onRemember() {
    setState(() {
      rememberMe = !rememberMe;
    });
  }

  didChangeDependencies() {}

  login(BuildContext context) async {
    email.unfocus();
    password.unfocus();
    setState(() => _autoValid = true);

    if (formKey.currentState.validate()) {
      setState(() => isProgress = true);

      UserLogin userLogin = UserLogin(
        password: passwordCtrl.value.text,
        username: emailCtrl.value.text,
      );
      authenticaion.login(userLogin).then((res) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Home(
                  uid: int.parse(res.toString()),
                ),
          ),
          ModalRoute.withName('/root'),
        );
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print("height ${height}");
    Orientation orientation = MediaQuery.of(context).orientation;
    print("orientation ${orientation}");
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.lightBlue,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              autovalidate: _autoValid,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: orientation == Orientation.portrait
                        ? height / 4.0
                        : (height > 720 ? height / 4.0 : 40.0),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Login",
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
                      autofocus: true,
                      controller: emailCtrl,
                      focusNode: email,
                      textAlign: TextAlign.center,
                      decoration: textFormTheme(hintText: "Email or username"),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        email.unfocus();
                        FocusScope.of(context).requestFocus(password);
                      },
                      validator: (val) {
                        return CheckFieldValidation(
                            fieldName: "Email",
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
                      focusNode: password,
                      controller: passwordCtrl,
                      textAlign: TextAlign.center,
                      decoration: textFormTheme(hintText: "Password"),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (val) {
                        password.unfocus();
                        login(context);
                      },
                      validator: (val) {
                        return CheckFieldValidation(
                            fieldName: "Password",
                            fieldType: VALIDATION_TYPE.LOGIN_PASSWORD,
                            val: val);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: onRemember,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 17.0,
                              width: 17.0,
                              child: Container(
                                color: Colors.white,
                                child: Checkbox(
                                  value: rememberMe,
                                  activeColor: Colors.white,
                                  checkColor: Colors.lightBlue,
                                  onChanged: (bool flag) {
                                    onRemember();
                                  },
                                  tristate: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text("Remember me", style: textStyle)
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomButton(
                    color: Colors.black,
                    name: "Login",
                    onTap: isProgress
                        ? null
                        : (str) {
                            login(context);
                          },
                    type: "login",
                    textStyle: textStyle,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          },
                          child: Text(
                            'Register',
                            style: textStyle,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          " | ",
                          style: textStyle,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text(
                            'Lost your password ?',
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
          isProgress ? Loader() : Container()
        ],
      ),
    );
  }
}
