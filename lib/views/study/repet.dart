import 'package:flutter/material.dart';

class Repeted extends StatefulWidget {
  @override
  _Repeted createState() => _Repeted();
}

class _Repeted extends State<Repeted> {
  List<String> repeted = ['شهر', 'اسبوع', 'يوم'];
  String selectedrepeted = 'يوم';

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
                      "assets/repeted.png",
                      scale: 5.0,
                    ),
                    SizedBox(
                      width: 178,
                    ),
                    Text(
                      'التكرار',
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
                    Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.amber[400], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: DropdownButton(
                          iconSize: 30,
                          isExpanded: true,
                          underline: SizedBox(),
                          items: repeted.map((repeted) {
                            return DropdownMenuItem(
                              value: repeted,
                              child: Center(
                                child: Text(repeted),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedrepeted = value;
                            });
                          },
                          value: selectedrepeted,
                        )),
                    SizedBox(
                      width: 33,
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.amber[400], width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 286,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    FlatButton(
                      child: Text(' التالي',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      onPressed: () {},
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
