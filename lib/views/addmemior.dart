import 'dart:io';
import 'dart:ui';
import 'package:multi_image_picker_example/utils/database.dart';

import '../controllers/diarycontrollers.dart';
import '../models/diary.dart';

import '../views/diaries.dart';
import '../views/selecticons.dart';
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
  List<Diary> diaryL =new List();
  bool widgetVisible = true ;
  bool address;
  bool result =false;


  void showWidget(){
  setState(() {
  widgetVisible = true ;
  });
  }
  void hideWidget(){
    setState(() {
      widgetVisible = false ;
    });
  }

  String value;
  int count = 0;

  final DatabaseConfig dbs = new DatabaseConfig();
  DiaryController db = new DiaryController();

  Future<List<Diary>> _futureCardList;
  List<Diary> _cardList= new List();

  // Diary list;
  String imagePath = '';
  List<String> diaryImages = [];
  // List<Diary> diarylist =new List();
  TextEditingController addressCoontroller;

  @override
  void initState() {

    super.initState();

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
    address =false;
    addressCoontroller = new TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    if (_cardList == null) {
      _cardList = List<Diary>();
      addCardListView();
      updatelistview();
    }

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
            Expanded(
                child: getListview()
            ,),Padding(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
        child: new MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            elevation: 5.0,
            minWidth: 300.0,
            height: 40,
            color: Colors.green,
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


             // Container(
             //  margin:const EdgeInsets.only(top: 0,left: 30,right: 30,bottom: 0),
             //
             //  child:  FloatingActionButton(
             //      onPressed: () {
             //        setState(() {
             //        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectIcons()));
             //        });
             //      },
             //      child: Center(
             //        child: Icon(Icons.add,size: 40,
             //        ),
             //      ),
             //    ),
             //  )
              // RaisedButton(
              //   onPressed: (){
              //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectIcons()));
              //   },
              //   child: Text("إنشاء منشور",style: TextStyle(fontSize: 20,color: Colors.white),),
              //   color: Colors.blue[300],
              // ),

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

               child:
              ListView.builder(
                  shrinkWrap: true, physics: ClampingScrollPhysics(),  //Added
                  itemCount: _cardList.length,
                  itemBuilder: (BuildContext context, int position) {
                return ExpansionTile(title: Text(_cardList[position].date.substring(0,16)),
                  backgroundColor: Colors.greenAccent,initiallyExpanded: true,children: [
                  Card(
                       margin: EdgeInsets.only(top: 5,bottom: 5),
                       child:Column(
                    children: [
                         Row(
                          children:[
                            Expanded(
                             child:Padding(
                                padding: const EdgeInsets.only(right: 250),
                                child: DropdownButton(
                                  underline: Container(
                                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.transparent))
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
                                  DropdownMenuItem(child: Text("تعديل"),
                                    value: "",
                                    onTap: (){
                                      print('${_cardList[position].image}');
                                 //   navigateToDiary(this._cardList[position],"Edit Diary");
                                    // updatelistview();
                                    },),

                                ],
                                onChanged: (String value){
                                  value = "";
                                },
                              ),
                            ),),Text('')
                        ]
                      ),

                  // Divider(color: Colors.grey,),

                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: widgetVisible,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.all(10),),
                              Expanded(child: Text(_cardList[position].address),),
                              SizedBox(width: 200,),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.all(10),),
                              Expanded(child:
                               Text(_cardList[position].description )

                    )]
                          ),
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              Expanded(
                                child: _cardList[position].image == ""
                                    ? Container(height:1,color: Colors.white,)
                                    :getArrayOfPathes(_cardList[position].image)
                                    // : Container(
                                    // height: 300,
                                    // width:MediaQuery.of(context).size.width,
                                    // child: Image.file(File(_cardList[position].image),
                                    //   fit: BoxFit.cover,),),
                          ),
                    ],
                  ),
                ],)
              ),
                ],
              ),
            )],);
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
    result = await  Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Diaries(diary ,appTitle);
    }));
  if(result){
    addCardListView();
  }
  }
  Widget getArrayOfPathes(String s){
    List<String> pathes= List<String>();
    pathes=s.split(':');
    for(var i=0;i<pathes.length-1;i++)
    print(pathes[i]);
     return ListView.builder(
        shrinkWrap: true, physics: ClampingScrollPhysics(),  //Added
    itemCount: pathes.length-1,
    itemBuilder: (BuildContext context, int position) {
        return Card(child:Container(height: 300,width:300 ,child:
        Image.file(File(pathes[position]),
      fit: BoxFit.cover,),));

        });
  }
  //
  // child: File(_cardList[position].image == ""
  // ? Container(height:1,color: Colors.white,)
  //     :getArrayOfPathes(_cardList[position].image)
    // : Container(
    // height: 300,
    // width:MediaQuery.of(context).size.width,
    // child: Image.file(File(_cardList[position].image),
    //   fit: BoxFit.cover,),)


}
