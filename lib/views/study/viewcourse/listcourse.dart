import 'package:honeyBee/models/study/course.dart';
import 'package:honeyBee/views/study/viewcourse/cardcourse.dart';

import 'package:flutter/material.dart';

class ListCourse extends StatelessWidget {
  final List<Course> listOfCourse;
  final Function setData;
  ListCourse(this.listOfCourse, this.setData);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => CardCourse(listOfCourse[index], setData),
      itemCount: listOfCourse.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
