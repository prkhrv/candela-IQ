import 'package:flutter/material.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/dataClass/passDataToCoursePage.dart';
import 'package:learn_pro/pages/course/lessons.dart';
import 'package:learn_pro/pages/course/overview.dart';
import 'package:learn_pro/pages/payment/select_plan.dart';
import 'package:learn_pro/pages/video_play/video_play.dart';

class CoursePage extends StatefulWidget {
  final PassDataToCoursePage courseData;
  final int lang;

  CoursePage({Key key, @required this.courseData, this.lang}) : super(key: key);
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  bool wishlist = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  onAddedInWishlist() {
    setState(() {
      if (wishlist) {
        wishlist = false;
      } else {
        wishlist = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PassDataToCoursePage courseData = widget.courseData;
    double width = MediaQuery.of(context).size.width;

    nestedAppBar(_scaffoldKey) {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 470,
              pinned: true,
              forceElevated: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: iconColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                InkWell(
                  onTap: () {
                    onAddedInWishlist();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        (wishlist) ? Icons.check : Icons.add,
                        color: iconColor,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        (wishlist) ? 'Added to Wishlist' : 'Add to Wishlist',
                        style: TextStyle(
                            color: textColor,
                            fontFamily: 'Signika Negative',
                            fontSize: 16.0),
                      ),
                      SizedBox(width: 10.0),
                    ],
                  ),
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      child: Container(
                        width: width,
                        height: 440.0,
                        padding: EdgeInsets.all(20.0),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(courseData.courseImage),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        width: width,
                        height: 440.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      child: Container(
                        height: 375.0,
                        width: width,
                        padding: EdgeInsets.all(15.0),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              courseData.courseCategory,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 14.0,
                                fontFamily: 'Signika Negative',
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              courseData.courseName,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Signika Negative',
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          courseData.courseRating,
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 14.0,
                                            fontFamily: 'Signika Negative',
                                          ),
                                        ),
                                        SizedBox(width: 2.0),
                                        Icon(
                                          Icons.star,
                                          color: iconColor,
                                          size: 15.0,
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(
                                          '(${courseData.courseNumberOfRating} Reviews)',
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 14.0,
                                            fontFamily: 'Signika Negative',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '\$${courseData.coursePrice}',
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24.0,
                                        fontFamily: 'Signika Negative',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SelectPlan(
                                              courseName: courseData.courseName,
                                              image: courseData.courseImage,
                                              price: courseData.coursePrice,
                                            )));
                              },
                              child: Container(
                                width: width,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(13.0),
                                decoration: BoxDecoration(
                                    color: buttonColor,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Text(
                                  'Take the Course',
                                  style: TextStyle(
                                    fontFamily: 'Signika Negative',
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    wordSpacing: 3.0,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoPlay()));
                              },
                              child: Container(
                                width: width,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(13.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Text(
                                  'Watch Trailer',
                                  style: TextStyle(
                                    fontFamily: 'Signika Negative',
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    wordSpacing: 3.0,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      'Overview',
                      style: TextStyle(
                        fontFamily: 'Signika Negative',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Lessons',
                      style: TextStyle(
                        fontFamily: 'Signika Negative',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            ListView(
              children: <Widget>[
                OverviewCoursePage(),
              ],
            ),
            Lessons(
              scaffoldKey: _scaffoldKey,
            ),
          ],
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        body: nestedAppBar(_scaffoldKey),
      ),
    );
  }
}
