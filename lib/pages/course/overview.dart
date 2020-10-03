import 'package:flutter/material.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/pages/course/what_you_learn.dart';
import 'package:learn_pro/pages/course/what_you_will_get.dart';

class OverviewCoursePage extends StatefulWidget {
  @override
  _OverviewCoursePageState createState() => _OverviewCoursePageState();
}

class _OverviewCoursePageState extends State<OverviewCoursePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(right: 10.0, left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            style: TextStyle(
              fontFamily: 'Signika Negative',
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: headingColor,
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
            style: TextStyle(
              fontFamily: 'Signika Negative',
              fontSize: 17.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            width: width,
            height: 2.0,
            color: Colors.grey[300],
          ),
          SizedBox(height: 15.0),
          WhatYouWillGet(),
          SizedBox(height: 15.0),
          Container(
            width: width,
            height: 2.0,
            color: Colors.grey[300],
          ),
          SizedBox(height: 15.0),
          WhatYouLearn(),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
