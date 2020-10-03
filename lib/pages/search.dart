import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    InkWell tagTile(String tag) {
        return InkWell(
          onTap: () {},
          child: Text(
            tag,
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Signika Negative',
              color: Colors.grey,
            ),
          ),
        );
      }

    nestedAppBar() {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 180,
              pinned: true,
              titleSpacing: 0.0,
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
                  child: Container(
                    // width: width - 20.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Try "Easy ways write a novel"',
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
            ),
          ];
        },
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Popular Tags',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Signika Negative',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  tagTile('Business & Management'),
                  Divider(),
                  SizedBox(height: 5.0),
                  tagTile('Creative Art & Media'),
                  Divider(),
                  SizedBox(height: 5.0),
                  tagTile('Health & Psychology'),
                  Divider(),
                  SizedBox(height: 5.0),
                  tagTile('History'),
                  Divider(),
                  SizedBox(height: 5.0),
                  tagTile('Languages & Cultures'),
                  Divider(),
                  SizedBox(height: 5.0),
                  tagTile('Science, Engineering & Maths'),
                  Divider(),
                  SizedBox(height: 5.0),
                  tagTile('Study Skills'),
                  Divider(),
                  SizedBox(height: 5.0),
                  tagTile('Tech & Coding'),
                  Divider(),
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: nestedAppBar(),
    );
  }
}
