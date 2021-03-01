import 'package:bassel/models/study/course.dart';
import 'package:bassel/services/study/courseservice.dart';
import 'package:bassel/utils/databaseconfig.dart';
import 'package:flutter/material.dart';

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
        child: ListTile(
          title: Text('${course.namecourse}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              helper.deleteCourse(course);
              setState(() {});
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
