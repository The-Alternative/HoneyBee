import 'package:honeyBee/controllers/study/examcontroller.dart';
import 'package:honeyBee/models/study/course.dart';

import 'package:flutter/material.dart';
import 'package:honeyBee/models/study/exam.dart';

import 'package:honeyBee/views/study/viewexam/listexam.dart';

class HomeExam extends StatefulWidget {
  @override
  _HomeExamState createState() => _HomeExamState();
}

class _HomeExamState extends State<HomeExam> {
  ExamController _examController = ExamController();
  List<Exam> examlist = List<Exam>();
  @override
  void initState() {
    super.initState();
    setState(() {
      setData();
    });
  }

  Future setData() async {
    examlist.clear();
    (await _examController.getInfo('exams')).forEach((medMap) {
      setState(() {
        examlist.add(Exam().courseMapToObject(medMap));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          examlist.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(width: 43),
                      SizedBox(height: 127),
                      Image(
                        width: 280,
                        height: 280,
                        image: AssetImage(
                          "assets/center.png",
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                )
              : ListExam(examlist, setData),
        ],
      ),
    );
  }
}
