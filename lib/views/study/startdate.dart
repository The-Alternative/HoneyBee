import '../../views/study/repet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class StartDate extends StatefulWidget {
  @override
  _StartDateState createState() => _StartDateState();
}

class _StartDateState extends State<StartDate> {
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
      lastDate: DateTime(2100),
    );

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
              child: Column(children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/date.png",
                      scale: 2.0,
                    ),
                    SizedBox(
                      width: 140,
                    ),
                    Text(
                      ' تاريخ البدء',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    IconButton(
                        icon: Image.asset("assets/date-basel.png"),
                        onPressed: () {
                          selectedTodoDate(context);
                        }),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 40,
                      width: 135,
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
                      width: 30,
                    ),
                    Text(
                      " التاريخ",
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
                      width: 20,
                    ),
                    Container(
                      height: 40,
                      width: 135,
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
                  height: 209,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    FlatButton(
                      child: Text(' التالي',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Repeted()));
                      },
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    FlatButton(
                      child: Text(' السابق',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
