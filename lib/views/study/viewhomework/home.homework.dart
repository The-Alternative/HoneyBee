import 'package:flutter/material.dart';
import 'package:honeyBee/controllers/study/homeworkcontroller.dart';
import 'package:honeyBee/models/study/exam.dart';
import 'package:honeyBee/models/study/homework.dart';

import 'package:honeyBee/views/study/viewexam/listexam.dart';
import 'package:honeyBee/views/study/viewhomework/listhomework.dart';

class HomeWorkhome extends StatefulWidget {
  @override
  _HomeWorkhomeState createState() => _HomeWorkhomeState();
}

class _HomeWorkhomeState extends State<HomeWorkhome> {
  HomeWorkController _homeworkontroller = HomeWorkController();
  List<HomeWork> homeworklist = List<HomeWork>();
  @override
  void initState() {
    super.initState();
    setState(() {
      setData();
    });
  }

  Future setData() async {
    homeworklist.clear();
    (await _homeworkontroller.getInfo('homeworks')).forEach((medMap) {
      setState(() {
        homeworklist.add(HomeWork().courseMapToObject(medMap));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          homeworklist.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(width: 43),
                      SizedBox(height: 127),
                      Image(
                        width: 280,
                        height: 280,
                        image: AssetImage(
                          "assets/center.png",
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                )
              : ListHomeWork(homeworklist, setData),
        ],
      ),
    );
  }
}
