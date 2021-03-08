import 'package:honeyBee/models/study/exam.dart';

import 'package:flutter/material.dart';
import 'package:honeyBee/views/study/viewexam/cardexam.dart';

class ListExam extends StatelessWidget {
  final List<Exam> listOfExam;
  final Function setData;
  ListExam(this.listOfExam, this.setData);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => CardExam(listOfExam[index], setData),
      itemCount: listOfExam.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
