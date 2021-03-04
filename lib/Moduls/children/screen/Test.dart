////import 'dart:io';
////
////import 'package:flutter/material.dart';
////import 'package:image_picker/image_picker.dart';
////
////
////
////class MyApp extends StatelessWidget {
////  @override
////  Widget build(BuildContext context) {
////    return MaterialApp(
////      home: MyHomePage(),
////    );
////  }
////}
////
////class MyHomePage extends StatefulWidget {
////  @override
////  _MyHomePageState createState() => _MyHomePageState();
////}
////
////class _MyHomePageState extends State<MyHomePage> {
////  File _image;
////  final picker = ImagePicker();
////
////  Future getImage() async {
////    final pickedFile = await picker.getImage(source: ImageSource.camera);
////
////    setState(() {
////      if (pickedFile != null) {
////        _image = File(pickedFile.path);
////      } else {
////        print('No image selected.');
////      }
////    });
////  }
////
////  @override
////  Widget build(BuildContext context) {
////    return Scaffold(
////      appBar: AppBar(
////        title: Text('Image Picker Example'),
////      ),
////      body: Center(
////        child: _image == null
////            ? Text('No image selected.')
////            : Image.file(_image),
////      ),
////      floatingActionButton: FloatingActionButton(
////        onPressed: getImage,
////        tooltip: 'Pick Image',
////        child: Icon(Icons.add_a_photo),
////      ),
////    );
////  }
////}
//
//import 'package:childrensdiary/controllers/childController.dart';
//import 'package:childrensdiary/views/Home.dart';
////import 'package:childrensdiary/models/child.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//
//
//
//class AddChild extends StatefulWidget {
//  final String childName;
//  final String childSex;
//  final String childBirth;
//  final String childImage;
//  final int childId;
//  AddChild(this.childId,this.childName,this.childSex,this.childBirth,this.childImage);
//  @override
//  State<StatefulWidget> createState() {
//    return new AddChildState();
//  }
//
//}
//
//class AddChildState extends State<AddChild>{
//  DateTime _selectedDate;
//  ChildController db = new ChildController();
//  TextEditingController _nameController;
//  TextEditingController _sexController;
//  TextEditingController _birthDateController;
//  TextEditingController _imageController;
//  var map =new Map<String,dynamic>();
//
//
//  @override
//  void initState(){
//    // TODO: implement initState
//    super.initState();
//    _nameController = new TextEditingController(text: widget.childName);
//    _sexController = new TextEditingController(text: widget.childSex);
//    _birthDateController = new TextEditingController(text:"${widget.childBirth}" );
//    _imageController = new TextEditingController(text: widget.childImage);
//
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new  MaterialApp(
//      title: 'Welcome to Flutter',
//      home: Container(
//        child: Scaffold(
//          appBar:new AppBar(title: new Text('',
//              style: new TextStyle(color: Colors.black)),
//            backgroundColor: Colors.amberAccent,
//            actions: [
//              new Column(
//                children: [
//                  new Padding(padding: EdgeInsets.only(bottom: 10.0)),
//                  new Text('يوميات الاولاد',style: new TextStyle(color: Colors.black,fontSize: 22.2,fontWeight: FontWeight.bold))
//                ],
//              ),
//              new Image(image: AssetImage("assets/images/111.png"), width: 100.0,),
//            ],
//          ),
//          backgroundColor: Colors.white,
//          body: new Container(
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image:AssetImage("assets/images/background.png"), fit: BoxFit.contain,
//              ),
//            ),
//            child: new ListView(
//              children: [
//                new Padding(padding: EdgeInsets.only(bottom: 50.0)),
//                new MaterialButton(
//                  onPressed: () {},
//                  color: Colors.white,
//                  textColor: Colors.grey,
//                  child: new Text('تحميل صورة'),
//                  padding: EdgeInsets.all(50),
//                  shape: CircleBorder(side: BorderSide(
//                      color: Colors.amberAccent
//                  )),
//                  splashColor: Colors.amberAccent,
//                  highlightColor: Colors.amberAccent,
//
//                ),
//                new Center(
//                    child: new Container(
//                      width: MediaQuery.of(context).size.width *0.9,
//                      child: new TextField(
//                        controller: _nameController,
//                        textAlign: TextAlign.right,
//
//                        style: TextStyle(fontSize: 18.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
//                        decoration: InputDecoration(
//                          labelStyle: new TextStyle(
//                              color: Colors.amberAccent
//                          ),
//                          focusedBorder:UnderlineInputBorder(
//                            borderSide: const BorderSide(color: Colors.amberAccent, width: 1.0),
//                          ),
//                          enabledBorder: UnderlineInputBorder(
//                            borderSide: BorderSide(
//                                color: Colors.amberAccent),
//                          ),
//                          hintText: 'الاسم',
//                          hintStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
//                        ),
//                      ),
//                    )
//                ),
//                new Center(
//                    child: new Container(
//                      width: MediaQuery.of(context).size.width *0.9,
//                      child: new TextField(
//                        controller: _sexController,
//                        textAlign: TextAlign.right,
//                        readOnly: true,
//                        style: TextStyle(fontSize: 18.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
//                        decoration: InputDecoration(
//                          labelStyle: new TextStyle(
//                              color: Colors.amberAccent
//                          ),
//                          focusedBorder:UnderlineInputBorder(
//                            borderSide: const BorderSide(color: Colors.amberAccent, width: 1.0),
//                          ),
//                          enabledBorder: UnderlineInputBorder(
//                            borderSide: BorderSide(
//                                color: Colors.amberAccent),
//                          ),
//                          hintText: 'الجنس',
//                          hintStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
//                          prefixIcon: new DropdownButton<String>(
//                            underline: Container(
//                              decoration: const BoxDecoration(
//                                  border: Border(bottom: BorderSide(color: Colors.transparent))
//                              ),
//                            ),
//                            icon: new Icon(Icons.keyboard_arrow_down),
//                            items: <String>['ذكر', 'انثى',].map((String value) {
//                              return new DropdownMenuItem<String>(
//                                value: value,
//                                child: new Text(value),
//                              );
//                            }).toList(),
//                            onChanged: (String newValue) {
//                              setState(() {
//                                _sexController.text = newValue;
//                              });
//                            },
//                          ),
//                        ),
//                      ),
//                    )
//                ),
//                new Center(
//                    child: new Container(
//                      width: MediaQuery.of(context).size.width *0.9,
//                      child: new TextField(
//                        focusNode: AlwaysDisabledFocusNode(),
//                        controller: _birthDateController,
//                        onTap: () {
//                          _selectDate(context);
//                        },
//                        textAlign: TextAlign.right,
//                        keyboardType: TextInputType.datetime ,
//                        style: TextStyle(fontSize: 18.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
//                        decoration: InputDecoration(
//                          labelStyle: new TextStyle(
//                              color: Colors.amberAccent
//                          ),
//                          focusedBorder:UnderlineInputBorder(
//                            borderSide: const BorderSide(color: Colors.amberAccent, width: 1.0),
//                          ),
//                          enabledBorder: UnderlineInputBorder(
//                            borderSide: BorderSide(
//                                color: Colors.amberAccent),
//                          ),
//                          hintText: 'تاريخ الميلاد',
//                          hintStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
//                        ),
//                      ),
//                    )
//                ),
//                new Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.1)),
//                new Center(
//                  child: new Container(
//                    width: MediaQuery.of(context).size.width *0.7,
//                    child: new Row(
//                      children: [
//                        new FlatButton(
//                          child:(widget.childId != null) ? new Text('تعديل',style:  TextStyle(fontSize: 19.0,color: Colors.black)):  Text('موافق',style: new TextStyle(fontSize: 19.0,color: Colors.black)),
//                          onPressed: (){
//                            if(!(_nameController.text == '') && !(_birthDateController.text == '') && !(_sexController.text == '')){
//                              map['name'] = _nameController.text;
//                              map['sex'] = _sexController.text;
//                              map['birthDate'] = _birthDateController.text;
//                              map['image'] = "ssss";
//                              map['isActive'] = 1;
//                              if(widget.childId != null){
//                                map['id'] = widget.childId;
//                              }
//
//                              if(widget.childId != null){
//                                db.updateChild(map).then((_) {
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(builder: (context) => Home()));;
//                                });
//                              }else{
//                                db.saveChild(map).then((_) {
//                                  Navigator.pop(context,'save');
//                                });
//                              }}else{
//                              _showMaterialDialog();
//                            }
//                          },
//                        ),
//                        new Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width *0.15 )),
//                        new FlatButton(
//                            onPressed: () => _back(context) ,
//                            child: new Text('إلغاء الأمر',style: new TextStyle(fontSize: 19.0,color: Colors.black),)),
//                      ],
//                    ),
//                  ),
//                )
//
//              ],
//            ),
//          ),
//          bottomNavigationBar: new Icon(Icons.home,color: Colors.black12,size: 50.2,),
//        ),
//      ),
//    );
//  }
//
//  void _back(BuildContext context) async{
//    Navigator.pop(context);
//  }
//  _selectDate(BuildContext context) async {
//    DateTime newSelectedDate = await showDatePicker(
//        context: context,
//        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
//        firstDate: DateTime(2000),
//        lastDate: DateTime(2040),
//        builder: (BuildContext context, Widget child) {
//          return Theme(
//            data: ThemeData.dark().copyWith(
//              colorScheme: ColorScheme.dark(
//                primary: Colors.white,
//                onPrimary: Colors.deepOrange,
//                surface: Colors.grey,
//                onSurface: Colors.white,
//              ),
//              dialogBackgroundColor: Colors.amberAccent,
//            ),
//            child: child,
//          );
//        });
//
//    if (newSelectedDate != null) {
//      _selectedDate = newSelectedDate;
//      _birthDateController
//        ..text = DateFormat("yyyy-MM-dd hh:mm:ss").format(_selectedDate)
//        ..selection = TextSelection.fromPosition(TextPosition(
//            offset: _birthDateController.text.length,
//            affinity: TextAffinity.upstream));
//
//    }
//  }
//
//  _showMaterialDialog() {
//    showDialog(
//        context: context,
//        builder: (_) => new AlertDialog(
//          title: new Text("يرجى ملئ كافة الحقول "),
//          content: new Text(""),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('حسنا'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            )
//          ],
//        ));
//  }
//}
//class AlwaysDisabledFocusNode extends FocusNode {
//  @override
//  bool get hasFocus => false;
//}
