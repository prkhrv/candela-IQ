import 'package:flutter/material.dart';
import 'package:learn_pro/dataClass/apiVariables.dart';
import 'package:learn_pro/pages/home/home_component/category_list.dart';
// import 'package:learn_pro/pages/home/home_component/instructors_slide.dart';
import 'package:learn_pro/pages/home/home_component/main_slider.dart';
import 'package:learn_pro/pages/home/home_component/new_courses.dart';
import 'package:learn_pro/pages/home/home_component/popular_courses.dart';
import 'package:learn_pro/pages/notifications.dart';
import 'package:learn_pro/pages/settings/account_settings.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    nestedAppBar() {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: innerBoxIsScrolled
                  ? IconButton(
                      icon: new Image.asset(
                        "assets/icon.png",
                        color: Colors.white,
                      ),
                      splashColor: Colors.white,
                      onPressed: null)
                  : Icon(
                      Icons.verified_user,
                      color: Colors.blue,
                      size: 0.0,
                    ),
              expandedHeight: 180,
              pinned: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notifications()));
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/appbar_bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/home_logo_white.png",
                        width: 160.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccountSettings()));
                        },
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            image: DecorationImage(
                              image: NetworkImage(userData['profile_pic']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
            ),
          ];
        },
        body: ListView(
          children: <Widget>[
            MainSlider(),
            SizedBox(height: 10.0),
            CategoryList(),
            SizedBox(height: 10.0),
            PoplularCourse(),
            SizedBox(height: 10.0),
            NewCourse(),
            // SizedBox(height: 10.0),
            // InstructorHomeSlide(),
          ],
        ),
      );
    }

    return Scaffold(
      // backgroundColor: Colors.grey[],
      body: nestedAppBar(),
    );
  }
}
