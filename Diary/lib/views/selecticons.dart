import 'package:diary/views/instructions.dart';

import '../models/diary.dart';
import '../views/diaries.dart';
import '../views/importevent.dart';

import '../views/mistmade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SelectIcons extends StatefulWidget {
  @override
  _SelectIconsState createState() => _SelectIconsState();
}

class _SelectIconsState extends State<SelectIcons> {
  bool result =false;
  var style1 =
  TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Times');
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: Row(
              children: [
                Text("مذكرات",style: TextStyle(color: Colors.black),),
              ],
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: 90),
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: ListView(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox.fromSize(
                          size: Size(75, 75), // button width and height
                          child: ClipOval(
                            child: Material(
                              color: Colors.black12, // button color
                              child: InkWell(
                                splashColor: Colors.green, // splash color
                                onTap: () async {
                                  bool result = await Navigator.push(this.context,
                                      MaterialPageRoute(builder: (context) {
                                        return Diaries(Diary(),'edit');
                                      }));
                                  if (result == true) {
                                    print('mmm');

                                    Navigator.pop(context,true);

                                  }
                                }, // button pressed
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      "assests/diary.png",
                                      width: 50,
                                      height: 50,
                                    ), // text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox.fromSize(
                          size: Size(75, 75), // button width and height
                          child: ClipOval(
                            child: Material(
                              color: Colors.black12, // button color
                              child: InkWell(
                                  splashColor: Colors.green, // splash color
                                  onTap: () async {
                                    bool result = await Navigator.push(this.context,
                                        MaterialPageRoute(builder: (context) {
                                          return Instruction();
                                        }));
                                    if (result == true) {
                                      Navigator.pop(context,true);
                                    }
                                  },child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "assests/diary.png",
                                    width: 50,
                                    height: 50,
                                  ), // icon

                                ],
                              ) // button pressed
                              ),
                            ),
                          ),
                        ),
                        SizedBox.fromSize(
                          size: Size(75, 75), // button width and height
                          child: ClipOval(
                            child: Material(
                              color: Colors.black12, // button color
                              child: InkWell(
                                splashColor: Colors.green, // splash color
                                onTap: () async {
                                  bool result = await Navigator.push(this.context,
                                      MaterialPageRoute(builder: (context) {
                                        return MistMade(Diary(),'edit');
                                      }));
                                  if (result == true) {
                                    Navigator.pop(context,true);
                                  }
                                }, // button pressed
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      "assests/diary.png",
                                      width: 50,
                                      height: 50,
                                    ), // icon
                                    // text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                  Container(
                    margin: EdgeInsets.only(top: 10,right: 50,left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("يوميات",style: style1,),
                        Text("أحداث هامة",style: style1,),
                        Text("أخطاء ارتكبتها",style: style1),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          bottomNavigationBar: new Icon(Icons.home,color: Colors.black12,size: 50.2,),

        ),),);
  }
  void fail_moveToLastScreen(BuildContext context1) {
    Navigator.pop(context1, false);
  }
}