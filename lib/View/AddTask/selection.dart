import 'package:flutter_task/Config/general.dart';
import 'package:flutter_task/View/AddTask/publicTask.dart';
import 'package:flutter_task/bloc/stage_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'addTask.dart';
import 'add_event.dart';
import 'connectionTask.dart';

class SelectIcons extends StatefulWidget {
  @override
  _SelectIconsState createState() => _SelectIconsState();
}

class _SelectIconsState extends State<SelectIcons> {
  bool result =false;
  var style1 =
  TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Times');
  @override
  Widget build(BuildContext context) {
     return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: Row(
              children: [
                CircleAvatar(radius: 20,
                  child: Image.asset("assets/to-do-list.png"),backgroundColor: Colors.white,),
                SizedBox(width: 20,),
                Text("مهمات", style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: 25),
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(child: Column(children: [IconButton(icon:Image.asset(
                        "assets/portfolio.png",
                        width: 50,
                        height: 50,
                      ) , onPressed: (){publicTask(taskTypes[0]);},iconSize: 50,),
                      Text(taskTypes[0])],),color: Colors.black12,),

                      Container(child: Column(children: [IconButton(icon:Image.asset(
                        "assets/groupper.png",
                        width: 50,
                        height: 50,
                      ) ,iconSize: 50,onPressed: () { publicTask(taskTypes[1]) ; }),
                        Text(taskTypes[1])],),),

                      Container(child: Column(children: [IconButton(icon:Image.asset(
                        "assets/shopping-list.png",
                        width: 50,
                        height: 50,
                      ) ,iconSize: 50,),
                        Text(taskTypes[2])],),),                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(child: Column(children: [IconButton(icon:Image.asset(
                        "assets/call.png",
                        width: 50,
                        height: 50,
                      ) , onPressed: connectTask,iconSize: 50,),
                        Text(taskTypes[3])],),),

                      Container(child: Column(children: [IconButton(icon:Image.asset(
                        "assets/doctor.png",
                        width: 50,
                        height: 50,
                      ) , iconSize: 50,onPressed: () { publicTask(taskTypes[4]) ; }),
                        Text(taskTypes[4])],),),

                      Container(child: Column(children: [IconButton(icon:Image.asset(
                        "assets/group.png",
                        width: 50,
                        height: 50,
                      ) , onPressed: (){publicTask(taskTypes[5]) ; },iconSize: 50,),
                        Text(taskTypes[5])],),),                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(child: Column(children: [IconButton(icon:Image.asset(
                        "assets/airplane.png",
                        width: 50,
                        height: 50,
                      ) , onPressed: (){publicTask(taskTypes[6]) ;},iconSize: 50,),
                        Text(taskTypes[6])],),),

                      Container(child: Column(children: [IconButton(icon:Image.asset(
                        "assets/money.png",
                        width: 50,
                        height: 50,
                      ) , onPressed: (){publicTask(taskTypes[7]) ;},iconSize: 50,),
                        Text(taskTypes[7])],),),

                      Container(child: Column(children: [IconButton(icon:Image.asset(
                        "assets/coffe.png",
                        width: 50,
                        height: 50,
                      ) , onPressed: (){publicTask(taskTypes[8]) ;},iconSize: 50,),
                        Text(taskTypes[8])],),),                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(child: Column(children: [IconButton(icon:Image.asset(
                        "assets/key-lock.png",
                        width: 50,
                        height: 50,
                      ) , onPressed: (){publicTask(taskTypes[5]) ;},iconSize: 50,),
                        Text(taskTypes[9])],),),

                      Container(child: Column(children: [IconButton(icon:Image.asset(
                        "assets/house.png",
                        width: 50,
                        height: 50,
                      ) , onPressed: (){publicTask(taskTypes[10]) ;},iconSize: 50,),
                        Text(taskTypes[10])],),),

                      Container(child: Column(children: [IconButton(icon:Image.asset(
                        "assets/list.png",
                        width: 50,
                        height: 50,
                      ) , iconSize: 50,onPressed: (){publicTask(taskTypes[11]) ;},),
                        Text(taskTypes[11])],),),                    ],
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: new Icon(Icons.home,color: Colors.black12,size: 50.2,),

        ),);
  }
  void fail_moveToLastScreen(BuildContext context1) {
    Navigator.pop(context1, false);
  }
  _awaitReturnValueFromAddEvent() async {
   bool res= await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTask(),
        ));
if(res) {
  print('ok');
  Navigator.pop(context, true);
}
   setState(() {});
  }
  connectTask() async {
    bool res= await Navigator.push(
        context, MaterialPageRoute(builder: (context) =>

        BlocProvider<StageBloc>(
          create: (context) => StageBloc(),
          child: DialupTask(),)
    ));
    if(res) {
      print('ok');
      Navigator.pop(context, true);
    }
    setState(() {});
  }
  publicTask(String tit) async {
    bool res= await Navigator.push(
        context, MaterialPageRoute(builder: (context) =>

        BlocProvider<StageBloc>(
          create: (context) => StageBloc(),
          child: PublicTask(title: tit,),)
    ));
    if(res) {
      print('ok');
      Navigator.pop(context, true);
    }
    setState(() {});
  }

}

