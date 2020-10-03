import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/pages/login_signup/forgot_password.dart';
import 'package:learn_pro/pages/login_signup/signup.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Initially password is obscure
  bool _obscureText = true;
  DateTime currentBackPressTime;

  bool _passwordValidate = false;
  bool _usernameValidate = false;

  final TextEditingController _usernameController = new TextEditingController();

  final TextEditingController _passwordController = new TextEditingController();

  // Toggles the password show status
  void _viewPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    nestedAppBar() {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 180,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/appbar_bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontFamily: 'Signika Negative',
                      fontWeight: FontWeight.w700,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
            ),
          ];
        },
        body: ListView(
          children: <Widget>[
            SizedBox(height: 30.0),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 30.0, left: 30.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      errorText:
                          _usernameValidate ? 'Username Can\'t Be Empty' : null,
                      hintStyle: TextStyle(
                        fontFamily: 'Signika Negative',
                        color: Colors.grey[500],
                      ),
                      contentPadding:
                          const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      errorText:
                          _passwordValidate ? 'Password Can\'t Be Empty' : null,
                      hintStyle: TextStyle(
                        fontFamily: 'Signika Negative',
                        color: Colors.grey[500],
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: _viewPassword,
                      ),
                      contentPadding:
                          const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    ),
                    obscureText: _obscureText,
                  ),
                  SizedBox(height: 40.0),
                  InkWell(
                    onTap: () {
                      startLogin();
                      // Navigator.push(
                      //     context,
                      //     PageTransition(
                      //         type: PageTransitionType.rightToLeft,
                      //         child: SignUp()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: textColor,
                      ),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontFamily: 'Signika Negative',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: SignUp()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontFamily: 'Signika Negative',
                          fontSize: 17.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: ForgotPassword()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                          fontFamily: 'Signika Negative',
                          fontSize: 17.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: WillPopScope(
        child: nestedAppBar(),
        onWillPop: onWillPop,
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: Theme.of(context).appBarTheme.color,
      );
      return Future.value(false);
    }
    exit(0);
  }

  //validation
  validate() {
    setState(() {
      _usernameController.text.isEmpty
          ? _usernameValidate = true
          : _usernameValidate = false;
      _passwordController.text.isEmpty
          ? _passwordValidate = true
          : _passwordValidate = false;
    });
  }

  //loading
  void _onLoading(bool choice) {
    choice
        ? showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new CircularProgressIndicator(
                  backgroundColor: Color(0xff00d2ff),
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
            // ignore: unnecessary_statements
          )
        : null;
  }

  //LOGIN
  Future startLogin() async {
    validate();
    if (_usernameValidate == false && _passwordValidate == false) {
      var username = _usernameController.text;
      var password = _passwordController.text;

      print('$username and $password');

      _onLoading(true);
    }
  }
}
