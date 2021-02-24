import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';

class ImportEvent extends StatefulWidget {
  @override
  _ImportEventState createState() => _ImportEventState();
}

class _ImportEventState extends State<ImportEvent> {
  var _formKey = GlobalKey<FormState>();
  var formKey = GlobalKey<FormState>();
  //
  // DiaryController db = new DiaryController();

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController _addressController;
  TextEditingController _descriptionController ;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _addressController = new TextEditingController(text: "");
    _descriptionController = new TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
        Directionality(textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Expanded(flex: 2,child:  Text("انشاء منشور",style: TextStyle(color: Colors.black),)),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                    Expanded(flex: 1,child:
                    FlatButton(
                        child: Text("انشاء",style: TextStyle(color: Colors.white,fontSize: 20),),
                        color: Colors.green,
                        onPressed: () async{
                          final isValid = _formKey.currentState.validate();
                          if (!isValid) {
                            return;
                          }
                          _formKey.currentState.save();
                          formKey.currentState.save();
                        }
                    ),)
                  ],
                ),
              ),
              body: Padding(
                padding: EdgeInsets.all(0),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Container(
                          height:30,
                          width: 30,
                          // margin: EdgeInsets.all(5),
                          margin: EdgeInsets.only(top: 20,right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [BoxShadow(color: Colors.amber,blurRadius: 2,spreadRadius: 1)],
                            // image: DecorationImage(
                            //   image: AssetImage(""),
                            //   scale: 2.0,
                            // ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20,right: 10),
                            child: Text("أحداث هامة")),
                      ],
                    ),

                    Row(
                      children: [
                        Form(
                          key: _formKey,
                          child:
                          Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,

                              //  margin: EdgeInsets.only(top: 20,right: 10),
                              child: TextFormField(
                                cursorColor: Colors.green,
                                controller:_addressController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'أدخل العنوان';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(right: 10),
                                  hintText: "العنوان",
                                  hintStyle: TextStyle(color: Colors.black45),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),

                                ),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Form(
                          key: formKey,
                          child: Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              // margin: EdgeInsets.only(top: 20,right: 10),
                              child: TextFormField(
                                maxLength: 255,
                                cursorColor: Colors.green,
                                controller:_descriptionController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'أدخل نص';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(right: 10),
                                  hintText: " بم تفكر ؟",
                                  hintStyle: TextStyle(color: Colors.black45),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),

                                ),
                              )),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top:10),
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child:
                          CircleAvatar(
                            backgroundImage: _imageFile == null
                                ? null
                                : FileImage(File(_imageFile.path)),

                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),


                    Card(
                      child: FlatButton(
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt_outlined),
                            SizedBox(width: 20,),
                            Text("التقاط صورة"),
                          ],
                        ),
                        onPressed: (){
                          takePhoto(ImageSource.camera);
                        },
                      ),
                    ),




                    Card(
                      child: FlatButton(
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt_outlined),
                            SizedBox(width: 20,),
                            Text("تحميل صور"),
                          ],
                        ),
                        onPressed: (){
                          takePhoto(ImageSource.gallery);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: new Icon(Icons.home,color: Colors.black12,size: 50.2,),
            )
        )
    );

  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
