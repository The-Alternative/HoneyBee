import 'package:flutter/material.dart';
import 'package:honeyBee/views/study/viewcourse/home.course.dart';

class HomeCourseP extends StatefulWidget {
  @override
  _HomeCoursePState createState() => _HomeCoursePState();
}

class _HomeCoursePState extends State<HomeCourseP> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Row(children: [
              SizedBox(width: 140),
              Text(
                'المقررات',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ]),
            backgroundColor: Colors.amber[400],
          ),
          body: HomeCourse(),
        ),
      ),
    );
  }
}
