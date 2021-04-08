import 'package:flutter/material.dart';
import 'package:honeyBee/views/study/viewcourse/home.course.dart';
import 'package:honeyBee/views/study/viewexam/home.exam.dart';

class HomeExamP extends StatefulWidget {
  @override
  _HomeExamPState createState() => _HomeExamPState();
}

class _HomeExamPState extends State<HomeExamP> {
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
                'الامتحان',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ]),
            backgroundColor: Colors.amber[400],
          ),
          body: HomeExam(),
        ),
      ),
    );
  }
}
