import 'package:bassel/views/study/repet.dart';
import 'package:flutter/material.dart';

class StartDate extends StatefulWidget {
  @override
  _StartDateState createState() => _StartDateState();
}

class _StartDateState extends State<StartDate> {
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
                        onPressed: () {}),
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
                        onPressed: () {}),
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
