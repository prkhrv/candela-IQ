import 'package:flutter/material.dart';
import 'package:learn_pro/appTheme/appTheme.dart';

class MyCourse extends StatefulWidget {
  @override
  _MyCourseState createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    getLessonTile(String title, String img, String videoLength, double width) {
    return Container(
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
                image: AssetImage(img),
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
        body: ListView(
          children: <Widget>[
            getLessonTile('Alice Water', 'assets/new_course/new_course_1.png', '20/20 Videos', width),
            getLessonTile('Gordon Ramsey', 'assets/new_course/new_course_2.png', '3/12 Videos', width),
            getLessonTile('Lisa Ling', 'assets/new_course/new_course_3.png', '0/15 Videos', width),
            getLessonTile('Wolfgang Puck', 'assets/new_course/new_course_4.png', '15/30 Videos', width),
          ],
        ),
      );
    }

    return Scaffold(
      body: nestedAppBar(),
    );
  }
}
