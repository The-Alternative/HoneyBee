import 'dart:ui';

import 'package:diary/views/selecticons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // Color mainColor = Color(0xffb74093);

  // DiaryController db = new DiaryController();
  // Future<List<Diary>> _futureCardList;
  // List<Diary> _cardList;

  @override
  Widget build(BuildContext context) {

    // if (_cardList == null) {
    //   _cardList = List<Diary>();
    //   // addCardListView();
    //
    // }
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
        body: Padding(
          padding: const EdgeInsets.all(0),
        child: ListView(
          children: [
               Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration:InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      suffixIcon: Icon(Icons.search,color: Colors.amber,),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder:UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white)

                      ),
                    ),
                    ),
                ),
              ),

            Container(
              margin:const EdgeInsets.only(top: 400,left: 30,right: 30),
              child: RaisedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectIcons()));
                },
                child: Text("إنشاء منشور",style: TextStyle(fontSize: 20,color: Colors.white),),
                color: Colors.blue[400],
              ),
            ),
          ],
        ),
      ),
          bottomNavigationBar: new Icon(Icons.home,color: Colors.black12,size: 50.2,),
    ))
    );
  }
  // addCardListView() {
  //   _futureCardList = db.getAll();
  //   _futureCardList.then((cardList) {
  //     setState(() {
  //       this._cardList = cardList;
  //     });
  //   });
  // }


}
