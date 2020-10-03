import 'package:flutter/material.dart';
import 'package:learn_pro/pages/video_play/video_play.dart';

class Lessons extends StatefulWidget {
  final scaffoldKey;

  Lessons({Key key, this.scaffoldKey}) : super(key: key);
  @override
  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  final lessonList = [
    {
      'title': 'Trailer',
      'img': 'assets/new_course/new_course_1.png',
      'description':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'status': 'unlocked'
    },
    {
      'title': 'Lesson 1',
      'img': 'assets/new_course/new_course_2.png',
      'description':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'status': 'locked'
    },
    {
      'title': 'Lesson 2',
      'img': 'assets/new_course/new_course_3.png',
      'description':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'status': 'locked'
    },
    {
      'title': 'Lesson 3',
      'img': 'assets/new_course/new_course_4.png',
      'description':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'status': 'locked'
    },
    {
      'title': 'Lesson 4',
      'img': 'assets/new_course/new_course_5.png',
      'description':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      'status': 'locked'
    },
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    _checkStatus(String status) {
      if (status == 'locked') {
        widget.scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
          'First purchase this course then you access this lesson.',
          style: TextStyle(fontSize: 14.0),
        )));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => VideoPlay()));
      }
    }

    return ListView.builder(
      itemCount: lessonList.length,
      itemBuilder: (context, index) {
        final item = lessonList[index];
        return Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                _checkStatus(item['status']);
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(item['img']),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    Container(
                      width: width - 120.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 4.0, right: 8.0, left: 8.0),
                            child: Text(
                              '${item['title']}',
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
                              '${item['description']}',
                              style: TextStyle(
                                fontSize: 14.0,
                                height: 1.6,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0.0, right: 8.0, left: 8.0, bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  (item['status'] == 'locked')
                                      ? Icons.lock
                                      : Icons.lock_open,
                                  size: 20.0,
                                ),
                                SizedBox(width: 3.0),
                                Text((item['status'] == 'locked')
                                    ? 'Locked'
                                    : 'Unlocked'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
