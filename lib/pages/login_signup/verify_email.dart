import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/dataClass/apiVariables.dart';
import 'package:http/http.dart' as http;
import 'package:learn_pro/pages/login_signup/login.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  //Error Message
  String _codeErrorMsg;
  //VALIDATORS
  // (False == 'All Checks Passed')
  bool _isEmailInvaild = false;
  bool _isCodeInvalid = false;

  //CONTROLLERS
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _verificationCodeController =
      new TextEditingController();

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
                    'Verify Email',
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
                  Text(
                    'Enter your registered email and Verification to Proceed',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'Signika Negative',
                      color: Colors.grey[500],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter registered email',
                      errorText:
                          _isEmailInvaild ? 'Email Can\'t Be Empty' : null,
                      hintStyle: TextStyle(
                        fontFamily: 'Signika Negative',
                        color: Colors.grey[500],
                      ),
                      contentPadding:
                          const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _verificationCodeController,
                    decoration: InputDecoration(
                      hintText: 'Verification Code',
                      errorText: _isCodeInvalid ? _codeErrorMsg : null,
                      hintStyle: TextStyle(
                        fontFamily: 'Signika Negative',
                        color: Colors.grey[500],
                      ),
                      contentPadding:
                          const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 40.0),
                  InkWell(
                    onTap: () {
                      verifyEmail();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: textColor,
                      ),
                      child: Text(
                        'Verify Email',
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
      //Email
      _emailController.text.isEmpty
          ? _isEmailInvaild = true
          : _isEmailInvaild = false;
    });

    //Code

    if (_verificationCodeController.text.isEmpty) {
      _isCodeInvalid = true;
      _codeErrorMsg = 'Verification Code Can\'t Be Empty';
    } else if (_verificationCodeController.text.length != 6) {
      _isCodeInvalid = true;
      _codeErrorMsg = 'Enter the Correct Code';
    } else {
      _isCodeInvalid = false;
    }
  }

  //VERIFY_EMAIL
  Future verifyEmail() async {
    validate();
    if (_isEmailInvaild == false && _isCodeInvalid == false) {
      _onLoading(true, '', Colors.transparent);

      var email = _emailController.text;
      var code = _verificationCodeController.text;
      var url = Uri.parse('$baseUrl/verify_email');

      var request = http.MultipartRequest('POST', url)
        ..fields['email'] = email
        ..fields['verification_code'] = code;

      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(respStr);
        print(responseData);
        _onLoading(false, responseData['message'], Colors.greenAccent);
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else if (response.statusCode == 400) {
        Navigator.of(context, rootNavigator: true).pop();
        _onLoading(false, 'The verification code is wrong.', Colors.redAccent);
      }
    }
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
}
