import 'dart:io';
import 'package:HoneyBee/controllers/children/healthController.dart';
import 'package:HoneyBee/controllers/children/mediaController.dart';
import 'package:HoneyBee/models/children/child.dart';
import 'package:HoneyBee/models/children/health.dart';
import 'package:HoneyBee/models/children/media.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class AddHealthNote extends StatefulWidget {
//  final Health health;
  final Child child;
  AddHealthNote(this.child);
  @override
  State<StatefulWidget> createState() {
    return new AddHealthNoteState();
  }

}

class AddHealthNoteState extends State<AddHealthNote>{

  HealthController db = new HealthController();
  MediaController db2 = new MediaController();
  TextEditingController _nameController;
  TextEditingController _noteController;
  TextEditingController _tallController;
  TextEditingController _weightController;
  TextEditingController _tempretureController;
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
    _tallController = new TextEditingController(text:"" );
    _weightController = new TextEditingController(text:"");
    _tempretureController = new TextEditingController(text:"" );
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
//              new Padding(padding: new EdgeInsets.only(left: 30.0)),
              new Image(image: AssetImage("assets/images/111.png"), width: 100.0,),
//              new Padding(padding: new EdgeInsets.only(left: 30.0)),
            ],
          ),
          backgroundColor: Colors.white,
          body: new Container(
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image:AssetImage("assets/images/background.png"), fit: BoxFit.contain,
//              ),
//            ),
//            color: Colors.white12,
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

                            prefixIcon: FlatButton(
                              child: Icon(Icons.attach_file,color: Colors.black,),
                              onPressed: () => _showPicker(context),
                            )
                        ),
                      ),
                    )
                ),
                new Padding(padding: EdgeInsets.only(bottom: 50.0)),
                new Row(
                  children: [
                    new Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.03)),
                    new Column(
                      children: [

                        new Text('الحرارة'),
                        new Padding(padding: EdgeInsets.only(bottom: 15.0)),
                        new Container(
                          width: MediaQuery.of(context).size.width *0.27,
                          child: TextField(
                            controller: _tempretureController,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                                borderSide: BorderSide(width: 0.7,color: Colors.amberAccent),
                              ),
                              hintText: '',
                              hintStyle: TextStyle(fontSize: 16),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                                borderSide: BorderSide(width: 0.7,color: Colors.amberAccent),
                              ),
                              labelStyle: TextStyle(
                                  color: Colors.amberAccent
                              ),

                              contentPadding: EdgeInsets.only(left: 10,right: 10),
                              fillColor: Colors.white70,

                            ),
                          ),
                        )
                      ],
                    ),
                    new Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.06)),
                    new Column(
                      children: [
                        new Text('الوزن'),
                        new Padding(padding: EdgeInsets.only(bottom: 15.0)),
                        new Container(
                          width: MediaQuery.of(context).size.width *0.27,
                          child: TextField(
                            controller: _weightController,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                                borderSide: BorderSide(width: 0.7,color: Colors.amberAccent),
                              ),
                              hintText: '',
                              hintStyle: TextStyle(fontSize: 16),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                                borderSide: BorderSide(width: 0.7,color: Colors.amberAccent),
                              ),
                              labelStyle: TextStyle(
                                  color: Colors.amberAccent
                              ),

                              contentPadding: EdgeInsets.only(left: 10,right: 10),
                              fillColor: Colors.white70,

                            ),
                          ),
                        )
                      ],
                    ),
                    new Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.06)),
                    new Column(
                      children: [
                        new Text('الطول'),
                        new Padding(padding: EdgeInsets.only(bottom: 15.0)),
                        new Container(
                          width: MediaQuery.of(context).size.width *0.27,
                          child: TextField(
                            controller: _tallController,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(0)),
                                  borderSide: BorderSide(width: 0.7,color: Colors.amberAccent),
                                ),
                                hintText: '',
                                hintStyle: TextStyle(fontSize: 16),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(0)),
                                  borderSide: BorderSide(width: 0.7,color: Colors.amberAccent),
                                ),
                                labelStyle: TextStyle(
                                    color: Colors.amberAccent
                                ),

                                contentPadding: EdgeInsets.only(left: 10,right: 10),
                                fillColor: Colors.white70,

                            ),
                          ),
                        ),

                      ],
                    ),
                    new Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.03)),

                  ],
                ),
//                Stack(
//                  children: <Widget>[
//                    Container(
//                      width: double.infinity,
//                      height: 100,
//                      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
//                      padding: EdgeInsets.only(bottom: 10),
//                      decoration: BoxDecoration(
//                        border: Border.all(
//                            color: Color.fromARGB(255, 51, 204, 255), width: 1),
//                        borderRadius: BorderRadius.circular(5),
//                        shape: BoxShape.rectangle,
//                      ),
//                    ),
//                    Positioned(
//                        left: 50,
//                        top: 12,
//                        child: Container(
//                          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
//                          color: Colors.white,
//                          child: Image.asset("assets/images/helth.png")
//                        )),
//                  ],
//                ),
//                TextFormField(
//                  style: TextStyle(fontSize: 20),
//                  decoration: InputDecoration(
//                    hintText: "Last Name",
//                    hintStyle: TextStyle(fontSize: 14),
//                    border: OutlineInputBorder(), // <-- This is the key
//                    labelText: "Last Name",
//                  ),
//                ),
                new Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.1)),
                new Center(
                  child: new Container(
                    width: MediaQuery.of(context).size.width *0.7,
                    child: new Row(
                      children: [
                        new FlatButton(
                          child:new Text('موافق',style: new TextStyle(fontSize: 19.0,color: Colors.black)),
                          onPressed: () async {
                            if(!(_tallController.text == '') && !(_weightController.text== '') && !(_tempretureController.text == '') && !(_nameController.text == '') && !(_noteController.text == '')){
                              if((_tallController.text.length < 4) && (_weightController.text.length < 4) && (_tempretureController.text.length < 3)){
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
                               id = await db.saveHealth(Health(
                                  _nameController.text,
                                  _noteController.text,
                                  int.parse(_tallController.text),
                                  int.parse(_weightController.text),
                                  int.parse(_tempretureController.text),
                                  1,
                                  widget.child.id,
                                  formattedDate));
                               print(imagesPath.length);
                               if(imagesPath.length > 0 ){
                                 for(int i = 0 ; i < imagesPath.length ; i++){
                                   db2.saveMedia(Media(imagesPath[i], 1, id, formattedDate));
                                 }
                               }
                                 Navigator.pop(context,'save');
                            }else{
                              _showMaterialDialog2();
                            }}else{
                              _showMaterialDialog();
                            }



                          },
                        ),
                        new Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width *0.15 )),
                        new FlatButton(
                            onPressed: () => _back(context) ,
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
  void _back(BuildContext context) async{
    Navigator.pop(context);
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
  _showMaterialDialog2() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("يرجى التاكد من قيم الحقول "),
          content: new Text("لا يمكن ان تكون حقول الطول والوزن اكثر من ثلاث خانات وحقل الحرارة اكثر من خانتين"),
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