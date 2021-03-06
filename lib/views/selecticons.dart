
import 'package:diary/models/diary.dart';
import 'package:diary/views/diaries.dart';
import 'package:diary/views/importevent.dart';
import 'package:diary/views/mistmade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SelectIcons extends StatefulWidget {
  @override
  _SelectIconsState createState() => _SelectIconsState();
}

class _SelectIconsState extends State<SelectIcons> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
        Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
        children: [
        Text("مذكرات",style: TextStyle(color: Colors.black),),
    ],
    ),
    ),
          body: Container(
            margin: EdgeInsets.only(top: 90),
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: ListView(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 1,spreadRadius: 5)],
                            // image: DecorationImage(
                            //   image: AssetImage(""),
                            //   scale: 2.0,
                            // ),
                          ),
                          child: FlatButton(
                            child: null,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Diaries(Diary(),'edit')));
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      ClipOval(
                        child: Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 5,spreadRadius: 1)],
                            // image: DecorationImage(
                            //   image: AssetImage(""),
                            //   scale: 2.0,
                            // ),
                          ),
                          child: FlatButton(
                            child: null,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImportEvent(Diary(),'edit')));
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      ClipOval(

                        child: Container(
                          height:75,
                          width: 75,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [BoxShadow(color: Colors.white,blurRadius: 10,spreadRadius: 5)],
                            // image: DecorationImage(
                            //   image: AssetImage(""),
                            //   scale: 2.0,
                            // ),
                          ),
                          child: FlatButton(
                            child: null,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MistMade(Diary(),'edit')));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10,right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("يوميات"),
                        SizedBox(width: 40,),
                        Text("أحداث هامة"),
                        SizedBox(width: 30,),
                        Text("أخطاء ارتكبتها"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: new Icon(Icons.home,color: Colors.black12,size: 50.2,),

    ),),);
  }
}
