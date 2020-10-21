import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/dataClass/apiVariables.dart';
import 'package:learn_pro/dataClass/passDataToCoursePage.dart';
import 'package:learn_pro/pages/course/course.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  final String categoryName;
  final String id;
  Category({Key key, @required this.categoryName, @required this.id})
      : super(key: key);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var categoryItemList = new List<CategoryItemData>();
  void initState() {
    getCategoryItems();
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  // final categoryItemList = [
  //   {
  //     'id': 1,
  //     'title': 'Design Instruments for Communication',
  //     'image': 'assets/new_course/new_course_1.png',
  //     'category': 'Demo Category',
  //     'price': '59',
  //     'courseRating': '4.0',
  //     'numberOfRating': '5'
  //   },
  //   {
  //     'id': 2,
  //     'title': 'Weight Training Courses with Any Di',
  //     'image': 'assets/new_course/new_course_2.png',
  //     'category': 'Demo Category',
  //     'price': '64',
  //     'courseRating': '4.5',
  //     'numberOfRating': '6'
  //   },
  //   {
  //     'id': 3,
  //     'title': 'How to be a DJ? Make Electronic Music',
  //     'image': 'assets/new_course/new_course_4.png',
  //     'category': 'Demo Category',
  //     'price': '59',
  //     'courseRating': '4.8',
  //     'numberOfRating': '8'
  //   },
  //   {
  //     'id': 4,
  //     'title': 'Console Development Basics with Unity',
  //     'image': 'assets/new_course/new_course_3.png',
  //     'category': 'Demo Category',
  //     'price': '64',
  //     'courseRating': '4.0',
  //     'numberOfRating': '15'
  //   },
  //   {
  //     'id': 5,
  //     'title': 'Design Instruments for Communication',
  //     'image': 'assets/new_course/new_course_1.png',
  //     'category': 'Demo Category',
  //     'price': '59',
  //     'courseRating': '4.0',
  //     'numberOfRating': '3'
  //   },
  //   {
  //     'id': 6,
  //     'title': 'Weight Training Courses with Any Di',
  //     'image': 'assets/new_course/new_course_2.png',
  //     'category': 'Demo Category',
  //     'price': '64',
  //     'courseRating': '4.5',
  //     'numberOfRating': '2'
  //   },
  //   {
  //     'id': 7,
  //     'title': 'How to be a DJ? Make Electronic Music',
  //     'image': 'assets/new_course/new_course_4.png',
  //     'category': 'Demo Category',
  //     'price': '59',
  //     'courseRating': '4.8',
  //     'numberOfRating': '22'
  //   },
  //   {
  //     'id': 8,
  //     'title': 'Console Development Basics with Unity',
  //     'image': 'assets/new_course/new_course_3.png',
  //     'category': 'Demo Category',
  //     'price': '64',
  //     'courseRating': '4.0',
  //     'numberOfRating': '49'
  //   }
  // ];
  @override
  Widget build(BuildContext context) {
    String categoryName = widget.categoryName;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: textColor,
        titleSpacing: 0.0,
        title: Text(
          categoryName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Signika Negative',
            letterSpacing: 0.7,
            height: 1.5,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: categoryItemList.length,
        itemBuilder: (context, index) {
          final item = categoryItemList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CoursePage(
                            courseData: PassDataToCoursePage(
                              item.id,
                              item.thumbnail,
                              item.title,
                              widget.categoryName,
                              item.courseRating.toString(),
                              item.noOfRating.toString(),
                              item.price,
                            ),
                          )));
            },
            child: Container(
              margin: EdgeInsets.only(
                right: 15.0,
                left: 15.0,
                top: (index == 0) ? 15.0 : 0.0,
                bottom: 15.0,
              ),
              padding: EdgeInsets.all(10.0),
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
                        image: NetworkImage(item.thumbnail),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  Container(
                    width: width - 150.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 4.0, right: 8.0, left: 8.0),
                          child: Text(
                            item.title,
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
                            '\u20B9 ${item.price.split("Rp")[1]}',
                            style: TextStyle(
                              fontSize: 18.0,
                              height: 1.6,
                              fontFamily: 'Signika Negative',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, right: 8.0, left: 8.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                item.courseRating.toString(),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Signika Negative',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.7,
                                  color: headingColor,
                                ),
                              ),
                              SizedBox(width: 3.0),
                              Icon(Icons.star, size: 14.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  getCategoryItems() async {
    var url =
        Uri.parse('$baseUrl/category_wise_course?category_id=${widget.id}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        Iterable list = json.decode(response.body);
        categoryItemList =
            list.map((model) => CategoryItemData.fromJson(model)).toList();
      });
    }
  }
}

class CategoryItemData {
  final String id;
  final String title;
  final String shortDescription;
  final String thumbnail;
  final String price;
  final int courseRating;
  final int noOfRating;

  CategoryItemData(
      {this.id,
      this.title,
      this.shortDescription,
      this.thumbnail,
      this.price,
      this.courseRating,
      this.noOfRating});

  factory CategoryItemData.fromJson(Map<String, dynamic> json) {
    return CategoryItemData(
        id: json['id'],
        title: json['title'],
        shortDescription: json['short_description'],
        thumbnail: json['thumbnail'],
        price: json['price'],
        courseRating: json['rating'],
        noOfRating: json['number_of_ratings']);
  }
}
