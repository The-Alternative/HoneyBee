import 'package:flutter/material.dart';
import 'package:honeyBee/models/study/homework.dart';
import 'dart:io';
import 'dart:ui';

import 'package:honeyBee/services/study/homeworkservice.dart';

class CardHomeWork extends StatefulWidget {
  final HomeWork exam;
  final Function setData;

  CardHomeWork(this.exam, this.setData);
  @override
  State<StatefulWidget> createState() {
    return _CardHomeWork(this.exam, this.setData);
  }
}

class _CardHomeWork extends State<CardHomeWork> {
  HomeWorkService helper = new HomeWorkService();

  HomeWork exam;
  Function setData;
  _CardHomeWork(this.exam, this.setData);

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
              Text('${exam.datehomework}${exam.homeworkcourse}'),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              helper.delethomework(exam);
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
