import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learn_pro/appTheme/appTheme.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  int wishlistItem = 2;

  final wishlistItemList = [
    {
      'title': 'Design Instruments for Communication',
      'image': 'assets/new_course/new_course_1.png',
      'price': '59',
      'courseRating': '4.0'
    },
    {
      'title': 'Weight Training Courses with Any Di',
      'image': 'assets/new_course/new_course_2.png',
      'price': '64',
      'courseRating': '4.5'
    }
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
                    'Wishlist',
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
        body: (wishlistItem == 0)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.heartBroken,
                      color: Colors.grey,
                      size: 60.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'No Item in Wishlist',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                        fontFamily: 'Signika Negative',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: wishlistItemList.length,
                itemBuilder: (context, index) {
                  final item = wishlistItemList[index];
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    secondaryActions: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: 5.0,
                          bottom: 5.0,
                        ),
                        child: IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            setState(() {
                              wishlistItemList.removeAt(index);
                              wishlistItem = wishlistItem - 1;
                            });

                            // Then show a snackbar.
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Item Removed')));
                          },
                        ),
                      ),
                    ],
                    child: Container(
                      margin: EdgeInsets.only(
                        right: 15.0,
                        left: 15.0,
                        top: 10.0,
                        bottom: 10.0,
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
                                image: AssetImage(item['image']),
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
                                      top: 8.0,
                                      bottom: 4.0,
                                      right: 8.0,
                                      left: 8.0),
                                  child: Text(
                                    item['title'],
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
                                      top: 0.0,
                                      right: 8.0,
                                      left: 8.0,
                                      bottom: 8.0),
                                  child: Text(
                                    '\$${item['price']}',
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
                                      top: 0.0,
                                      right: 8.0,
                                      left: 8.0,
                                      bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        item['courseRating'],
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

    return Scaffold(
      body: nestedAppBar(),
    );
  }
}
