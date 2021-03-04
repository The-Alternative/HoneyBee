import 'dart:io';

import '../screen/AddChild.dart';
import '../controller/childController.dart';
import '../model/child.dart';
import 'Search.dart';
import 'SearchResults.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'AddDevelopment.dart';
import 'AddEvent.dart';
import 'AddHealthNote.dart';
import 'Habits.dart';


class ChildInfo extends StatefulWidget{
  final Child child;
  ChildInfo(this.child);
  @override
  State<StatefulWidget> createState() {
    return new ChildInfoState();
  }

}
class ChildInfoState extends State<ChildInfo>{
  ChildController db ;
  String name = '';
  String sex = '';
  String birthDate = '';
  String image = '';
  String isActive = '';
  DateTime now = DateTime.now();
  String formattedDate ;
  File imageFile;
  int age;
  int month;
  int dayes;
  DateTime birth;
  TextEditingController _nameController;


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    name = widget.child.name;
    sex = widget.child.sex;
    birthDate = widget.child.birthDate;
    image = widget.child.image;
    isActive = '';
    formattedDate = DateFormat("dd/MM/yyyy").format(now);
    birth = DateTime.parse(birthDate);
    age = calculateAge(birth);
    month = calculateAgeMonth(birth);
    dayes = calculateAgedays(birth);
    _nameController = new TextEditingController(text: '');
    imageFile = File(image);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "Child Information",
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
          body: new Center(
            child: new Container(
              child: new ListView(
                children: [
                  new Padding(padding: EdgeInsets.only(bottom: 25.0)),

                  TextField(
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                    onEditingComplete: () => _search(context),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(width: 1,color: Colors.amberAccent),
                        ),
                      hintText: '',
                      hintStyle: TextStyle(fontSize: 16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(width: 1,color: Colors.amberAccent),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.amberAccent
                      ),

                      contentPadding: EdgeInsets.only(left: 10,right: 10),
                      fillColor: Colors.white70,
                      prefixIcon: Icon(Icons.search,color: Colors.amberAccent,)
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15.0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                      new Text('م',style: TextStyle(color: Colors.grey,fontSize: 18.0),) ,
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Expanded(
                        child:new Text('${now.hour}:${now.minute}',style: TextStyle(color: Colors.grey,fontSize: 18.0),) ,
                      ),
                      new Text('$formattedDate',style: TextStyle(color: Colors.grey,fontSize: 18.0),),
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                    ],
                  ),
                  Center(
                    child:  new MaterialButton(
                      onPressed: () => _navigateToUpdateChild(context),
                      color: Colors.white,
                      textColor: Colors.grey,
                      child: image == ''
                          ? Text('تعديل')
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child:Image.file(imageFile,width: 150,height: 150,) ,
                      ),
                      // Image.file(_image,width: 100,height: 100,),

                      padding: image == '' ? EdgeInsets.all(50):EdgeInsets.all(0),
                      shape:  CircleBorder(side: BorderSide(
                          color: Colors.amberAccent
                      )),
                      splashColor: Colors.amberAccent,
                      highlightColor: Colors.amberAccent,

                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15.0)),
                  Center(
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.4,)),
                        new Text('$name'),
                        Padding(padding: EdgeInsets.only(left: 10.0)),
                        (sex == 'انثى') ? new Icon(Icons.face,color: Colors.pinkAccent,) :new Icon(Icons.face,color: Colors.blueAccent,),

                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15.0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left:30.0)),
                      Text('يوم',style: TextStyle(color: Colors.black,fontSize: 18.0)),
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Text('$dayes',style: TextStyle(color: Colors.grey,fontSize: 18.0),),
                      Padding(padding: EdgeInsets.only(left:15.0)),
                      Text('أشهر',style: TextStyle(color: Colors.black,fontSize: 18.0)),
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Text('$month',style: TextStyle(color: Colors.grey,fontSize: 18.0),),
                      Padding(padding: EdgeInsets.only(left:15.0)),
                      Text('سنوات',style: TextStyle(color: Colors.black,fontSize: 18.0)),
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Text('$age',style: TextStyle(color: Colors.grey,fontSize: 18.0),),
                      Padding(padding: EdgeInsets.only(left:30.0)),
                      Text(':',style: TextStyle(color: Colors.black,fontSize: 18.0)),
                      Padding(padding: EdgeInsets.only(left: 1.0)),
                      Text('العمر',style: TextStyle(color: Colors.black,fontSize: 20.0),),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15.0)),
                  new Container(
                    padding: EdgeInsets.all(0.5),
                    margin: EdgeInsets.only(left: 20,right: 20),
                    color: Colors.amberAccent,
                  ),
                  new Row(
                    children: [
                      new Expanded(child: Text("")),
                      new Container(
                          padding: EdgeInsets.only(top: 30.0,bottom: 25.0),
                          child: new Column(
                            children: [
                              new MaterialButton(
                                onPressed:() => _childHabits(context) ,
                                color: Colors.white,
                                child: Image.asset("assets/images/habits.png",width: 50,height: 50),
                                shape: CircleBorder(side: BorderSide(
                                    color: Colors.white
                                )),

                              ),

                              new Text('سلوك و عادات')
                            ],
                          )
                      ),
                      new Container(
                          padding: EdgeInsets.only(top: 30.0,bottom: 25.0),
                          child: new Column(
                            children: [
                              new MaterialButton(
                                onPressed:() => _childEvents(context),
                                color: Colors.white,
                                child: Image.asset("assets/images/events.png",width: 50,height: 50,),
                                shape: CircleBorder(side: BorderSide(
                                    color: Colors.white
                                )),
                              ),


                              new Text('احداث هامة')
                            ],
                          )
                      ),
                      new Container(
                          padding: EdgeInsets.only(top: 30.0,bottom: 25.0),
                          child: new Column(
                            children: [
                              new MaterialButton(
                                onPressed: () => _childDevelopments(context),
                                color: Colors.white,
                                child: Image.asset("assets/images/developments.png",width: 50,height: 50,),
                                shape: CircleBorder(side: BorderSide(
                                    color: Colors.white
                                )),

                              ),

                              new Text('تطورات')
                            ],
                          )
                      ),
                      new Container(
                          padding: EdgeInsets.only(top: 30.0,bottom: 25.0),
                          child: new Column(
                            children: [
                              new MaterialButton(
                                onPressed: () => _childHealths(context),
                                color: Colors.white,
                                child: Image.asset("assets/images/helth.png",width: 50,height: 50,),
                                shape: CircleBorder(side: BorderSide(
                                    color: Colors.white
                                )),

                              ),

                              new Text('الصحة')
                            ],
                          )
                      ),
                      new Expanded(child: Text("")),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15.0)),
                  new Container(
                    child: Center(
                      child: FlatButton(
                          onPressed: () => _navigatToSearch(context),
                          child: Text('استعراض',style: TextStyle(color: Colors.black54,fontSize: 22.0),)),
                    ),
                  ),


                ],
              ),
            ),
          ),
          bottomNavigationBar:  new Icon(Icons.home,color: Colors.black12,size: 50.2),

                  ),
      ),
    );
  }
  void _childHealths(BuildContext context) async{
    String result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddHealthNote(widget.child)));
  }
  void _childDevelopments(BuildContext context) async{
    String result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddDevelopment(widget.child)));
  }
  void _childEvents(BuildContext context) async{
    String result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddEvent(widget.child)));
  }
  void _childHabits(BuildContext context) async{
    String result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Habits(widget.child)));
  }

  void _navigatToSearch(BuildContext context) async{
    String result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Search(widget.child)));
  }
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
  calculateAgeMonth(DateTime birthDate) {
    if (birthDate != '') {


        final now = new DateTime.now();

        int years = now.year - birthDate.year;
        int months = now.month - birthDate.month;
        int days = now.day - birthDate.day;

        if (months < 0 || (months == 0 && days < 0)) {
          years--;
          months += (days < 0 ? 11 : 12);
        }

        if (days < 0) {
          final monthAgo = new DateTime(now.year, now.month - 1, birthDate.day);
          days = now.difference(monthAgo).inDays + 1;
        }


       return months;
    } else {
      print('getTheKidsAge: date is empty');
    }
    return 0;
  }
  calculateAgedays(DateTime birthDate) {
    if (birthDate != '') {


      final now = new DateTime.now();

      int years = now.year - birthDate.year;
      int months = now.month - birthDate.month;
      int days = now.day - birthDate.day;

      if (months < 0 || (months == 0 && days < 0)) {
        years--;
        months += (days < 0 ? 11 : 12);
      }

      if (days < 0) {
        final monthAgo = new DateTime(now.year, now.month - 1, birthDate.day);
        days = now.difference(monthAgo).inDays + 1;
      }


      return days;
    } else {
      print('getTheKidsAge: date is empty');
    }
    return 0;
  }
  void _search(BuildContext context) async{
        await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchResult(widget.child,_nameController.text)));

  }
  void _navigateToUpdateChild(BuildContext context) async{
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddChild(widget.child)));


  }

}