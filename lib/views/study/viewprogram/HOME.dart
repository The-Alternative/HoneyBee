import 'package:flutter/material.dart';
import 'package:honeyBee/views/study/viewprogram/home.program.dart';

class HomeProgram extends StatefulWidget {
  @override
  _HomeProgramState createState() => _HomeProgramState();
}

class _HomeProgramState extends State<HomeProgram> {
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
                'برنامج الدراسة',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ]),
            backgroundColor: Colors.amber[400],
          ),
          body: HomePrgramp(),
        ),
      ),
    );
  }
}
