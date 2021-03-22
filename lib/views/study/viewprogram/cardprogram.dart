import 'package:flutter/material.dart';
import 'package:honeyBee/models/study/program.dart';
import 'package:honeyBee/services/study/programservice.dart';

class CardProgram extends StatefulWidget {
  final Program exam;
  final Function setData;

  CardProgram(this.exam, this.setData);
  @override
  State<StatefulWidget> createState() {
    return _CardProgram(this.exam, this.setData);
  }
}

class _CardProgram extends State<CardProgram> {
  ProgramService helper = new ProgramService();

  Program exam;
  Function setData;
  _CardProgram(this.exam, this.setData);

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
              Text('${exam.course}${exam.dateprogram}'),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              helper.deleteprogram(exam);
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
