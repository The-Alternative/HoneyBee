import '../../controller/coursecontroller.dart';
import '../../model/course.dart';

import 'package:flutter/material.dart';
import '../../screen/viewcourse/listcourse.dart';

class HomeCourse extends StatefulWidget {
  @override
  _HomeCourseState createState() => _HomeCourseState();
}

class _HomeCourseState extends State<HomeCourse> {
  CourseController _courseController =new CourseController();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          courselist.isEmpty
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
              : ListCourse(courselist, setData),
        ],
      ),
    );
  }
}
