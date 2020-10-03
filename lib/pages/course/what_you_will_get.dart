import 'package:flutter/material.dart';
import 'package:learn_pro/appTheme/appTheme.dart';

class WhatYouWillGet extends StatefulWidget {
  @override
  _WhatYouWillGetState createState() => _WhatYouWillGetState();
}

class _WhatYouWillGetState extends State<WhatYouWillGet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'What you will get',
          style: TextStyle(
            fontFamily: 'Signika Negative',
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: headingColor,
          ),
        ),
        
        ListTile(
          leading: Icon(
            Icons.menu,
            color: Colors.black,
            size: 25.0,
          ),
          title: Text(
            '15 Videos Lessons',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Signika Negative',
              fontSize: 18.0,
            ),
          ),
        ),

        ListTile(
          leading: Icon(
            Icons.star_border,
            color: Colors.black,
            size: 25.0,
          ),
          title: Text(
            'Exclusive Learning Materials',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Signika Negative',
              fontSize: 18.0,
            ),
          ),
        ),

        ListTile(
          leading: Icon(
            Icons.check,
            color: Colors.black,
            size: 25.0,
          ),
          title: Text(
            '100% Guaranteed',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Signika Negative',
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    );
  }
}
