import 'dart:math';

import 'startdate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:intl/intl.dart';

class LactuarAppointments2 extends StatefulWidget {
  @override
  _LactuarAppointments2State createState() => _LactuarAppointments2State();
}

class _LactuarAppointments2State extends State<LactuarAppointments2> {
  String date;
  String time;

  TimeOfDay timeOfDay = TimeOfDay.now();
  selectedTodotime(BuildContext context) async {
    var pickTime = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    if (pickTime != null) {
      setState(() {
        timeOfDay = pickTime;
        time = TimeOfDay(hour: pickTime.hour, minute: pickTime.minute)
            .format(context);
      });
    }
  }

  DateTime dateTime = DateTime.now();
  selectedTodoDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      setState(() {
        dateTime = pickedDate;
        date = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: 60,
            toolbarHeight: 65,
            title: Row(
              children: [
                SizedBox(
                  width: 203,
                ),
                Text(
                  'الدراسة',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  "assets/logo.png",
                  height: 52,
                  width: 52,
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(),
              ],
            ),
            backgroundColor: Colors.amber[400],
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/calendar(1).png",
                        scale: 2.0,
                      ),
                      SizedBox(
                        width: 168,
                      ),
                      Text(
                        ' المواعيد',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 197,
                      ),
                      Text(
                        "  إدخال يدوي",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Image.asset("assets/date-basel.png"),
                          onPressed: () {
                            selectedTodoDate(context);
                          }),
                      SizedBox(
                        width: 11,
                      ),
                      Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: date == null
                              ? Text('')
                              : Text(
                                  '$date',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "الموعد الأول",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Image.asset(
                            "assets/clock.png",
                          ),
                          onPressed: () {
                            selectedTodotime(context);
                          }),
                      SizedBox(
                        width: 11,
                      ),
                      Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: time == null
                              ? Text('')
                              : Text(
                                  '$time',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 36,
                      ),
                      Text(
                        "الساعة",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Colors.amber[400],
                    height: 20,
                    thickness: 1.0,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 124,
                      ),
                      IconButton(
                          icon: Image.asset(
                            "assets/add.png",
                          ),
                          onPressed: () {}),
                    ],
                  ),
                  SizedBox(
                    height: 111,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      FlatButton(
                        child: Text(' التالي',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => StartDate()));
                        },
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      FlatButton(
                        child: Text(' السابق',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
