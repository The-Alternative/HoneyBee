import 'dart:async';
import 'dart:io';

import 'package:bassel/controllers/children/healthController.dart';
import 'package:bassel/controllers/children/mediaController.dart';
import 'package:bassel/models/children/health.dart';
import 'package:bassel/models/children/child.dart';
import 'package:bassel/models/children/media.dart';
import 'package:bassel/views/children/ChildInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';






class ChildHealth extends StatefulWidget {
  final Child child;
  final String from;
  final String to;
  ChildHealth(this.child,this.from,this.to);
  @override
  State<StatefulWidget> createState() {
    return new ChildHealthState();
  }

}

class ChildHealthState extends State<ChildHealth>{

  List<Health> childHealths =new List();
  List<Health> allchildHealths =new List();
  List<List<Media>> x = new List();
  Health list ;
  HealthController db = new HealthController();
  MediaController db2 = new MediaController();
  String birthDate = '';
  DateTime now = DateTime.now();
  int age;
  int month;
  int dayes;
  DateTime birth;
  int xx;

  @override
  void initState() {
    //  TODO: implement initState
    super.initState();
    db.getChildHealths(widget.child.id).then((allChildren) {
      setState(() {
        allChildren.forEach((health) {
          allchildHealths.add(Health.fromeMap(health));
        });
        DateTime fromd = DateTime.parse(widget.from);
        DateTime tod = DateTime.parse(widget.to);
        for(int i = 0 ; i < allchildHealths.length ; i++){

          DateTime created = DateTime.parse(allchildHealths[i].createdDate);
          int dif1 = created.difference(fromd).inMilliseconds;
          int dif2 = tod.difference(created).inMilliseconds;
          if(dif1 > 0 && dif2 > 0){
            db.getChildHealth(widget.child.id, allchildHealths[i].id).then((all) {
              setState(() {
                all.forEach((element) {
                  childHealths.add(Health.fromeMap(element));
                });
                // for(int i = 0 ; i < childHealths.length ; i ++){
                //   print("66611111");
                //   x.add(List());
                //   print("6662222222");
                // }
                for(int j = 0 ; j < childHealths.length ; j ++){
                  x.add(List());
                  db2.getItemMedias(1, childHealths[i].id).then((value) {
                    setState(() {
                      value.forEach((media) {
                        if(!(i>j)){
                          x[j].add(Media.fromeMap(media));
                        }
                        xx = i;
                      });
                    });
                  });
                }
              });
            });
          }
        }
      }
      );
    });
    birthDate= widget.child.birthDate;
    birth = DateTime.parse(birthDate);

//    age = calculateAge(birth);
//    month = calculateAgeMonth(birth);
//    dayes = calculateAgedays(birth);
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // if(xx == childHealths.length-1){
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:AssetImage("assets/images/background.png"), fit: BoxFit.contain,
                ),
              ),
//            color: Colors.white12,
              child:(childHealths.length > 0)? new ListView.builder(
                  itemCount: childHealths.length,
                  padding: const EdgeInsets.all(15.0),
                  itemBuilder: (context,posision){
                    return Column(
                      children: [


                        Stack(
                          children: <Widget>[

                            Container(
                              width: double.infinity,
                              height: 350,
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                              padding: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.redAccent, width: 1),
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                              ),
                              child: ListView(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width *0.5,top: 5,left: 5),
                                    child: Text("${convertFormatOfCreatedDate(DateTime.parse(childHealths[posision].createdDate))}"),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 15)),
                                  Row(
                                    children: [
                                      Expanded(child: Text("")),
                                      Text("${childHealths[posision].name}"),
                                      Padding(padding: EdgeInsets.only(left: 10)),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(child: Text("")),
                                  //     Text("${childHealths[posision].note}"),
                                  //     Padding(padding: EdgeInsets.only(left: 10)),
                                  //   ],
                                  // ),
                                  new Container (
                                    padding: const EdgeInsets.all(16.0),
                                    width: MediaQuery.of(context).size.width*0.8,
                                    child: new Column (
                                      children: <Widget>[
                                        Text("${childHealths[posision].note}",textAlign: TextAlign.right),
                                      ],
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(child: Text("")),
                                  //     Image.file(File(x[posision][0].mediaUrl),width: 100,height: 100,),
                                  //     Padding(padding: EdgeInsets.only(left: 10)),
                                  //     Image.file(File(x[posision][1].mediaUrl),width: 100,height: 100),
                                  //     Expanded(child: Text("")),
                                  //   ],
                                  // ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 20.0),
                                    height: 100.0,
                                    child:x[posision].length > 0 ? ListView.builder(
                                      itemCount: x[posision].length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context,position){
                                        return Image.file(File(x[posision][position].mediaUrl),width: 100,height: 100);
                                      }
                                    ):Center(
                                      child: Text("لايوجد مرفقات"),
                                    ),
                                  ),
                                  new Row(
                                    children: [
                                      new Expanded(child: Text("")),
                                      new Column(
                                        children: [

                                          new Text('الحرارة',style: TextStyle(fontSize: 18),),
                                          new Padding(padding: EdgeInsets.only(bottom: 15.0)),
                                          new Text('${childHealths[posision].tempreture}',style: TextStyle(fontSize: 18),),
                                        ],
                                      ),
                                      new Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.2)),
                                      new Column(
                                        children: [
                                          new Text('الوزن',style: TextStyle(fontSize: 18),),
                                          new Padding(padding: EdgeInsets.only(bottom: 15.0)),
                                          new Text('${childHealths[posision].weight}',style: TextStyle(fontSize: 18),),
                                        ],
                                      ),
                                      new Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.2)),
                                      new Column(
                                        children: [
                                          new Text('الطول',style: TextStyle(fontSize: 18),),
                                          new Padding(padding: EdgeInsets.only(bottom: 15.0)),
                                          new Text('${childHealths[posision].tall}',style: TextStyle(fontSize: 18),),

                                        ],
                                      ),
                                      new Expanded(child: Text("")),

                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 15.0)),
                                  Row(
                                    children: [
                                      new Expanded(child: Text("")),
                                      Text('يوم',style: TextStyle(color: Colors.black,fontSize: 18.0)),
                                      Padding(padding: EdgeInsets.only(left: 10.0)),
                                      Text('${calculateAgedays(DateTime.parse(widget.child.birthDate),DateTime.parse(childHealths[posision].createdDate))}',style: TextStyle(color: Colors.grey,fontSize: 18.0),),
                                      Padding(padding: EdgeInsets.only(left:15.0)),
                                      Text('أشهر',style: TextStyle(color: Colors.black,fontSize: 18.0)),
                                      Padding(padding: EdgeInsets.only(left: 10.0)),
                                      Text('${calculateAgeMonth(DateTime.parse(widget.child.birthDate),DateTime.parse(childHealths[posision].createdDate))}',style: TextStyle(color: Colors.grey,fontSize: 18.0),),
                                      Padding(padding: EdgeInsets.only(left:15.0)),
                                      Text('سنوات',style: TextStyle(color: Colors.black,fontSize: 18.0)),
                                      Padding(padding: EdgeInsets.only(left: 10.0)),
                                      Text('${calculateAge(DateTime.parse(widget.child.birthDate),DateTime.parse(childHealths[posision].createdDate))}',style: TextStyle(color: Colors.grey,fontSize: 18.0),),
                                      new Expanded(child: Text("")),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                right:20 ,
                                top: -5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child:Image.asset("assets/images/helth.png",width: 50,) ,
                                ),),
                          ],
                        ),
                        (posision == childHealths.length-1) ?  new Center(
                          child: new Container(
                            width: MediaQuery.of(context).size.width *0.7,
                            child: new Row(
                              children: [
                                new FlatButton(
                                    child:new Text('موافق',style: new TextStyle(fontSize: 19.0,color: Colors.black)),
                                    onPressed:  () => _childInfo(context),
                                ),
                                new Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width *0.15 )),
                                new FlatButton(
                                    onPressed:  () => _childInfo(context),
                                    child: new Text('إلغاء الأمر',style: new TextStyle(fontSize: 19.0,color: Colors.black),)),
                              ],
                            ),
                          ),
                        ) :  Text(""),
                      ],

                    );
                  }
              ) : new Center(
                child: new Container(
                  width: MediaQuery.of(context).size.width *0.7,
                  child:new Column(
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 30),),
                      new Center(
                        child: Text("No Health Note For this child"),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 30),),
                      new Row(
                        children: [

                          new FlatButton(
                              child:new Text('موافق',style: new TextStyle(fontSize: 19.0,color: Colors.black)),
                              onPressed: null
                          ),
                          new Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width *0.15 )),
                          new FlatButton(
                              onPressed: () {Navigator.pop(context);},
                              child: new Text('إلغاء الأمر',style: new TextStyle(fontSize: 19.0,color: Colors.black),)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ),

          bottomNavigationBar:  new Icon(Icons.home,color: Colors.black12,size: 50.2),

//          new Icon(Icons.home,color: Colors.black12,size: 50.2),

        ),
      ),
    );
//     ;}else{
//  return FutureBuilder(
//
//     builder: (ctx, snapshot) {
//       var value =  '0';
//
//       return Text(
//         value,
//         style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold
//         ),
//       );
//     }
// );;
//     }
  }



//  void _childInfo(BuildContext context) async{
//     await Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => ChildInfo(children[0])));
//  }

  void _navigatToChildInfo(BuildContext context,Child child) async{
    await Navigator.push(
        context,
        MaterialPageRoute(builder:(context) => ChildInfo(child)));
  }
  calculateAge(DateTime birthDate,DateTime createdDate) {
    DateTime currentDate = createdDate;
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
  calculateAgeMonth(DateTime birthDate,DateTime createdDate) {
    if (birthDate != '') {


      final now = createdDate;

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
  calculateAgedays(DateTime birthDate,DateTime createdDate) {
    if (birthDate != '') {


      final now = createdDate;

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

  convertFormatOfCreatedDate(DateTime createdDate) {
    final x = DateFormat("dd/MM/yyyy").format(createdDate);
    return x;
  }

  void _childInfo(BuildContext context) async{
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChildInfo(widget.child)));

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
//],${childHealths[posision].note}
//),