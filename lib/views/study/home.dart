import '../../Controller/study/coursecontroller.dart';
import '../../models/study/course.dart';
import '../../views/study/assignments.dart';
import '../../views/study/newcourse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class StudyHome extends StatefulWidget {
  @override
  _StudyHomeState createState() => _StudyHomeState();
}

class _StudyHomeState extends State<StudyHome> {
  CourseController helper = new CourseController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: 60,
              toolbarHeight: 120,
              title: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    height: 52,
                    width: 52,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'الدراسة',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.amber[400],
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Text('مقررات',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        )),
                  ),
                  Tab(
                    child: Text(
                      'مواعيد ومهام',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                FutureBuilder(
                  future: helper.getAllcourse(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Image(
                          width: 280,
                          height: 280,
                          image: AssetImage(
                            "assets/center.png",
                          ),
                          alignment: Alignment.center,
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              Course course = Course.fromMap(snapshot.data[i]);
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  title: Text(course.namecourse),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        helper.deleteCourse(course);
                                      });
                                    },
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  },
                ),
                new Center(
                  child: Image(
                    width: 280,
                    height: 280,
                    image: AssetImage(
                      "assets/center.png",
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
            floatingActionButton: SpeedDial(
              animatedIcon: AnimatedIcons.add_event,
              backgroundColor: Colors.amber[400],
              overlayColor: Colors.black,
              overlayOpacity: 0.0,
              animatedIconTheme: IconThemeData.fallback(),
              marginBottom: 25,
              shape: CircleBorder(),

              children: [
                SpeedDialChild(
                  child: Icon(
                    Icons.auto_stories,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.amber[400],
                  label: "اضافة مقرر",
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Newcourse())),
                ),
                SpeedDialChild(
                  child: Icon(
                    Icons.article,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.amber[400],
                  label: " اضافة موعد أو مهمة",
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Assignments())),
                ),
              ], // This trailing
            ),
          ),
        ),
      ),
    );
  }
}