import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_pro/dataClass/apiVariables.dart';
import 'package:learn_pro/pages/home/home_component/category.dart';
import 'package:http/http.dart' as http;

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  var categoryList = new List<CategoryListData>();
  @override
  void initState() {
    getCategories();
    print(categoryList);

    super.initState();
  }

  dispose() {
    super.dispose();
  }

  // final categoryList = [
  //   {
  //     'categoryName': 'Art & Photography',
  //     'image': 'assets/category/category_1.jpg',
  //   },
  //   {
  //     'categoryName': 'Health & Fitness',
  //     'image': 'assets/category/category_2.jpg',
  //   },
  //   {
  //     'categoryName': 'Business & Marketing',
  //     'image': 'assets/category/category_3.jpg',
  //   },
  //   {
  //     'categoryName': 'Computer Science',
  //     'image': 'assets/category/category_4.jpg',
  //   },
  //   {
  //     'categoryName': '3D Printing Concept',
  //     'image': 'assets/category/category_5.jpg',
  //   },
  //   {
  //     'categoryName': 'Electronic',
  //     'image': 'assets/category/category_6.jpg',
  //   }
  // ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 130.0,
      child: ListView.builder(
        itemCount: categoryList.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = categoryList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Category(categoryName: item.name, id: item.id)));
            },
            child: Container(
              width: 130.0,
              margin: (index == categoryList.length - 1)
                  ? EdgeInsets.only(left: 10.0, right: 10.0)
                  : EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item.thumbnail),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(65.0),
              ),
              child: Container(
                width: 130.0,
                height: 130.0,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(65.0),
                  color: Colors.black.withOpacity(0.6),
                ),
                child: Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Signika Negative',
                    letterSpacing: 0.7,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Fetch Categories
  getCategories() async {
    var url = Uri.parse('$baseUrl/categories');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        Iterable list = json.decode(response.body);
        categoryList =
            list.map((model) => CategoryListData.fromJson(model)).toList();
      });
    }
  }
}

// DATA CLASS

class CategoryListData {
  final String id;
  final String code;
  final String name;
  final String thumbnail;

  CategoryListData({
    this.id,
    this.code,
    this.name,
    this.thumbnail,
  });

  factory CategoryListData.fromJson(Map<String, dynamic> json) {
    return CategoryListData(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        thumbnail: json['thumbnail']);
  }
}
