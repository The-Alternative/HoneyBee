import 'package:HoneyBee/controllers/children/childHabitController.dart';
import 'package:HoneyBee/controllers/children/habitController.dart';
import 'package:HoneyBee/models/children/childHabit.dart';
import 'package:HoneyBee/models/children/habit.dart';
import 'package:HoneyBee/models/children/child.dart';
import 'package:HoneyBee/views/children/ChildInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';






class ChildHabits extends StatefulWidget {
  final Child child;
  final String from;
  final String to;
  ChildHabits(this.child,this.from,this.to);
  @override
  State<StatefulWidget> createState() {
    return new ChildHabitsState();
  }

}

class ChildHabitsState extends State<ChildHabits>{
  List<ChildHabit> childHabits = new List();
  List<ChildHabit> allchildHabits = new List();
  List<Habit>  habits = new List() ;
  List<String> nhabitsName = new List();
  List<String> phabitsName = new List();
  ChildHabitController db =new ChildHabitController();
  HabitController db2 = new HabitController();

  @override
  void initState() {
    //  TODO: implement initState
    super.initState();
    db.getNegativeChildHabits(widget.child.id).then((allChildNegativeHabits) {
      setState(() {
        allChildNegativeHabits.forEach((negative) {
          allchildHabits.add(ChildHabit.fromeMap(negative));
        });
        DateTime fromd = DateTime.parse(widget.from);
        DateTime tod = DateTime.parse(widget.to);
        for(int i = 0 ; i < allchildHabits.length ; i++){

          DateTime created = DateTime.parse(allchildHabits[i].createdDate);
          int dif1 = created.difference(fromd).inMilliseconds;
          int dif2 = tod.difference(created).inMilliseconds;
          if(dif1 > 0 && dif2 > 0){
            db.getNegativeChildHabit(widget.child.id, allchildHabits[i].id).then((all) {
              setState(() {
                all.forEach((element) {
                  print("${ChildHabit.fromeMap(element).id}");
                  childHabits.add(ChildHabit.fromeMap(element));
                });
              });
            });
          }
        }
        db2.getAllHabits().then((value) {
          setState(() {
            value.forEach((neg){
              habits.add(Habit.fromeMap(neg));
            });
            for(int i = 0 ; i < childHabits.length ; i++){
              for(int j = 0 ; j < habits.length ; j++){
                if (childHabits[i].habitId == habits[j].id){
                  if(habits[j].typeId == 1){
                    nhabitsName.add(habits[j].name);
                  }
                  if(habits[j].typeId == 2){
                    phabitsName.add(habits[j].name);
                  }
                  break;
                }
              }
            }
          });
        });
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new  MaterialApp(
      title: 'Welcome to Flutter',
      home: Container(
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
              new Image(image: AssetImage("assets/images/111.png"), width: 100.0,),
            ],
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              child: new ListView(
                children: [
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                  Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 400,
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.amberAccent, width: 1),
                          borderRadius: BorderRadius.circular(5),
                          shape: BoxShape.rectangle,
                        ),
                        child: ListView(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: MediaQuery.of(context).size.width *0.8,top: 3),
                              child: Icon(Icons.attach_file),
                            ),
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
                                  child: new Text("عادات سلبية",style: TextStyle(color: Colors.white,fontSize: 14),),
                                ),
                                new Padding(padding: EdgeInsets.only(left: 10))
                              ],
                            ),
                            Stack(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *0.8,
                                    height: 150,
                                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                    padding: EdgeInsets.only(bottom: 10,top: 1),

                                    child: (nhabitsName.length > 0)? ListView.builder(
                                        itemCount:nhabitsName.length ,
                                        itemBuilder: (context,posision){
                                          return  new Row(
                                                children: [
                                                  Expanded(child: Text(""),),
                                                  Text("${nhabitsName[posision]}",textDirection: TextDirection.rtl,style: TextStyle(fontWeight: FontWeight.bold),),
                                                  Padding(padding: EdgeInsets.only(left: 10))
                                                ],
                                              );
                                        }
                                    ) : new Text("لم يتم إدخال اي عادات سلبية"),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                new Expanded(child: Text("")),
                                new Container(
                                  padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom:5),
                                  decoration: BoxDecoration(color: Colors.green,
                                    border: Border.all(
                                        color:  Colors.green, width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                    shape: BoxShape.rectangle,),
                                  child: new Text("عادات إيجابية",style: TextStyle(color: Colors.white,fontSize: 14),),
                                ),
                                new Padding(padding: EdgeInsets.only(left: 10))
                              ],
                            ),
                            Stack(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *0.8,
                                    height: 150,
                                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                    padding: EdgeInsets.only(bottom: 10,top: 1),

                                    child: (phabitsName.length > 0)? ListView.builder(
                                        itemCount:phabitsName.length ,
                                        itemBuilder: (context,posision){
                                          return  new Row(
                                            children: [
                                              Expanded(child: Text(""),),
                                              Text("${phabitsName[posision]}",textDirection: TextDirection.rtl,style: TextStyle(fontWeight: FontWeight.bold),),
                                              Padding(padding: EdgeInsets.only(left: 10))
                                            ],
                                          );
                                        }
                                    ) : new Text("لم يتم إدخال اي عادات إيجابية"),
                                  ),
                                )
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
                          child:Image.asset("assets/images/habits.png",width: 50,) ,
                        ),),

                    ],
                  ),
                  new Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.05)),
                  new Center(
                    child: new Container(
                      width: MediaQuery.of(context).size.width *0.7,
                      child: new Row(
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
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar:  new Icon(Icons.home,color: Colors.black12,size: 50.2),
        ),
      ),
    );
  }

  void _childInfo(BuildContext context) async{
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChildInfo(widget.child)));

  }
}


