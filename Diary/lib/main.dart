
import 'package:diary/models/diary.dart';
import 'package:diary/views/addmemior.dart';
import 'package:flutter/material.dart';



void main(){
  runApp(MyApp(),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(Diary()),
    );

  }
}