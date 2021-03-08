import 'package:honeyBee/views/study/viewexam/home.exam.dart';

import '../../controllers/study/coursecontroller.dart';
import '../../models/study/course.dart';
import '../../views/study/assignments.dart';
import '../../views/study/newcourse.dart';
import '../../views/study/viewcourse/home.course.dart';
import '../../controllers/study/coursecontroller.dart';
import '../../models/study/course.dart';
import '../../views/study/assignments.dart';
import '../../views/study/newcourse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class StudyHome extends StatefulWidget {
  @override
  _StudyHomeState createState() => _StudyHomeState();
}

class _StudyHomeState extends State<StudyHome> {
  CourseController helper;

  @override
  void initState() {
    super.initState();
    helper = CourseController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: 60,
              toolbarHeight: 120,
              title: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 203,
                      ),
                      Text(
                        'الدراسة',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/logo.png",
                        height: 52,
                        width: 52,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(),
                    ],
                  ),
                ],
              ),
              backgroundColor: Colors.amber[400],
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Text('مقررات',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        )),
                  ),
                  Tab(
                    child: Text(
                      'مواعيد ومهام',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                HomeCourse(),
                HomeExam(),
              ],
            ),
            floatingActionButton: SpeedDial(
              animatedIcon: AnimatedIcons.add_event,
              backgroundColor: Colors.amber[400],
              overlayColor: Colors.black,
              overlayOpacity: 0.0,
              animatedIconTheme: IconThemeData.fallback(),
              marginBottom: 25,
              shape: CircleBorder(),

              children: [
                SpeedDialChild(
                  child: Icon(
                    Icons.auto_stories,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.amber[400],
                  label: "اضافة مقرر",
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Newcourse())),
                ),
                SpeedDialChild(
                  child: Icon(
                    Icons.article,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.amber[400],
                  label: " اضافة موعد أو مهمة",
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Assignments())),
                ),
              ], // This trailing
            ),
          ),
        ),
      ),
    );
  }
}
