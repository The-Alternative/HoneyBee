import '../controller/childHabitController.dart';
import '../controller/habitController.dart';
import '../model/childHabit.dart';
import '../model/habit.dart';
import '../model/child.dart';
import 'AddNegativeHabit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'AddPositiveHabit.dart';






class Habits extends StatefulWidget {
  final Child child;
  Habits(this.child);
  @override
  State<StatefulWidget> createState() {
    return new HabitsState();
  }
}

class HabitsState extends State<Habits>{
  List<Habit> nhabits =new List();
  List<Habit> phabits =new List();
  List<bool>  nvalue = new List();
  List<bool>  pvalue = new List();
  List<bool>  nnvalue = new List();
  List<bool>  ppvalue = new List();
  List<ChildHabit> nchildHa = new List();
  List<ChildHabit> pchildHa = new List();
  List<ChildHabit> childHabits = new List();

  Habit list;
  HabitController db = new HabitController();
  ChildHabitController db2 = new ChildHabitController();
  DateTime now = DateTime. now();
  String formattedDate ;
  bool x = false;
  bool y = false;



  @override
  void initState() {
    //  TODO: implement initState
    super.initState();
    db2.getNegativeChildHabits(widget.child.id).then((allChildNegativeHabits) {
      setState(() {
        allChildNegativeHabits.forEach((negative) {
          childHabits.add(ChildHabit.fromeMap(negative));
        });
      });
    });
    db.getNegaiveHabits().then((allHabits) {
      setState(() {
        allHabits.forEach((habit) {
          nhabits.add(Habit.fromeMap(habit));
//          nvalue.add(false);
        });
        for(int i = 0 ; i <nhabits.length  ; i++){
          for(int j = 0 ; j < childHabits.length ; j++){
            if (nhabits[i].id == childHabits[j].habitId){
                nvalue.add(true);
                nnvalue.add(true);
                nchildHa.add(childHabits[j]);
                x =true;
//                print("$i==$j==${nhabits[i].id}:1111111: ${childHabits[j].habitId}/////$x");
                break;
            }
//            print("$i==$j==${nhabits[i].id}:222222: ${childHabits[j].habitId}/$x");
          }
          if(!x){
            nvalue.add(false);
            nnvalue.add(false);
//            print("$i==${nhabits[i].id}:333333:///////$x ");
          }
          x= false;
        }
      });
    });
    db.getPositiveHabits().then((posHabits) {
      setState(() {
        posHabits.forEach((phabit) {
          phabits.add(Habit.fromeMap(phabit));
//          pvalue.add(false);
        });
        for(int i = 0 ; i <phabits.length  ; i++){
          for(int j = 0 ; j < childHabits.length ; j++){
            if (phabits[i].id == childHabits[j].habitId){
              pchildHa.add(childHabits[j]);
              pvalue.add(true);
              ppvalue.add(true);
              y =true;
//              print("$i==$j==${phabits[i].id}:1111111: ${childHabits[j].habitId}/////$x");
              break;
            }
//            print("$i==$j==${phabits[i].id}:222222: ${childHabits[j].habitId}/$x");
          }
          if(!y){
            pvalue.add(false);
            ppvalue.add(false);
//            print("$i==${phabits[i].id}:333333:///////$x ");
          }
          y= false;
        }
      });
    });
    formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss").format(now);
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
            child:  Center(
                child:new ListView(
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: 15)),
                    Row(
                      children: [
                        new Expanded(child: Text("")),
                        new Container(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom:5),
                          decoration: BoxDecoration(color: Colors.redAccent,
                            border: Border.all(
                                color:  Colors.redAccent, width: 1),
                            borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.rectangle,),
                          child: new Text("عادات سلبية",style: TextStyle(color: Colors.white,fontSize: 18),),
                        ),
                        new Expanded(child: Text("")),
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width *0.8,
                            height: 300,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                            padding: EdgeInsets.only(bottom: 10,top: 1),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:  Colors.redAccent, width: 1),
                              borderRadius: BorderRadius.circular(5),
                              shape: BoxShape.rectangle,
                            ),
                            child: (nhabits.length > 0)? ListView.builder(
                                itemCount:nhabits.length ,
                                itemBuilder: (context,posision){
                                  return  new Column(
                                    children: [
//                                      new Padding(padding: EdgeInsets.only(bottom: 10)),
                                      new Row(
                                        children: [
                                          new Expanded(child: Text("")),
                                          new Text("${nhabits[posision].name}"),
                                          Padding(padding: EdgeInsets.only(left: 10)),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                nvalue[posision] = !nvalue[posision];
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent),
                                              child: Padding(
                                                padding: const EdgeInsets.all(0.1),
                                                child: nvalue[posision]
                                                    ? Icon(
                                                  Icons.check,
                                                  size: 30.0,
                                                  color: Colors.white,
                                                )
                                                    : Icon(
                                                  Icons.brightness_1,
                                                  size: 30.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.only(left: 10)),
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.only(bottom: 15)),
                                      (posision == nhabits.length-1) ?  new Center(
                                          child: new Row(
                                              children: [
                                                new Expanded(child: Text("")),
                                                InkWell(
                                                  onTap:  () => _addNegativHabit(context),
                                                  child: Container(
                                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent),
                                                    child: Padding(
                                                        padding: const EdgeInsets.all(0.1),
                                                        child: Icon(Icons.add_circle,color: Colors.white,size: 30.0,)
                                                    ),
                                                  ),
                                                ),
                                                new Padding(padding: EdgeInsets.only(left: 10),)
                                              ]
                                          )
                                      ) :  Text(""),
                                    ],
                                  );
                                }
                            ) : new Center(
                                child: new Row(
                                    children: [
                                      new Expanded(child: Text("")),
                                      InkWell(
                                        onTap: () => _addNegativHabit(context),
                                        child: Container(
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent),
                                          child: Padding(
                                              padding: const EdgeInsets.all(0.1),
                                              child: Icon(Icons.add_circle,color: Colors.white,size: 30.0,)
                                          ),
                                        ),
                                      ),
                                      new Padding(padding: EdgeInsets.only(left: 10),)
                                    ]
                                )
                            ),
                          ),
                        )
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(bottom: 5)),
                    Row(
                      children: [
                        new Expanded(child: Text("")),
                        new Container(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom:5),
                          decoration: BoxDecoration(color: Colors.greenAccent,
                            border: Border.all(
                                color:  Colors.greenAccent, width: 1),
                            borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.rectangle,),
                          child: new Text("عادات إيجابية",style: TextStyle(color: Colors.white,fontSize: 18),),
                        ),
                        new Expanded(child: Text("")),
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width *0.8,
                            height: 300,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                            padding: EdgeInsets.only(bottom: 10,top: 1),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:  Colors.greenAccent, width: 1),
                              borderRadius: BorderRadius.circular(5),
                              shape: BoxShape.rectangle,
                            ),
                            child: (phabits.length > 0)? ListView.builder(
                                itemCount:phabits.length ,
                                itemBuilder: (context,posision){
                                  return  new Column(
                                    children: [
//                                      new Padding(padding: EdgeInsets.only(bottom: 10)),
                                new Row(
                                  children: [
                                    new Expanded(child: Text("")),
                                    new Text("${phabits[posision].name}"),
                                    Padding(padding: EdgeInsets.only(left: 10)),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          pvalue[posision] = !pvalue[posision];
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.greenAccent),
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.1),
                                          child: pvalue[posision]
                                              ? Icon(
                                            Icons.check,
                                            size: 30.0,
                                            color: Colors.white,
                                          )
                                              : Icon(
                                            Icons.brightness_1,
                                            size: 30.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 10)),
                                  ],
                                ),
                                      Padding(padding: EdgeInsets.only(bottom: 5)),
                                      (posision == phabits.length-1) ?  new Center(
                                          child: new Row(
                                              children: [
                                                new Expanded(child: Text("")),
                                                InkWell(
                                                  onTap:  () => _addPositiveHabit(context),
                                                  child: Container(
                                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.greenAccent),
                                                    child: Padding(
                                                        padding: const EdgeInsets.all(0.1),
                                                        child: Icon(Icons.add_circle,color: Colors.white,size: 30.0,)
                                                    ),
                                                  ),
                                                ),
                                                new Padding(padding: EdgeInsets.only(left: 10),)
                                              ]
                                          )
                                      ) :  Text(""),
                                    ],
                                  );
                                }
                            ) : new Center(
                                child: new Row(
                                    children: [
                                      new Expanded(child: Text("")),
                                      InkWell(
                                        onTap: () => _addPositiveHabit(context),
                                        child: Container(
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.greenAccent),
                                          child: Padding(
                                              padding: const EdgeInsets.all(0.1),
                                              child: Icon(Icons.add_circle,color: Colors.white,size: 30.0,)
                                          ),
                                        ),
                                      ),
                                      new Padding(padding: EdgeInsets.only(left: 10),)
                                    ]
                                )
                            ),
                          ),
                        )
                      ],
                    ),
//
                    new Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.05)),
                    new Center(
                      child: new Container(
                        width: MediaQuery.of(context).size.width *0.7,
                        child: new Row(
                          children: [
                            new FlatButton(
                                child:new Text('موافق',style: new TextStyle(fontSize: 19.0,color: Colors.black)),
                                onPressed:(){
                                  for(int i =0 ; i<nvalue.length ; i++){
                                  if(nvalue[i] == true){
                                    if(nnvalue[i] == false){
                                      db2.saveChildHabit(ChildHabit(
                                          1,
                                          nhabits[i].id,
                                          widget.child.id,
                                          formattedDate
                                      ));
                                    }
                                  }else{
                                    if(nnvalue[i] == true){
                                      for(int k =0;k<nchildHa.length;k++){
                                        if(nchildHa[k].habitId == nhabits[i].id){
                                          db2.deleteChildHabit(nchildHa[k]);
                                        }
                                      }
                                    }
                                  }
                                }
                                for(int j =0 ; j<pvalue.length ; j++){
                                  if(pvalue[j] == true){
                                    if(ppvalue[j] == false) {
                                      db2.saveChildHabit(ChildHabit(
                                          1,
                                          phabits[j].id,
                                          widget.child.id,
                                          formattedDate
                                      ));
                                    }
                                  }else{
                                    if(ppvalue[j] == true){
                                      for(int r =0;r<pchildHa.length;r++){
                                        if(pchildHa[r].habitId == phabits[j].id){
                                          db2.deleteChildHabit(pchildHa[r]);
                                        }
                                      }
                                    }
                                  }
                                }
                                 Navigator.pop(context,'save');
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
                )
            ),

          ),

          bottomNavigationBar:  new Icon(Icons.home,color: Colors.black12,size: 50.2),

                  ),
      ),
    );
  }
  void _addNegativHabit(BuildContext context) async{
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddNegativeHabit()));
    db.getNegaiveHabits().then((allHabits) {
      setState(() {
        nhabits.clear();
        nvalue.clear();
        nnvalue.clear();
        allHabits.forEach((habit) {
          nhabits.add(Habit.fromeMap(habit));
//          nvalue.add(false);
        });
        for(int i = 0 ; i <nhabits.length  ; i++){
          for(int j = 0 ; j < childHabits.length ; j++){
            if (nhabits[i].id == childHabits[j].habitId){
              nvalue.add(true);
              nnvalue.add(true);
              nchildHa.add(childHabits[j]);
              x =true;
//                print("$i==$j==${nhabits[i].id}:1111111: ${childHabits[j].habitId}/////$x");
              break;
            }
//            print("$i==$j==${nhabits[i].id}:222222: ${childHabits[j].habitId}/$x");
          }
          if(!x){
            nvalue.add(false);
            nnvalue.add(false);
//            print("$i==${nhabits[i].id}:333333:///////$x ");
          }
          x= false;
        }
      });
    });
  }

  void _addPositiveHabit(BuildContext context) async{
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddPositiveHabit()));
    db.getPositiveHabits().then((allHabits) {
      setState(() {
        phabits.clear();
        pvalue.clear();
        ppvalue.clear();
        allHabits.forEach((phabit) {
          phabits.add(Habit.fromeMap(phabit));
//          pvalue.add(false);
        });
        for(int i = 0 ; i <phabits.length  ; i++){
          for(int j = 0 ; j < childHabits.length ; j++){
            if (phabits[i].id == childHabits[j].habitId){
              pchildHa.add(childHabits[j]);
              pvalue.add(true);
              ppvalue.add(true);
              y =true;
//              print("$i==$j==${phabits[i].id}:1111111: ${childHabits[j].habitId}/////$x");
              break;
            }
//            print("$i==$j==${phabits[i].id}:222222: ${childHabits[j].habitId}/$x");
          }
          if(!y){
            pvalue.add(false);
            ppvalue.add(false);
//            print("$i==${phabits[i].id}:333333:///////$x ");
          }
          y= false;
        }
      });
    });
  }
//  ifHasHabit (int childId,int habitId) async{
//    List thisChildHabits = new List();
//    db2.getChildHabits(childId).then((allHabits) {
//      setState(() {
//        allHabits.forEach((childhabit) {
//          thisChildHabits.add(ChildHabit.fromeMap(childhabit));
//        });
//        for(int i = 0 ; i < thisChildHabits.length ; i++){
//          if(habitId == thisChildHabits[i].habitId){
//            return true;
//          }
//        }
//        return false;
//      });
//    });
//  }
}


