import 'package:flutter/material.dart';
import 'package:learn_pro/appTheme/appTheme.dart';

class WhatYouLearn extends StatefulWidget {
  @override
  _WhatYouLearnState createState() => _WhatYouLearnState();
}

class _WhatYouLearnState extends State<WhatYouLearn> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'What you will learn',
          style: TextStyle(
            fontFamily: 'Signika Negative',
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: headingColor,
          ),
        ),
        SizedBox(height: 15.0),
        Container(
          width: width,
          height: 210.0,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              getImageContainer('assets/new_course/new_course_1.png', 'Full Language'),
              SizedBox(width: 10.0),
              getImageContainer('assets/new_course/new_course_2.png', 'Practicals'),
              SizedBox(width: 10.0),
              getImageContainer('assets/new_course/new_course_3.png', 'OOP Concept'),
            ],
          ),
        ),
      ],
    );
  }

  Container getImageContainer(String imgPath, String title) {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Container(
              width: 200,
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.black.withOpacity(0.35),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 10.0,
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Signika Negative',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
