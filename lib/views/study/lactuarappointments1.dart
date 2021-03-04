import '../../views/medicine/ViewMedecineRecord/home.dart';
import '../../views/study/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LactuarAppointments1 extends StatefulWidget {
  @override
  _LactuarAppointments1State createState() => _LactuarAppointments1State();
}

class _LactuarAppointments1State extends State<LactuarAppointments1> {
  String time, time1, time2, time3, time4, time5, time6;

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

  selectedTodotime1(BuildContext context) async {
    var pickTime = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    if (pickTime != null) {
      setState(() {
        timeOfDay = pickTime;
        time1 = TimeOfDay(hour: pickTime.hour, minute: pickTime.minute)
            .format(context);
      });
    }
  }

  selectedTodotime2(BuildContext context) async {
    var pickTime = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    if (pickTime != null) {
      setState(() {
        timeOfDay = pickTime;
        time2 = TimeOfDay(hour: pickTime.hour, minute: pickTime.minute)
            .format(context);
      });
    }
  }

  selectedTodotime3(BuildContext context) async {
    var pickTime = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    if (pickTime != null) {
      setState(() {
        timeOfDay = pickTime;
        time3 = TimeOfDay(hour: pickTime.hour, minute: pickTime.minute)
            .format(context);
      });
    }
  }

  selectedTodotime4(BuildContext context) async {
    var pickTime = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    if (pickTime != null) {
      setState(() {
        timeOfDay = pickTime;
        time4 = TimeOfDay(hour: pickTime.hour, minute: pickTime.minute)
            .format(context);
      });
    }
  }

  selectedTodotime5(BuildContext context) async {
    var pickTime = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    if (pickTime != null) {
      setState(() {
        timeOfDay = pickTime;
        time5 = TimeOfDay(hour: pickTime.hour, minute: pickTime.minute)
            .format(context);
      });
    }
  }

  selectedTodotime6(BuildContext context) async {
    var pickTime = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    if (pickTime != null) {
      setState(() {
        timeOfDay = pickTime;
        time6 = TimeOfDay(hour: pickTime.hour, minute: pickTime.minute)
            .format(context);
      });
    }
  }

  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  bool value4 = false;
  bool value5 = false;
  bool value6 = false;
  bool value7 = false;

  void value1Changed(bool value) => setState(() => value1 = value);
  void value2Changed(bool value) => setState(() => value2 = value);
  void value3Changed(bool value) => setState(() => value3 = value);
  void value4Changed(bool value) => setState(() => value4 = value);
  void value5Changed(bool value) => setState(() => value5 = value);
  void value6Changed(bool value) => setState(() => value6 = value);
  void value7Changed(bool value) => setState(() => value7 = value);

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
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 153,
                      ),
                      Text(
                        "أيام محددة بالأسبوع",
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
                        height: 35,
                        width: 120,
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
                        width: 25,
                      ),
                      Text(
                        "السبت",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Checkbox(
                        value: value1,
                        onChanged: value1Changed,
                        checkColor: Colors.white,
                        activeColor: Colors.amber[400],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Image.asset(
                            "assets/clock.png",
                          ),
                          onPressed: () {
                            selectedTodotime1(context);
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: time1 == null
                              ? Text('')
                              : Text(
                                  '$time1',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 26,
                      ),
                      Text(
                        "الأحد",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Checkbox(
                        value: value2,
                        onChanged: value2Changed,
                        checkColor: Colors.white,
                        activeColor: Colors.amber[400],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Image.asset(
                            "assets/clock.png",
                          ),
                          onPressed: () {
                            selectedTodotime2(context);
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: time2 == null
                              ? Text('')
                              : Text(
                                  '$time2',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 21,
                      ),
                      Text(
                        "الإثنين",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Checkbox(
                        value: value3,
                        onChanged: value3Changed,
                        checkColor: Colors.white,
                        activeColor: Colors.amber[400],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Image.asset(
                            "assets/clock.png",
                          ),
                          onPressed: () {
                            selectedTodotime3(context);
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: time3 == null
                              ? Text('')
                              : Text(
                                  '$time3',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        "الثلاثاء",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Checkbox(
                        value: value4,
                        onChanged: value4Changed,
                        checkColor: Colors.white,
                        activeColor: Colors.amber[400],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Image.asset(
                            "assets/clock.png",
                          ),
                          onPressed: () {
                            selectedTodotime4(context);
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: time4 == null
                              ? Text('')
                              : Text(
                                  '$time4',
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
                        "الإربعاء",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Checkbox(
                        value: value5,
                        onChanged: value5Changed,
                        checkColor: Colors.white,
                        activeColor: Colors.amber[400],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Image.asset(
                            "assets/clock.png",
                          ),
                          onPressed: () {
                            selectedTodotime5(context);
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: time5 == null
                              ? Text('')
                              : Text(
                                  '$time5',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "الخميس",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Checkbox(
                        value: value6,
                        onChanged: value6Changed,
                        checkColor: Colors.white,
                        activeColor: Colors.amber[400],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Image.asset(
                            "assets/clock.png",
                          ),
                          onPressed: () {
                            selectedTodotime6(context);
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: time6 == null
                              ? Text('')
                              : Text(
                                  '$time6',
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
                        "الجمعة",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Checkbox(
                        value: value7,
                        onChanged: value7Changed,
                        checkColor: Colors.white,
                        activeColor: Colors.amber[400],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      FlatButton(
                        child: Text('التالي ',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        onPressed: () {
                          if ((value1 == false) &
                              (value2 == false) &
                              (value3 == false) &
                              (value4 == false) &
                              (value5 == false) &
                              (value6 == false) &
                              (value7 == false)) {
                            return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Row(children: [
                                        SizedBox(width: 169),
                                        Text(
                                          " ! تنبيه",
                                          style: TextStyle(
                                              color: Colors.amber[400]),
                                        ),
                                      ]),
                                      content: Row(
                                        children: [
                                          SizedBox(
                                            width: 37,
                                          ),
                                          Icon(Icons.select_all_sharp),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "يرجى اختيار فئة المواعيد",
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        Row(
                                          children: [
                                            FlatButton(
                                              child: Text(
                                                "موافق",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              textColor: Colors.black,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            SizedBox(
                                              width: 180,
                                            ),
                                          ],
                                        ),
                                      ]);
                                });
                          } else {
                            return Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => StudyHome()));
                          }
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
