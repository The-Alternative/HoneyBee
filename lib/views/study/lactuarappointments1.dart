import 'package:bassel/views/medicine/ViewMedecineRecord/home.dart';
import 'package:bassel/views/study/home.dart';
import 'package:flutter/material.dart';

class LactuarAppointments1 extends StatefulWidget {
  @override
  _LactuarAppointments1State createState() => _LactuarAppointments1State();
}

class _LactuarAppointments1State extends State<LactuarAppointments1> {
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
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "الساعة",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 33,
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
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "الساعة",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Text(
                        "الأحد",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 4,
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
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "الساعة",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "الإثنين",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 4,
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
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "الساعة",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 26,
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
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "الساعة",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 24,
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
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "الساعة",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 20,
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
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "الساعة",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 24,
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
