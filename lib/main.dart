
import 'package:flutter/material.dart';
import 'package:multi_image_picker_example/models/diary.dart';
import 'package:multi_image_picker_example/views/addmemior.dart';

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