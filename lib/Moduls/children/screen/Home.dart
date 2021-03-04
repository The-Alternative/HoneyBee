import 'dart:io';

import 'AddChild.dart';
import '../controller/childController.dart';
import '../model/child.dart';
import 'ChildInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';






class ChildrenHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ChildrenHomeState();
  }

}

class ChildrenHomeState extends State<ChildrenHome>{
  TextEditingController _nameController;
  List<Child> children =new List();
  Child list ;
  ChildController db = new ChildController();
  List<String> childrenNames = [];
  List<String> childrenImages = [];
  bool isNameCorrect ;
  String imagePath = '';


  @override
  void initState() {
  //  TODO: implement initState
    super.initState();
    _nameController = new TextEditingController(text: "");
    db.getAllChild().then((allChildren) {
      setState(() {
        allChildren.forEach((child) {
          children.add(Child.fromeMap(child));
        });
      });
      for(int i =0 ; i < children.length; i++){
        childrenImages.add(children[i].image);
        childrenNames.add(children[i].name);
      }
    });
    isNameCorrect = false;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new  MaterialApp(
      title: 'Welcome to Flutter',
      home: Container(
//        decoration: BoxDecoration(
//          color: Colors.black,
//          image: DecorationImage(
//              image:AssetImage("assets/images/222.png"), fit: BoxFit.cover,
//          ),
//        ),

        child: Scaffold(
          appBar:new AppBar(title: new Text('',textDirection: TextDirection.rtl,
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image:AssetImage("assets/images/background.png"), fit: BoxFit.contain,
              ),
            ),
//            color: Colors.white12,
            child:Column(
              children: [
                new Padding(padding: EdgeInsets.only(bottom: 50.0)),
                new Center(
                    child: new Container(
                      width: MediaQuery.of(context).size.width *0.7,
                      child: new TextField(
                        onSubmitted: (value) => _childInfo(context),
                        textAlign: TextAlign.right,
                        controller: _nameController,
                        style: TextStyle(fontSize: 18.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                        decoration: InputDecoration(
                          labelStyle: new TextStyle(
                            color: Colors.amberAccent,

                          ),
                          focusedBorder:UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.amberAccent, width: 1.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.amberAccent),
                          ),
                          prefixIcon: new DropdownButton<String>(
                            underline: Container(
                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.transparent))
                              ),
                            ),
                            icon: new Icon(Icons.keyboard_arrow_down),
                            items: childrenImages.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child:Image.file(File(value),width: 50,height: 50,) ,
                                ),
                              );
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                imagePath = newValue;
                                _getChildName(context,imagePath);
                              });
                            },
                          ),
                          hintText: 'الاسم',
                          hintStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
                          hoverColor: Colors.amberAccent,
                          focusColor: Colors.amberAccent,
                        ),
//                        onSubmitted: (value) =>  Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => ChildInfo(children[0]))) ,
                      ),
                    )
                ),



              ],
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed:() => _creatNewChild(context),
            tooltip: 'إضافة',

            child: new Icon(Icons.add,size: 50.0,),
            backgroundColor: Colors.greenAccent,
          ),
          bottomNavigationBar:  new Icon(Icons.home,color: Colors.black12,size: 50.2),

//          new Icon(Icons.home,color: Colors.black12,size: 50.2),

        ),
      ),
    );
  }

//  void _creatNewChild(BuildContext context) async{
//     await Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => AddChild(
//          null, '', '', '', ''
//        )));
//    db.getAllChild().then((allChildren) {
//      setState(() {
//        children.clear();
//        allChildren.forEach((child) {
//          children.add(Child.fromeMap(child));
//        });
//      });
//      childrenNames.clear();
//      for(int i =0 ; i < children.length; i++){
//        childrenNames.add(children[i].name);
//      }
//    });
//
//  }
  void _creatNewChild(BuildContext context) async{
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddChild(
            Child('', '', '', '', 1)
        )));
    db.getAllChild().then((allChildren) {
      setState(() {
        children.clear();
        allChildren.forEach((child) {
          children.add(Child.fromeMap(child));
        });
      });
      childrenNames.clear();
      childrenImages.clear();
      for(int i =0 ; i < children.length; i++){
        childrenImages.add(children[i].image);
        childrenNames.add(children[i].name);
      }
    });

  }

  void _childInfo(BuildContext context) async{
    for(int i = 0 ; i < children.length; i++){
      if(_nameController.text == children[i].name){
        await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChildInfo(children[i])));
      }else{
        isNameCorrect = true;
      }
    }
    if(isNameCorrect){
      isNameCorrect = false;
      _showMaterialDialog();

    }
  }
  void _getChildName(BuildContext context,String image) {
    for(int i = 0 ; i < childrenImages.length; i++){
      if(image == childrenImages[i]){
        _nameController.text = childrenNames[i];
      }
    }

  }

//  void _navigatToChildInfo(BuildContext context,Child child) async{
//    await Navigator.push(
//        context,
//        MaterialPageRoute(builder:(context) => ChildInfo(child)));
//  }

  _showMaterialDialog() {
    showDialog(
      
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("يرجى إختيار إسم "),
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

}



//Column(
//children: [
//new Padding(padding: EdgeInsets.only(bottom: 50.0)),
//new Center(
//child: new Container(
//width: MediaQuery.of(context).size.width *0.7,
//child: new TextField(
//textAlign: TextAlign.right,
//
//style: TextStyle(fontSize: 18.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
//decoration: InputDecoration(
//labelStyle: new TextStyle(
//color: Colors.amberAccent,
//
//),
//focusedBorder:UnderlineInputBorder(
//borderSide: const BorderSide(color: Colors.amberAccent, width: 1.0),
//),
//enabledBorder: UnderlineInputBorder(
//borderSide: BorderSide(
//color: Colors.amberAccent),
//),
//prefixIcon: new DropdownButton<String>(
//underline: Container(
//decoration: const BoxDecoration(
//border: Border(bottom: BorderSide(color: Colors.transparent))
//),
//),
//icon: new Icon(Icons.keyboard_arrow_down),
//items: <String>['${children[3].name}', '${children[1].name}','${children[2].name}'].map((String value) {
//return new DropdownMenuItem<String>(
//value: value,
//child: FlatButton(
//child: Text('$value'),
//onPressed:() => _childInfo(context) ,
//),
//);
//}).toList(),
//onChanged: (_) {},
//),
//hintText: 'الاسم',
//hintStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
//hoverColor: Colors.amberAccent,
//focusColor: Colors.amberAccent,
//),
//onSubmitted: (value) =>  Navigator.push(
//context,
//MaterialPageRoute(builder: (context) => ChildInfo(children[0]))) ,
//),
//)
//),
//
//
//],
//),