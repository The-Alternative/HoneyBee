import 'package:googleapis/androidpublisher/v3.dart';
import 'package:googleapis/digitalassetlinks/v1.dart';
import 'package:googleapis/games/v1.dart';
import 'package:honeyBee/models/study/course.dart';
import 'package:honeyBee/services/study/courseservice.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';

class CardCourse extends StatefulWidget {
  final Course course;
  final Function setData;

  CardCourse(this.course, this.setData);
  @override
  State<StatefulWidget> createState() {
    return _CardCourse(this.course, this.setData);
  }
}

class _CardCourse extends State<CardCourse> {
  CourseService helper = new CourseService();
  Course course;
  Function setData;
  _CardCourse(this.course, this.setData);

  @override
  Widget build(BuildContext context) {
    //check if the medicine time is lower than actual
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 1,
                color: Colors.amber[400],
              )),
          child: ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('${course.image}'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('${course.namecourse}'),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                helper.deleteCourse(course);
              },
            ),
          ),
        ),
      ),
    );
  }

  //============================================================================================
  //-----------------------|getImg|-------------------------------------

}
