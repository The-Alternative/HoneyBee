import 'dart:io';
import 'dart:ui';
import 'package:HoneyBee/controllers/study/coursecontroller.dart';
import 'package:HoneyBee/models/study/course.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class Newcourse extends StatefulWidget {
  @override
  _NewcourseState createState() => _NewcourseState();
}

class _NewcourseState extends State<Newcourse> {
  String namecourse, nameteachar, email, image;
  String teacharnumber;

  CourseController helper = new CourseController();

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: 60,
            toolbarHeight: 65,
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
                SizedBox(),
              ],
            ),
            backgroundColor: Colors.amber[400],
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/center.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: imageProfile(),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        cursorColor: Colors.amber[400],
                        cursorHeight: 25,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'اسم المقرر',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber[400])),
                        ),
                        onChanged: (value) {
                          setState(() {
                            namecourse = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        cursorColor: Colors.amber[400],
                        cursorHeight: 25,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.amber[400]),
                          hintText: 'اسم المدرس',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber[400])),
                        ),
                        onChanged: (value) {
                          setState(() {
                            nameteachar = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        cursorColor: Colors.amber[400],
                        textAlign: TextAlign.right,
                        cursorHeight: 2,
                        decoration: InputDecoration(
                          hintText: 'البريد الألكتروني',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber[400])),
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.amber[400],
                        textAlign: TextAlign.right,
                        cursorHeight: 25,
                        decoration: InputDecoration(
                          hintText: 'رقم الموبايل',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber[400])),
                        ),
                        onChanged: (value) {
                          setState(() {
                            teacharnumber = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Center(
                          child: Row(
                            children: [
                              FlatButton(
                                child: Text(
                                  'اضافة',
                                  style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                onPressed: () {
                                  Course course = Course(
                                    namecourse: 'namecourse',
                                    nameteachar: 'nameteachar',
                                    email: 'email',
                                    teacharnumber: 'teacharnumber',
                                  );
                                  helper.saveCourse(course);
                                  print(course);
                                  Navigator.of(context).pop();
                                },
                              ),
                              SizedBox(
                                width: 80,
                              ),
                              FlatButton(
                                child: Text('إلغاء الأمر',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundImage: _imageFile == null
                ? AssetImage("assets/uplode.png")
                : FileImage(File(_imageFile.path)),
            radius: 80.0,
            backgroundColor: Colors.grey[350],
          ),
          Positioned(
              bottom: 10.0,
              right: 15.0,
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet()),
                    );
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 35,
                  )))
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text("اختر صورة للمقرر",
              style: TextStyle(
                fontSize: 18.0,
              )),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("التقاط صورة"),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("معرض الصور"),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }
}