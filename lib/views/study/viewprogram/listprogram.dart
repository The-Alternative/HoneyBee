import 'package:honeyBee/models/study/exam.dart';

import 'package:flutter/material.dart';
import 'package:honeyBee/models/study/program.dart';
import 'package:honeyBee/views/study/viewprogram/cardprogram.dart';

class ListProgram extends StatelessWidget {
  final List<Program> listOfProgram;
  final Function setData;
  ListProgram(this.listOfProgram, this.setData);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) =>
          CardProgram(listOfProgram[index], setData),
      itemCount: listOfProgram.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
