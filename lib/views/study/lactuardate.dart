import 'package:bassel/views/study/repet.dart';
import 'package:bassel/views/study/startdate.dart';
import 'package:flutter/material.dart';
import 'package:bassel/views/study/lactuarappointments.dart';

class LactuarDate extends StatefulWidget {
  @override
  _LactuarDateState createState() => _LactuarDateState();
}

class _LactuarDateState extends State<LactuarDate> {
  List<String> alerts = ['ربع ساعة', 'نصف ساعة', 'ساعة'];
  String selectedalerts = 'ساعة';

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
                          "assets/presentation.png",
                          scale: 4.5,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'برنامج المحاضرات',
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
                    ),
                    SizedBox(
                      height: 37,
                    ),
                    Row(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.amber[400], width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              image: DecorationImage(
                                image: AssetImage("assets/Ocloc.png"),
                                scale: 2.0,
                              ),
                            ),
                            child: FlatButton(
                              child: null,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Repeted()));
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 37,
                        ),
                        ClipOval(
                          child: Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.amber[400], width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              image: DecorationImage(
                                image: AssetImage("assets/date.png"),
                                scale: 2.0,
                              ),
                            ),
                            child: FlatButton(
                              child: null,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => StartDate()));
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 37,
                        ),
                        ClipOval(
                          child: Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.amber[400], width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              image: DecorationImage(
                                image: AssetImage("assets/calendar(1).png"),
                                scale: 2.2,
                              ),
                            ),
                            child: FlatButton(
                              child: null,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        LactuarAppointments()));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'التكرار',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 64,
                        ),
                        Text(
                          'تاريخ البدء',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 56,
                        ),
                        Text(
                          'المواعيد',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 37,
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
                      height: 30,
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
                          onPressed: () {},
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
