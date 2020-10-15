import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/dataClass/apiVariables.dart';
import 'package:learn_pro/pages/home/home.dart';
import 'package:learn_pro/pages/login_signup/forgot_password.dart';
import 'package:learn_pro/pages/login_signup/signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Initially password is obscure
  bool _obscureText = true;
  DateTime currentBackPressTime;

  // (false == 'All Checks Passed')
  bool _passwordValidate = false;
  bool _emailValidate = false;

  final TextEditingController _emailController = new TextEditingController();

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
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      errorText:
                          _emailValidate ? 'Email Can\'t Be Empty' : null,
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
  void validate() {
    setState(() {
      _emailController.text.isEmpty
          ? _emailValidate = true
          : _emailValidate = false;
      _passwordController.text.isEmpty
          ? _passwordValidate = true
          : _passwordValidate = false;
    });
  }

  //loading
  void _onLoading(bool choice, String msg, Color clr) {
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
        : Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: clr,
            timeInSecForIos: 2,
            textColor: Colors.black,
            fontSize: 16.0);
  }

  //LOGIN
  Future startLogin() async {
    validate();
    if (_emailValidate == false && _passwordValidate == false) {
      _onLoading(true, '', Colors.transparent);
      var email = _emailController.text;
      var password = _passwordController.text;
      var url = Uri.parse('$baseUrl/login');

      var request = http.MultipartRequest('POST', url)
        ..fields['email'] = email
        ..fields['password'] = password;
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      final Map<String, dynamic> responseData = json.decode(respStr);

      if (response.statusCode == 200) {
        setState(() {
          token = responseData['token'];
        });
        _setData(responseData['user_data'], responseData['token']);
        Navigator.of(context, rootNavigator: true).pop();

        //Login Successfull
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else if (response.statusCode == 400) {
        Navigator.of(context, rootNavigator: true).pop();
        _onLoading(false, responseData['message'], Colors.redAccent);
      }
    }
  }

  //SET DATA
  void _setData(data, token) async {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('user_id', data['user_id']);
      prefs.setString('first_name', data['first_name']);
      prefs.setString('last_name', data['last_name']);
      prefs.setString('email', data['email']);
      prefs.setString('role', data['role']);
      prefs.setString('token', token);
    });
  }
}
