import 'package:flutter/material.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/pages/login_signup/verify_email.dart';
import '../../dataClass/apiVariables.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
// import 'package:learn_pro/pages/login_signup/forgot_password.dart';
// import 'package:page_transition/page_transition.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Initially password is obscure
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  //ERROR MESSAGES
  String confirmPasswordErrorMsg;

  //VALIDATORS
  // (False == 'All Checks Passed')
  bool _passwordValidate = false;
  bool _firstNameValidate = false;
  bool _emailValidate = false;
  bool _lastNameValidate = false;
  bool _confirmPasswordValidate = false;

  //CONTROLLERS
  final TextEditingController _firstNameController =
      new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _confirmPasswordController =
      new TextEditingController();

  // Toggles the password show status
  void _viewPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Toggles the confirm password show status
  void _viewConfirmPassword() {
    setState(() {
      _obscureConfirmText = !_obscureConfirmText;
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
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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
                    'Sign up',
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
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      errorText: _firstNameValidate
                          ? 'First Name Can\'t Be Empty'
                          : null,
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
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      errorText: _lastNameValidate
                          ? 'Last Name Can\'t Be Empty'
                          : null,
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
                  SizedBox(height: 10.0),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Confirm password',
                      errorText: _confirmPasswordValidate
                          ? confirmPasswordErrorMsg
                          : null,
                      hintStyle: TextStyle(
                        fontFamily: 'Signika Negative',
                        color: Colors.grey[500],
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: _viewConfirmPassword,
                      ),
                      contentPadding:
                          const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    ),
                    obscureText: _obscureConfirmText,
                  ),
                  SizedBox(height: 40.0),
                  InkWell(
                    onTap: () {
                      startSignUp();
                      // Navigator.push(
                      //     context,
                      //     PageTransition(
                      //         type: PageTransitionType.rightToLeft,
                      //         child: ForgotPassword()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: textColor,
                      ),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontFamily: 'Signika Negative',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: nestedAppBar(),
    );
  }

  //validation
  void validate() {
    setState(() {
      // firstName
      _firstNameController.text.isEmpty
          ? _firstNameValidate = true
          : _firstNameValidate = false;

      // lastName
      _lastNameController.text.isEmpty
          ? _lastNameValidate = true
          : _lastNameValidate = false;

      // Password
      _passwordController.text.isEmpty
          ? _passwordValidate = true
          : _passwordValidate = false;

      //Email
      _emailController.text.isEmpty
          ? _emailValidate = true
          : _emailValidate = false;
    });

    // Confirm Password

    if (_confirmPasswordController.text.isNotEmpty) {
      if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordValidate = true;
        confirmPasswordErrorMsg = "Passwords DO NOT Match";
      } else {
        _confirmPasswordValidate = false;
      }
    } else {
      _confirmPasswordValidate = true;
      confirmPasswordErrorMsg = 'Confirm Password Can\'t Be Empty';
    }
  }

  //SIGNUP
  Future startSignUp() async {
    validate();
    if (_firstNameValidate == false &&
        _passwordValidate == false &&
        _emailValidate == false &&
        _lastNameValidate == false &&
        _confirmPasswordValidate == false) {
      _onLoading(true, '');

      var firstName = _firstNameController.text;
      var lastName = _lastNameController.text;
      var password = _passwordController.text;
      var email = _emailController.text;
      var confirmPassword = _confirmPasswordController.text;
      var url = Uri.parse('$baseUrl/register');

      var request = http.MultipartRequest('POST', url)
        ..fields['first_name'] = firstName
        ..fields['last_name'] = lastName
        ..fields['email'] = email
        ..fields['password'] = password
        ..fields['confirm_password'] = confirmPassword;

      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(respStr);
        print(responseData);
        _onLoading(false, responseData['message']);
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => VerifyEmail()));
      }
    }
  }

  //loading
  void _onLoading(bool choice, String msg) {
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
            backgroundColor: Colors.greenAccent,
            timeInSecForIos: 2,
            textColor: Colors.black,
            fontSize: 16.0);
  }
}
