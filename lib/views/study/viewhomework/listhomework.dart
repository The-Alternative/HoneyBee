import 'package:honeyBee/models/study/exam.dart';

import 'package:flutter/material.dart';
import 'package:honeyBee/models/study/homework.dart';

import 'package:honeyBee/views/study/viewhomework/cardhomework.dart';

class ListHomeWork extends StatelessWidget {
  final List<HomeWork> listOfHomeWork;
  final Function setData;
  ListHomeWork(this.listOfHomeWork, this.setData);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) =>
          CardHomeWork(listOfHomeWork[index], setData),
      itemCount: listOfHomeWork.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
