import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bassel/views/study/lactuarappointments1.dart';
import 'package:bassel/views/study/lactuarappointments2.dart';

class LactuarAppointments extends StatefulWidget {
  @override
  _LactuarAppointmentsState createState() => _LactuarAppointmentsState();
}

class _LactuarAppointmentsState extends State<LactuarAppointments> {
  int val;
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
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 97,
                      ),
                      Text(
                        "أيام محددة بالأسبوع",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Radio(
                        activeColor: Colors.amber[400],
                        value: 1,
                        groupValue: val,
                        onChanged: (newvalue) {
                          setState(() {
                            val = newvalue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 152,
                      ),
                      Text(
                        "إدخال يدوي",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 28,
                      ),
                      Radio(
                        activeColor: Colors.amber[400],
                        value: 2,
                        groupValue: val,
                        onChanged: (newvalue) {
                          setState(() {
                            val = newvalue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 225,
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
                          if (val == 1) {
                            return Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LactuarAppointments1()));
                          }
                          if (val == 2) {
                            return Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LactuarAppointments2()));
                          } else {
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
