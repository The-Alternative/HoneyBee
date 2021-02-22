import 'package:bassel/controllers/children/childController.dart';
import 'package:bassel/models/children/child.dart';
import 'package:bassel/views/children/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class AddChild extends StatefulWidget {
  final Child child;
  AddChild(this.child);
  @override
  State<StatefulWidget> createState() {
    return new AddChildState();
  }

}

class AddChildState extends State<AddChild>{
  DateTime _selectedDate;
  ChildController db = new ChildController();
  TextEditingController _nameController;
  TextEditingController _sexController;
  TextEditingController _birthDateController;
  String _imagePath;
   File _image;
   final picker = ImagePicker();


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController(text: widget.child.name);
    _sexController = new TextEditingController(text: widget.child.sex);
    _birthDateController = new TextEditingController(text:"${widget.child.birthDate}" );
    _imagePath = widget.child.image;
    _image = File(_imagePath);
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image:AssetImage("assets/images/background.png"), fit: BoxFit.contain,
              ),
            ),
            child: new ListView(
              children: [
                new Padding(padding: EdgeInsets.only(bottom: 50.0)),
                new MaterialButton(
                  onPressed:() => _showPicker(context),
                  color: Colors.white,
                  textColor: Colors.grey,
                  child:_imagePath == ''
                     ? Text('تحميل صورة')
                     : ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child:Image.file(_image,width: 150,height: 150,) ,
                  ),
                  // Image.file(_image,width: 100,height: 100,),

                  padding: _imagePath == '' ? EdgeInsets.all(50):EdgeInsets.all(0),
                  shape:  CircleBorder(side: BorderSide(
                      color: Colors.amberAccent
                  )),
                  splashColor: Colors.amberAccent,
                  highlightColor: Colors.amberAccent,

                ),
                new Center(
                    child: new Container(
                      width: MediaQuery.of(context).size.width *0.9,
                      child: new TextField(
                        controller: _nameController,
                        textAlign: TextAlign.right,

                        style: TextStyle(fontSize: 18.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                        decoration: InputDecoration(
                          labelStyle: new TextStyle(
                              color: Colors.amberAccent
                          ),
                          focusedBorder:UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.amberAccent, width: 1.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.amberAccent),
                          ),
                          hintText: 'الاسم',
                          hintStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                ),
                new Center(
                    child: new Container(
                      width: MediaQuery.of(context).size.width *0.9,
                      child: new TextField(
                        controller: _sexController,
                        textAlign: TextAlign.right,
                        readOnly: true,
                        style: TextStyle(fontSize: 18.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                        decoration: InputDecoration(
                          labelStyle: new TextStyle(
                              color: Colors.amberAccent
                          ),
                          focusedBorder:UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.amberAccent, width: 1.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.amberAccent),
                          ),
                          hintText: 'الجنس',
                          hintStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
                          prefixIcon: new DropdownButton<String>(
                            underline: Container(
                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.transparent))
                              ),
                            ),
                            icon: new Icon(Icons.keyboard_arrow_down),
                            items: <String>['ذكر', 'انثى',].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                _sexController.text = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    )
                ),
                new Center(
                    child: new Container(
                      width: MediaQuery.of(context).size.width *0.9,
                      child: new TextField(
                        focusNode: AlwaysDisabledFocusNode(),
                        controller: _birthDateController,
                        onTap: () {
                          _selectDate(context);
                        },
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.datetime ,
                        style: TextStyle(fontSize: 18.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                        decoration: InputDecoration(
                          labelStyle: new TextStyle(
                              color: Colors.amberAccent
                          ),
                          focusedBorder:UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.amberAccent, width: 1.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.amberAccent),
                          ),
                          hintText: 'تاريخ الميلاد',
                          hintStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                ),
                new Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.1)),
                new Center(
                  child: new Container(
                    width: MediaQuery.of(context).size.width *0.7,
                    child: new Row(
                      children: [
                        new FlatButton(
                          child:(widget.child.id != null) ? new Text('تعديل',style:  TextStyle(fontSize: 19.0,color: Colors.black)):  Text('موافق',style: new TextStyle(fontSize: 19.0,color: Colors.black)),
                          onPressed: (){
                            if(!(_nameController.text == '') && !(_birthDateController.text == '') && !(_sexController.text == '')){
                              if(widget.child.id != null){
                                print("111111");
                                db.updateChild(Child.fromeMap({
                                  'id' : widget.child.id,
                                  'name' : _nameController.text,
                                  'sex' : _sexController.text,
                                  'birthDate' : _birthDateController.text,
                                  'image' : _imagePath,
                                  'isActive' : 1,
                                })).then((_) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ChildrenHome()));
                                });
                              }else{
                                db.saveChild(Child(
                                    _nameController.text,
                                    _sexController.text,
                                    _birthDateController.text,
                                    _imagePath,
                                    1)).then((_) {
                                  Navigator.pop(context,'save');
                                });
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
  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.white,
                onPrimary: Colors.deepOrange,
                surface: Colors.grey,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.amberAccent,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _birthDateController
        ..text = DateFormat("yyyy-MM-dd hh:mm:ss").format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _birthDateController.text.length,
            affinity: TextAffinity.upstream));

    }
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
       _imagePath = pickedFile.path;
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
        _imagePath = pickedFile.path;
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
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}