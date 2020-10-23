import 'package:flutter/material.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/pages/course/what_you_learn.dart';
import 'package:learn_pro/pages/course/what_you_will_get.dart';
import 'package:html/parser.dart' show parse;

class OverviewCoursePage extends StatefulWidget {
  final String shortDescription;
  final String courseDescription;

  OverviewCoursePage({Key key, this.shortDescription, this.courseDescription})
      : super(key: key);
  @override
  _OverviewCoursePageState createState() => _OverviewCoursePageState();
}

class _OverviewCoursePageState extends State<OverviewCoursePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var description = parse(widget.courseDescription);
    var parsedString = parse(description.body.text).documentElement.text;

    return Container(
      padding: EdgeInsets.only(right: 10.0, left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${widget.shortDescription}',
            style: TextStyle(
              fontFamily: 'Signika Negative',
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: headingColor,
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            '$parsedString',
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
