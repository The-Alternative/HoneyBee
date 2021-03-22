import 'package:honeyBee/views/study/viewcourse/HOMEC.dart';
import 'package:honeyBee/views/study/viewexam/HOMEC.dart';
import 'package:honeyBee/views/study/viewhomework/HOMEH.dart';
import 'package:honeyBee/views/study/viewprogram/HOME.dart';

import '../../controllers/study/coursecontroller.dart';

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
        child: Scaffold(
          appBar: AppBar(
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
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: ListView(
                children: [
                  SizedBox(height: 70),
                  Row(
                    children: [
                      ClipOval(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.amber[400], width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            image: DecorationImage(
                              image: AssetImage("assets/homework.png"),
                              scale: 6.0,
                            ),
                          ),
                          child: FlatButton(
                            child: null,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomeProgram()));
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      ClipOval(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.amber[400], width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            image: DecorationImage(
                              image: AssetImage("assets/presentation.png"),
                              scale: 5.0,
                            ),
                          ),
                          child: FlatButton(
                            child: null,
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => LactuarDate()));
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      ClipOval(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.amber[400], width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            image: DecorationImage(
                              image: AssetImage("assets/Bokk.png"),
                              scale: 8.0,
                            ),
                          ),
                          child: FlatButton(
                            child: null,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomeCourseP()));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 6),
                      Text(
                        'برنامج دراسي',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Text('مواعيد المحاضرات',
                          style: TextStyle(color: Colors.black, fontSize: 14)),
                      SizedBox(
                        width: 63,
                      ),
                      Text('مقررات',
                          style: TextStyle(color: Colors.black, fontSize: 14)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ClipOval(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.amber[400], width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            image: DecorationImage(
                              image: AssetImage("assets/surface1.png"),
                              scale: 5.0,
                            ),
                          ),
                          child: FlatButton(
                            child: null,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomeHomeworkP()));
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      ClipOval(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.amber[400], width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            image: DecorationImage(
                              image: AssetImage("assets/exam.png"),
                              scale: 3.5,
                            ),
                          ),
                          child: FlatButton(
                            child: null,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomeExamP()));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'وظائف',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      SizedBox(
                        width: 88,
                      ),
                      Text(
                        'امتحان',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
    );
  }
}
