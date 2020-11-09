import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/dataClass/apiVariables.dart';
import 'package:http/http.dart' as http;
import 'package:learn_pro/pages/login_signup/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCourse extends StatefulWidget {
  @override
  _MyCourseState createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {
  var myCourseList = new List<MycourseData>();
  int myCourseCount;

  @override
  void initState() {
    getmyCourseList();
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    getLessonTile(String title, String img, String videoLength, double width) {
      return InkWell(
        onTap: () {
          print("clicked");
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 1.5,
                spreadRadius: 1.5,
                color: Colors.grey[200],
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(img),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              Container(
                width: width - 140.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 4.0, right: 8.0, left: 8.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Signika Negative',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, right: 8.0, left: 8.0, bottom: 8.0),
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        style: TextStyle(
                          fontSize: 14.0,
                          height: 1.6,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 0.0, right: 8.0, left: 8.0, bottom: 8.0),
                      child: Text(
                        videoLength,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Signika Negative',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.7,
                          color: headingColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

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
                    'My Course',
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
        body: (myCourseCount == 0)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.heartBroken,
                      color: Colors.grey,
                      size: 60.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'No Course Purchased',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                        fontFamily: 'Signika Negative',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: myCourseList.length,
                itemBuilder: (context, index) {
                  final item = myCourseList[index];
                  return getLessonTile(
                      item.title, item.thumbnail, '10/10 Videos', width);
                },
                // children: <Widget>[
                //   getLessonTile('Alice Water', 'assets/new_course/new_course_1.png',
                //       '20/20 Videos', width),
                //   getLessonTile('Gordon Ramsey', 'assets/new_course/new_course_2.png',
                //       '3/12 Videos', width),
                //   getLessonTile('Lisa Ling', 'assets/new_course/new_course_3.png',
                //       '0/15 Videos', width),
                //   getLessonTile('Wolfgang Puck', 'assets/new_course/new_course_4.png',
                //       '15/30 Videos', width),
                // ],
              ),
      );
    }

    return Scaffold(
      body: nestedAppBar(),
    );
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

  //Logout
  _logout() async {
    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('user_id', null);
        prefs.setString('first_name', null);
        prefs.setString('last_name', null);
        prefs.setString('email', null);
        prefs.setString('role', null);
        prefs.setString('token', null);
      });
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  // Fetch
  getmyCourseList() async {
    var url = Uri.parse('$baseUrl/my_courses?auth_token=$token');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        Iterable list = json.decode(response.body);
        myCourseList =
            list.map((model) => MycourseData.fromJson(model)).toList();
        myCourseCount = myCourseList.length;
      });
    } else if (response.statusCode == 401) {
      _onLoading(
          false, "Authorisation Failed or Token Expired", Colors.redAccent);
      _logout();
    }
  }
}

class MycourseData {
  final String id;
  final String title;
  final String shortDescription;
  final String thumbnail;
  final String price;
  final int courseRating;
  final int noOfRating;
  final String description;

  MycourseData(
      {this.id,
      this.title,
      this.shortDescription,
      this.thumbnail,
      this.price,
      this.courseRating,
      this.noOfRating,
      this.description});

  factory MycourseData.fromJson(Map<String, dynamic> json) {
    return MycourseData(
        id: json['id'],
        title: json['title'],
        shortDescription: json['short_description'],
        thumbnail: json['thumbnail'],
        price: json['price'],
        courseRating: json['rating'],
        noOfRating: json['number_of_ratings'],
        description: json['description']);
  }
}
