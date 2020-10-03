import 'package:flutter/material.dart';
import 'package:learn_pro/pages/home/home_component/category.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final categoryList = [
    {
      'categoryName': 'Art & Photography',
      'image': 'assets/category/category_1.jpg',
    },
    {
      'categoryName': 'Health & Fitness',
      'image': 'assets/category/category_2.jpg',
    },
    {
      'categoryName': 'Business & Marketing',
      'image': 'assets/category/category_3.jpg',
    },
    {
      'categoryName': 'Computer Science',
      'image': 'assets/category/category_4.jpg',
    },
    {
      'categoryName': '3D Printing Concept',
      'image': 'assets/category/category_5.jpg',
    },
    {
      'categoryName': 'Electronic',
      'image': 'assets/category/category_6.jpg',
    }
  ];
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
                          Category(categoryName: item['categoryName'])));
            },
            child: Container(
                width: 130.0,
                margin: (index == categoryList.length - 1)
                    ? EdgeInsets.only(left: 10.0, right: 10.0)
                    : EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(item['image']),
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
                    item['categoryName'],
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
}
