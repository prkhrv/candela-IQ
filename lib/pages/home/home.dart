import 'dart:io';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learn_pro/pages/home/home_main.dart';
import 'package:learn_pro/pages/my_course.dart';
import 'package:learn_pro/pages/search.dart';
import 'package:learn_pro/pages/settings/settings.dart';
import 'package:learn_pro/pages/wishlist.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex;
  DateTime currentBackPressTime;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        hasNotch: false,
        opacity: 0.2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(
                16)), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.orange,
            ),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.favorite_border,
              color: Colors.orange,
            ),
            title: Text(
              'Wishlist',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.search,
              color: Colors.orange,
            ),
            title: Text(
              'Search',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          BubbleBottomBarItem(
              backgroundColor: Colors.orange,
              icon: Icon(
                Icons.library_books,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.library_books,
                color: Colors.orange,
              ),
              title: Text(
                'My Course',
                style: TextStyle(fontSize: 12.0),
              )),
          BubbleBottomBarItem(
              backgroundColor: Colors.orange,
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: Colors.orange,
              ),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 12.0),
              ))
        ],
      ),
      body: WillPopScope(
            child: (currentIndex == 0)
                ? HomeMain()
                : (currentIndex == 1)
                    ? Wishlist()
                    : (currentIndex == 2)
                    ? Search()
                    : (currentIndex == 3)
                        ? MyCourse()
                        : Settings(),
            onWillPop: onWillPop,
          ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: Theme.of(context).appBarTheme.color,
      );
      return Future.value(false);
    }
    exit(0);
    return Future.value(true);
  }
  
}
