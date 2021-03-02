import 'package:bassel/services/sign_in.dart';
import 'package:bassel/views/BMI/bmi1.dart';
import 'package:bassel/views/children/Home.dart';
import 'package:bassel/views/init.dart';
import 'package:bassel/views/login_page.dart';
import 'package:bassel/views/study/home.dart';
import 'package:flutter/material.dart';

import 'home.dart';
class HomeWelcom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HoneyBee'),
      ),
      body: Padding(padding: EdgeInsets.all(100.1),
      child: Container(
        child:  Center(
          child: Column(
          children: [
                  ElevatedButton(
                   child: Text('الدراسة'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StudyHome()),
                        );
                      },
                  ),
                ElevatedButton(
                  child: Text('يوميات الاولاد'),
                    onPressed: () {
                      Navigator.push(
                        context,
                         MaterialPageRoute(builder: (context) => ChildrenHome()),
                       );
                    },
                  ),
               ElevatedButton(
                 child: Text('الادوية'),
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DefaultTabController(
                        length: 3, child: MyHomePage(title: 'Flutter  Home Page'),
                      )),
                     );
                    },
                ),
                ElevatedButton(
                 child: Text('BMI'),
                    onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Bmi1()),
                     );
                    },
                ),
            ElevatedButton(
              child: Text('signOut'),
              onPressed: () {
                signOutGoogle();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => App()),
                );
              },
            ),
          ],
       )
    ),)),
    );
  }
}
