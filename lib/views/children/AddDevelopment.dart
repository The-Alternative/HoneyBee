import 'dart:io';

import 'package:bassel/controllers/children/developmentController.dart';
import 'package:bassel/controllers/children/mediaController.dart';
import 'package:bassel/models/children/child.dart';
import 'package:bassel/models/children/development.dart';
import 'package:bassel/models/children/media.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';



class AddDevelopment extends StatefulWidget {
  final Child child;
  AddDevelopment(this.child);
  @override
  State<StatefulWidget> createState() {
    return new AddDevelopmentState();
  }

}

class AddDevelopmentState extends State<AddDevelopment>{

  DevelopmentController db = new DevelopmentController();
  MediaController db2 = new MediaController();
  TextEditingController _nameController;
  TextEditingController _noteController;
  DateTime now = DateTime. now();
  String formattedDate ;
  List<String> imagesPath = new List();
  File _image;
  int id;
  final picker = ImagePicker();

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController(text: "");
    _noteController = new TextEditingController(text: "");

    formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss").format(now);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new  MaterialApp(
      title: 'Welcome to Flutter',
      home: Container(
        child: Scaffold(
          appBar:new AppBar(title: new Text('',
              style: new TextStyle(color: Colors.black)),
            backgroundColor: Colors.amberAccent,
            actions: [
              new Column(
                children: [
                  new Padding(padding: EdgeInsets.only(bottom: 10.0)),
                  new Text('يوميات الاولاد',style: new TextStyle(color: Colors.black,fontSize: 22.2,fontWeight: FontWeight.bold))
                ],
              ),
              new Image(image: AssetImage("assets/images/111.png"), width: 100.0,),
            ],
          ),
          backgroundColor: Colors.white,
          body: new Container(
            child: new ListView(
              children: [
                new Padding(padding: EdgeInsets.only(bottom: 50.0)),

                new Center(
                    child: new Container(
                      width: MediaQuery.of(context).size.width *0.9,
                      child: new TextField(
                        controller: _nameController,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(width: 1,color: Colors.amberAccent),
                            ),
                            hintText: 'عنوان الملاحظة',
                            hintStyle: TextStyle(fontSize: 16),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(width: 1,color: Colors.amberAccent),
                            ),
                            labelStyle: TextStyle(
                                color: Colors.amberAccent
                            ),

                            contentPadding: EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 10),
                            fillColor: Colors.white70,
                        ),
                      ),
                    )
                ),
                new Padding(padding: EdgeInsets.only(bottom: 50.0)),

                new Center(
                    child: new Container(
                      width: MediaQuery.of(context).size.width *0.9,
                      child: new TextField(
                        controller: _noteController,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(width: 1,color: Colors.amberAccent),
                            ),
                            hintText: 'إضافة ملاحظة',
                            hintStyle: TextStyle(fontSize: 16),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(width: 1,color: Colors.amberAccent),
                            ),
                            labelStyle: TextStyle(
                                color: Colors.amberAccent
                            ),

                            contentPadding: EdgeInsets.only(top: 30,bottom: 30,right: 20,left: 10),
                            fillColor: Colors.white70,

                            prefixIcon:FlatButton(
                              child: Icon(Icons.attach_file,color: Colors.black,),
                              onPressed: () => _showPicker(context),
                            )
                        ),
                      ),
                    )
                ),
                new Padding(padding: EdgeInsets.only(bottom: 50.0)),

                new Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.3)),
                new Center(
                  child: new Container(
                    width: MediaQuery.of(context).size.width *0.7,
                    child: new Row(
                      children: [
                        new FlatButton(
                          child:new Text('موافق',style: new TextStyle(fontSize: 19.0,color: Colors.black)),
                          onPressed: () async {
                            if(!(_nameController.text == '') && !(_noteController.text == '')){
//                            if(widget.health.id != null){
//                              db.updateChild(Health.fromeMap({
//                                'id' : widget.health.id,
//                                'name' : _nameController.text,
//                                'note' : _noteController.text,
//                                'tall' : int.parse(_tallController.text),
//                                'weight' : int.parse(_weightController.text),
//                                'tempreture' : int.parse(_tempretureController.text),
//                              })).then((_) {
//                                Navigator.pop(context,'update');
//                              });
//                            }else{
                           id= await db.saveDevelopment(Development(
                                _nameController.text,
                                _noteController.text,
                                1,
                                1,
                                1,
                                1,
                                widget.child.id,
                                formattedDate));
                            print(imagesPath.length);
                            if(imagesPath.length > 0 ){
                              for(int i = 0 ; i < imagesPath.length ; i++){
                                db2.saveMedia(Media(imagesPath[i], 2, id, formattedDate));
                              }
                            }
                              Navigator.pop(context,'save');

                            }else{
                              _showMaterialDialog();
                            }
                          },
                        ),
                        new Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width *0.15 )),
                        new FlatButton(
                            onPressed: () {Navigator.pop(context);},
                            child: new Text('إلغاء الأمر',style: new TextStyle(fontSize: 19.0,color: Colors.black),)),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
          bottomNavigationBar: new Icon(Icons.home,color: Colors.black12,size: 50.2,),
        ),
      ),
    );
  }
  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("يرجى ملئ كافة الحقول "),
          content: new Text(""),
          actions: <Widget>[
            FlatButton(
              child: Text('حسنا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }
  Future getImageFromCamera() async {

    final pickedFile = await picker.getImage(source: ImageSource.camera);


    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imagesPath.add(pickedFile.path) ;
      } else {
        print('No image selected.');
      }
    });
  }
  Future getImageFromGallery() async {

    final pickedFile = await picker.getImage(source: ImageSource.gallery);


    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imagesPath.add(pickedFile.path) ;
      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  // new Row(
                  //   children: [
                  //     new Expanded(child: Text('')),
                  //     new Container(
                  //
                  //       child: Icon(Icons.camera_alt),
                  //     ),
                  //     new Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.3)),
                  //     new RaisedButton(
                  //       onPressed: () {
                  //         getImageFromCamera();
                  //         Navigator.of(context).pop();
                  //       },
                  //       child: Icon(Icons.photo),
                  //     ),
                  //     new Expanded(child: Text('')),
                  //   ],
                  // ),
                  new ListTile(
                      leading: new Icon(Icons.photo_library,),
                      title: new Text('الاستديو',textAlign: TextAlign.right,),
                      onTap: () {
                        getImageFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.camera_alt),
                    title: new Text('الكاميرا',textAlign: TextAlign.right,),
                    onTap: () {
                      getImageFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}