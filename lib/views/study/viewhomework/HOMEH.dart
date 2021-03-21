import 'package:flutter/material.dart';
import 'package:honeyBee/views/study/viewcourse/home.course.dart';
import 'package:honeyBee/views/study/viewexam/home.exam.dart';
import 'package:honeyBee/views/study/viewhomework/home.homework.dart';

class HomeHomeworkP extends StatefulWidget {
  @override
  _HomeHomeworkPState createState() => _HomeHomeworkPState();
}

class _HomeHomeworkPState extends State<HomeHomeworkP> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Row(children: [
              SizedBox(width: 140),
              Text(
                'الوظائف',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ]),
            backgroundColor: Colors.amber[400],
          ),
          body: HomeWorkhome(),
        ),
      ),
    );
  }
}
