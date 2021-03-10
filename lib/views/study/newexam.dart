import 'package:honeyBee/controllers/study/examcontroller.dart';
import 'package:honeyBee/models/study/exam.dart';
import 'repet.dart';
import 'startdate.dart';
import 'package:flutter/material.dart';
import 'lactuarappointments.dart';
import 'package:intl/intl.dart';

class NewExam extends StatefulWidget {
  @override
  _NewExamState createState() => _NewExamState();
}

class _NewExamState extends State<NewExam> {
  String date;
  String time;
  int id;
  String examcourse;

  ExamController helper;

  @override
  void initState() {
    super.initState();
    helper = ExamController();
  }

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

  List<String> alerts = [' اسبوع', 'يومين', 'يوم'];
  String selectedalerts = 'يوم';

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
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 60,
                        ),
                        Image.asset(
                          "assets/exam.png",
                          scale: 3.0,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'امتحان',
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
                    TextFormField(
                        cursorColor: Colors.amber[400],
                        cursorHeight: 25,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                            hintText: 'اسم المقرر',
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amber[400]))),
                        onChanged: (value) {
                          setState(() {
                            examcourse = value;
                          });
                        }),
                    SizedBox(
                      height: 60,
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
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.amber[400], width: 1.0),
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
                    SizedBox(height: 20),
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
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.amber[400], width: 1.0),
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
                      height: 20,
                    ),
                    TextFormField(
                      cursorColor: Colors.amber[400],
                      cursorHeight: 25,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          hintText: 'ملاحظات',
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber[400]))),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.amber[400], width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: DropdownButton(
                            iconSize: 30,
                            isExpanded: true,
                            underline: SizedBox(),
                            items: alerts.map((alerts) {
                              return DropdownMenuItem(
                                value: alerts,
                                child: Center(
                                  child: Text(
                                    alerts,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedalerts = value;
                              });
                            },
                            value: selectedalerts,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          'التنبيه قبل',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.alarm,
                          size: 35,
                          color: Colors.amber[400],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      color: Colors.amber[400],
                      height: 20,
                      thickness: 1.0,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        FlatButton(
                          child: Text('موافق ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          onPressed: () {
                            Exam exam = Exam();

                            exam.dateexam = date;
                            exam.timeexam = time;
                            exam.examcourse = examcourse;
                            print('$Exam');

                            helper.saveexam(exam);

                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        FlatButton(
                          child: Text('إلغاء الأمر',
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
      ),
    );
  }
}
