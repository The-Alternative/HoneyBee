import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../views/study/lactuarappointments1.dart';
import '../../views/study/lactuarappointments2.dart';

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
              textDirection: TextDirection.rtl,
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: 52,
                  width: 52,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'الدراسة',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
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
                    height: 150,
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
                          } else {
                            return Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LactuarAppointments2()));
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