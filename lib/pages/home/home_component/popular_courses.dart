import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learn_pro/dataClass/apiVariables.dart';
import 'package:learn_pro/dataClass/passDataToCoursePage.dart';
import 'package:learn_pro/pages/course/course.dart';
import 'package:http/http.dart' as http;

class PoplularCourse extends StatefulWidget {
  @override
  _PoplularCourseState createState() => _PoplularCourseState();
}

class _PoplularCourseState extends State<PoplularCourse> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: 400.0,
      color: Theme.of(context).appBarTheme.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Popular Courses',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Signika Negative',
                letterSpacing: 0.7,
              ),
            ),
          ),
          Container(
            height: 340.0,
            child: FutureBuilder<List<Courses>>(
              future: loadProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext ctxt, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CoursePage(
                                    courseData: PassDataToCoursePage(
                                        snapshot.data[index].courseId,
                                        snapshot.data[index].courseImage,
                                        snapshot.data[index].courseName,
                                        snapshot.data[index].courseCategory,
                                        snapshot.data[index].courseRating,
                                        snapshot
                                            .data[index].courseNumberOfRating,
                                        snapshot.data[index].coursePrice,
                                        snapshot.data[index].description),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 230.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2.0,
                                    spreadRadius: 1.5,
                                    color: Colors.grey[300],
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Hero(
                                    tag: Text(
                                        '${snapshot.data[index].courseId}'),
                                    child: Container(
                                      height: 150.0,
                                      width: 230.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data[index].courseImage),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data[index].courseCategory,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.0,
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Text(
                                          snapshot.data[index].courseName,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data[index].courseRating,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 17.0,
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Text(
                                              '(${snapshot.data[index].courseNumberOfRating})',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        Text(
                                          '\u20B9 ${snapshot.data[index].coursePrice}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: SpinKitRipple(color: Colors.red),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Courses {
  String courseId;
  String courseImage;
  String courseName;
  String courseCategory;
  String courseRating;
  String courseNumberOfRating;
  String coursePrice;
  String description;

  Courses(
      this.courseId,
      this.courseImage,
      this.courseName,
      this.courseCategory,
      this.courseRating,
      this.courseNumberOfRating,
      this.coursePrice,
      this.description);
}

Future<List<Courses>> loadProducts() async {
  var url = Uri.parse('$baseUrl/top_courses');
  final jsonString = await http.get(url);
  Iterable list = json.decode(jsonString.body);

  List<Courses> courses = [];

  for (var o in list) {
    Courses course = Courses(
        o["id"],
        o["thumbnail"],
        o["title"],
        o["short_description"],
        o["rating"].toString(),
        o["number_of_ratings"].toString(),
        o["price"],
        o["description"]);

    courses.add(course);
  }

  return courses;
}
