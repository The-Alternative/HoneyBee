import 'package:bassel/controllers/study/coursecontroller.dart';
import 'package:bassel/models/study/course.dart';
import 'package:bassel/views/study/viewcourse/listcourse.dart';
import 'package:flutter/material.dart';

class HomeCourse extends StatefulWidget {
  @override
  _HomeCourseState createState() => _HomeCourseState();
}

class _HomeCourseState extends State<HomeCourse> {
  CourseController _courseController = CourseController();
  List<Course> courselist = List<Course>();
  @override
  void initState() {
    super.initState();
    setState(() {
      setData();
    });
  }

  Future setData() async {
    courselist.clear();
    (await _courseController.getInfo('courses')).forEach((medMap) {
      setState(() {
        courselist.add(Course().courseMapToObject(medMap));
      });
      print('mosa${courselist.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: courselist.isEmpty
            ? Text('no course')
            : ListCourse(courselist, setData));
  }
}
