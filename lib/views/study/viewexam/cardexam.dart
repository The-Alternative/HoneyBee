import 'package:googleapis/androidpublisher/v3.dart';
import 'package:googleapis/digitalassetlinks/v1.dart';
import 'package:googleapis/games/v1.dart';
import 'package:honeyBee/models/study/course.dart';
import 'package:honeyBee/models/study/exam.dart';
import 'package:honeyBee/services/study/courseservice.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';

import 'package:honeyBee/services/study/examservice.dart';

class CardExam extends StatefulWidget {
  final Exam exam;
  final Function setData;

  CardExam(this.exam, this.setData);
  @override
  State<StatefulWidget> createState() {
    return _CardExam(this.exam, this.setData);
  }
}

class _CardExam extends State<CardExam> {
  ExamService helper = new ExamService();
  Exam exam;
  Function setData;
  _CardExam(this.exam, this.setData);

  @override
  Widget build(BuildContext context) {
    //check if the medicine time is lower than actual
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),

      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          title: Row(
            children: [
              CircleAvatar(
                  // backgroundImage: AssetImage('${course.image}'),
                  ),
              SizedBox(
                width: 10,
              ),
              Text('${exam.dateexam}'),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              helper.deleteexam(exam);
            },
          ),
        ),
      ),
      // child: Card(
      //     child: Column(children: [
      //   Container(
      //     width: 150,
      //     height: 50,
      //     child: Row(children: [
      //       Text(
      //         '${course.namecourse}',

      //       ),
      //       SizedBox(width: 20,),
      //       IconButton(
      //         icon: Icon(Icons.delete),
      //         onPressed: () {
      //           setState(() {
      //             helper.deleteCourse(course);
      //           });
      //         },
      //       )
      //     ]),
      //   ),
      // ])),
    );
  }

  //============================================================================================
  //-----------------------|getImg|-------------------------------------

}
