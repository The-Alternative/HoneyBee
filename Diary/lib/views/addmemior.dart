
import 'dart:io';
import 'dart:ui';

import 'package:diary/controllers/diarycontrollers.dart';
import 'package:diary/models/diary.dart';
import 'package:diary/models/diary.dart';
import 'package:diary/utils/database.dart';
import 'package:diary/views/diaries.dart';
import 'package:diary/views/selecticons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FirstPage extends StatefulWidget {
  Diary diary;
  String text;
  FirstPage(this.diary);


  @override
  _FirstPageState createState() => _FirstPageState(this.diary);
}
class _FirstPageState extends State<FirstPage> {
  Diary diary;
  _FirstPageState(this.diary);
  List<String> diaryL =new List();

  String value;
  int count = 0;

  final DatabaseConfig dbs = new DatabaseConfig();
  DiaryController db = new DiaryController();

  Future<List<Diary>> _futureCardList;
  List<Diary> _cardList= new List();

  String imagePath = '';
  List<String> diaryImages = [];
  TextEditingController addressCoontroller;

  @override
  void initState() {

    super.initState();

    // db.searchDiary(widget.diary.id,widget.text).then((allChildren) {
    //   setState(() {
    //     allChildren.forEach((health) {
    //       _cardList.add(Diary.fromMap(health));
    //     });
    //     for(int i =0 ; i < _cardList.length; i++){
    //       diaryL.add(_cardList[i].address);
    //     }
    //   });
    // });

    db.getAllDiary().then((getall) {
      setState(() {
        getall.forEach((diary) {
          _cardList.add(Diary.fromMap(diary));
        });
      });
      for(int i =0 ; i < _cardList.length; i++){
        diaryImages.add(_cardList[i].image);

      }
    });

    addressCoontroller = new TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    if (_cardList == null) {
      _cardList = List<Diary>();
      addCardListView();
      updatelistview();
    }

    addressCoontroller.text = diary.address;
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
        Directionality(textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.amber,
                title: Row(
                  children: [
                    CircleAvatar(radius: 20,
                      child: Image.asset("assests/diary.png"),),
                    SizedBox(width: 20,),
                    Text("مذكرات",style: TextStyle(color: Colors.black),),
                  ],
                ),
              ),
              body:
              Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    Card(
                      child: Column(
                        children: [

                          Container(
                            margin: EdgeInsets.all(10),height: 40,
                            child: TextFormField(
                              controller: addressCoontroller,
                              decoration:InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: "بحث..",
                                hintStyle: TextStyle(color: Colors.grey[500],fontSize: 13),
                                suffixIcon: Icon(Icons.search,color: Colors.amber,size: 30,),
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
                        ],
                      ),
                    ),
                    // Stack(
                    //   children: [
                    //     Center(
                    //       child: Container(
                    //         height: 100,
                    //         child: (_cardList.length > 0) ? ListView.builder(
                    //             itemCount: _cardList.length,
                    //             itemBuilder: (context,posision){
                    //               return new Column(
                    //                 children: [
                    //                   new Padding(padding: EdgeInsets.only(bottom: 10)),
                    //                   ListTile(
                    //                     title: Text("${_cardList[posision].address}"),
                    //                   ),
                    //                 ],
                    //               );
                    //             }
                    //         ):Text("لايوجد أحداث هامة تطابق نتيجة البحث",textAlign: TextAlign.center,),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Expanded(
                      child: getListview()
                      ,),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                        child: new MaterialButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                            elevation: 5.0,
                            minWidth: 300.0,
                            height: 40,
                            color: Colors.blue[300],
                            child: new Text('انشاء منشور',
                                style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                            onPressed: () async {
                              bool result = await  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return SelectIcons();
                              }));
                              if(result){
                                addCardListView();
                              }}
                        ))

                  ],
                ),
              ),
            )
        )
    );
  }

  Widget getListview(){
    if(_cardList.length == 0)
      return Center(
          child: Text("لا يوجد منشورات..",
            style: TextStyle(color: Colors.grey[600],fontSize: 20),
          )
      );
    else
    if(_cardList.length != 0)
      return Container(
        color: Colors.grey[300],
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),  //Added
            itemCount: _cardList.length,
            itemBuilder: (BuildContext context, int position) {
              return
                ExpansionTile(
                title: Text(_cardList[position].address),
                // backgroundColor: Colors.grey[400],
                initiallyExpanded: true,
                children: [

                Card(
                  margin: EdgeInsets.only(top: 0,bottom: 2),
                  child:Column(
                    children: [
                      Row(
                          children:[
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Expanded(child: Text(_cardList[position].date.substring(0,16)),),
                            Expanded(
                              child:Padding(
                                padding: const EdgeInsets.only(right: 100),
                                child: DropdownButton(
                                  underline: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(color: Colors.transparent))
                                    ),
                                  ),

                                  icon: new Icon(Icons.more_horiz_outlined),

                                  items: [
                                    DropdownMenuItem(
                                      value: "",
                                      child: Text("حذف"),
                                      onTap: (){
                                        deleteCardListView(_cardList[position].id);
                                      },
                                    ),
                                    DropdownMenuItem(
                                      child: Text("تعديل"),
                                      value: "",
                                      onTap: (){
                                        navigateToDiary(this._cardList[position],"Edit Diary");
                                        updatelistview();
                                      },),

                                  ],
                                  onChanged: (String value){
                                    value = "";
                                  },
                                ),
                              ),),
                            Text('')
                          ]
                      ),

                    Column(
                            children: [
                              Row(
                                children: [
                                  Padding(padding: EdgeInsets.all(10),),

                                  SizedBox(width: 200,),
                                ],
                              ),
                              Row(
                                  children: [
                                    Padding(padding: EdgeInsets.all(10),),
                                    Expanded(child:
                                    Text(_cardList[position].description )
                                    )
                                  ]
                              ),
                              SizedBox(height: 8,),
                              Row(
                                children: [
                                  Expanded(
                                    child: _cardList[position].image == ""
                                        ? Container(height:1,color: Colors.white,)
                                        : Container(
                                      height: 300,
                                      width:MediaQuery.of(context).size.width,
                                      child: Image.file(File(_cardList[position].image),
                                        fit: BoxFit.cover,),
                                    ),
                                  ),
                                ],
                              ),
                            ],)
                    ],
                  ),
              )]  );
            }
        ),
      );
  }
  addCardListView() {
    _futureCardList = db.getAll();
    _futureCardList.then((cardList) {
      setState(() {
        this._cardList = cardList;
      });
    });
  }

  void showSnackBar(BuildContext context,String msg){
    final snackbar = SnackBar(content: Text(msg));
    Scaffold.of(context).showSnackBar(snackbar);

  }

  deleteCardListView(int i) {
    db.deleteobj(i);
    addCardListView();
  }

  void updatelistview(){
    final  dbb = dbs.intDb();
    dbb.then((database){
      Future<List<Diary>> diarys = db. getdiaryList();
      diarys.then((thelist) {
        setState(() {
          this._cardList = thelist;
          this.count = thelist.length;
        });
      });
    });
  }

  void navigateToDiary(Diary diary, String appTitle ) async{
    bool result = await  Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Diaries(diary ,appTitle);
    }));
    if(result != null){

      addCardListView();

    }
  }

}

