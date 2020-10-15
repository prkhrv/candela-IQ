import 'package:flutter/material.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/dataClass/apiVariables.dart';
import 'package:learn_pro/pages/home/home.dart';
import 'package:learn_pro/pages/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    setState(() {
      SharedPreferences.getInstance().then((prefs) async {
        if (prefs.getString('token') != null &&
            prefs.getString('token') != '') {
          getSharedPreferences();
          _isLoggedIn = true;
          print("User is Logged in : $_isLoggedIn");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          print("User is Logged in : $_isLoggedIn");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OnBoarding()));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Container(
        height: height,
        width: width,
        color: textColor,
        child: Center(
          child: Text(
            'Welcome!',
            style: TextStyle(
              fontFamily: 'Signika Negative',
              fontSize: 60.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  //getData
  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userData['first_name'] = prefs.getString("first_name");
    userData['email'] = prefs.getString("email");
    userData['last_name'] = prefs.getString("last_name");
    userData['role'] = prefs.getString("role");
    userData['user_id'] = prefs.getString("user_id");
    setState(() {
      token = prefs.getString("token");
    });
  }
}
