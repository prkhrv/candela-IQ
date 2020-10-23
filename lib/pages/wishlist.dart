import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learn_pro/appTheme/appTheme.dart';
import 'package:learn_pro/dataClass/apiVariables.dart';
import 'package:http/http.dart' as http;
import 'package:learn_pro/pages/login_signup/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  var wishlistItemList = new List<WishlistData>();
  int wishlistItem;

  @override
  void initState() {
    getWishList();
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  // final wishlistItemList = [
  //   {
  //     'title': 'Design Instruments for Communication',
  //     'image': 'assets/new_course/new_course_1.png',
  //     'price': '59',
  //     'courseRating': '4.0'
  //   },
  //   {
  //     'title': 'Weight Training Courses with Any Di',
  //     'image': 'assets/new_course/new_course_2.png',
  //     'price': '64',
  //     'courseRating': '4.5'
  //   }
  // ];
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
                                      top: 8.0,
                                      bottom: 4.0,
                                      right: 8.0,
                                      left: 8.0),
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
                                      top: 0.0,
                                      right: 8.0,
                                      left: 8.0,
                                      bottom: 8.0),
                                  child: Text(
                                    '\u20B9 ${item.price}',
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

    return Scaffold(
      body: nestedAppBar(),
    );
  }

  //loading
  void _onLoading(bool choice, String msg, Color clr) {
    choice
        ? showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new CircularProgressIndicator(
                  backgroundColor: Color(0xff00d2ff),
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
            // ignore: unnecessary_statements
          )
        : Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: clr,
            timeInSecForIos: 2,
            textColor: Colors.black,
            fontSize: 16.0);
  }

  //Logout
  _logout() async {
    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('user_id', null);
        prefs.setString('first_name', null);
        prefs.setString('last_name', null);
        prefs.setString('email', null);
        prefs.setString('role', null);
        prefs.setString('token', null);
      });
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  // Fetch
  getWishList() async {
    var url = Uri.parse('$baseUrl/my_wishlist?auth_token=$token');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        Iterable list = json.decode(response.body);
        wishlistItemList =
            list.map((model) => WishlistData.fromJson(model)).toList();
        wishlistItem = wishlistItemList.length;
      });
    } else if (response.statusCode == 401) {
      _onLoading(
          false, "Authorisation Failed or Token Expired", Colors.redAccent);
      _logout();
    }
  }
}

class WishlistData {
  final String id;
  final String title;
  final String shortDescription;
  final String thumbnail;
  final String price;
  final int courseRating;
  final int noOfRating;
  final String description;

  WishlistData(
      {this.id,
      this.title,
      this.shortDescription,
      this.thumbnail,
      this.price,
      this.courseRating,
      this.noOfRating,
      this.description});

  factory WishlistData.fromJson(Map<String, dynamic> json) {
    return WishlistData(
        id: json['id'],
        title: json['title'],
        shortDescription: json['short_description'],
        thumbnail: json['thumbnail'],
        price: json['price'],
        courseRating: json['rating'],
        noOfRating: json['number_of_ratings'],
        description: json['description']);
  }
}
