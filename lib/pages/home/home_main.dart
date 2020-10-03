import 'package:flutter/material.dart';
import 'package:learn_pro/pages/home/home_component/category_list.dart';
import 'package:learn_pro/pages/home/home_component/instructors_slide.dart';
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
              expandedHeight: 180,
              pinned: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Notifications()));
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
                      Text(
                        'Home',
                        style: TextStyle(
                          fontFamily: 'Signika Negative',
                          fontWeight: FontWeight.w700,
                          fontSize: 25.0,
                        ),
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
                              image:
                                  AssetImage('assets/user_profile/user_3.jpg'),
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
            SizedBox(height: 10.0),
            InstructorHomeSlide(),
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
