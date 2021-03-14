import '../../views/children/AddChild.dart';
import '../../Controller/children/childController.dart';
import '../../models/children/child.dart';
import '../../views/children/ChildDevelopment.dart';
import '../../views/children/ChildEvents.dart';
import '../../views/children/ChildHealth.dart';
import '../../views/children/ChildInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'ChildHabits.dart';
import 'Habits.dart';


class Search extends StatefulWidget{
  final Child child;
  Search(this.child);
  @override
  State<StatefulWidget> createState() {
    return new SearchState();
  }

}
class SearchState extends State<Search>{
  DateTime _selectedDate;
  TextEditingController _fromDateController;
  TextEditingController _toDateController;
  bool health;
  bool event;
  bool development;
  bool habit;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _fromDateController = new TextEditingController(text:"" );
    _toDateController = new TextEditingController(text:"" );
    health = false;
    event = false;
    development =false;
    habit = false;

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "Search",
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
                  new Padding(padding: EdgeInsets.only(bottom: 40.0)),

                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Expanded(
                        child:new Text('',style: TextStyle(color: Colors.grey,fontSize: 18.0),) ,
                      ),
                      new Text('اختر',style: TextStyle(color: Colors.grey,fontSize: 18.0),),
                      Padding(padding: EdgeInsets.only(left: 30.0)),
                    ],
                  ),
                  new Row(
                    children: [
                      new Expanded(child: Text("")),
                      new Container(
                          padding: EdgeInsets.only(top: 30.0,bottom: 25.0),
                          child: new Column(
                            children: [
                              new MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    habit = !habit;
                                    event = false;
                                    development = false;
                                    health = false;
                                  });
                                },
//                                    () => _childHabits(context) ,
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
                                onPressed:() {
                                  setState(() {
                                    event = !event;
                                    health = false;
                                    development = false;
                                    habit = false;
                                  });
                                },
//                                    () => _childEvents(context),
                                color: Colors.white,
                                child: Image.asset("assets/images/events.png",width: 50,height: 50,),
                                shape: CircleBorder(side: BorderSide(
                                    color: Colors.white
                                )),
                                splashColor: Colors.white,
                                highlightColor: Colors.white,

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
                                onPressed: () {
                                  setState(() {
                                    development = !development;
                                    event = false;
                                    health = false;
                                    habit = false;
                                  });
                                },
//                                    () => _childDevelopments(context),
                                color: Colors.white,
                                child: Image.asset("assets/images/developments.png",width: 50,height: 50,),
                                shape: CircleBorder(side: BorderSide(
                                    color: Colors.white
                                )),
                                splashColor: Colors.white,
                                highlightColor: Colors.white,

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
                                onPressed: () {
                                  setState(() {
                                    health = !health;
                                    event = false;
                                    development = false;
                                    habit = false;
                                  });
                                },
//                                    () => _childHealths(context,widget.child) ,
                                color: Colors.white,
                                child: Image.asset("assets/images/helth.png",width: 50,height: 50,),
                                shape: CircleBorder(side: BorderSide(
                                    color: Colors.white
                                )),
                                splashColor: Colors.white,
                                highlightColor: Colors.white,

                              ),

                              new Text('الصحة')
                            ],
                          )
                      ),
                      new Expanded(child: Text("")),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15.0)),
                  new Center(
                      child: new Container(
                        width: MediaQuery.of(context).size.width *0.9,
                        child: new TextField(
                          focusNode: AlwaysDisabledFocusNode(),
                          controller: _fromDateController,
                          onTap: () {
                            _selectFromDate(context);
                          },
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.datetime ,
                          style: TextStyle(fontSize: 18.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                          decoration: InputDecoration(
                            labelStyle: new TextStyle(
                                color: Colors.amberAccent
                            ),
                            focusedBorder:UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.amberAccent, width: 1.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.amberAccent),
                            ),
                            hintText: 'من تاريخ',
                            hintStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15.0)),
                  new Center(
                      child: new Container(
                        width: MediaQuery.of(context).size.width *0.9,
                        child: new TextField(
                          focusNode: AlwaysDisabledFocusNode(),
                          controller: _toDateController,
                          onTap: () {
                            _selectToDate(context);
                          },
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.datetime ,
                          style: TextStyle(fontSize: 18.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                          decoration: InputDecoration(
                            labelStyle: new TextStyle(
                                color: Colors.amberAccent
                            ),
                            focusedBorder:UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.amberAccent, width: 1.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.amberAccent),
                            ),
                            hintText: 'الى تاريخ',
                            hintStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                  ),
                  new Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.15)),
                  new Center(
                    child: new Container(
                      width: MediaQuery.of(context).size.width *0.7,
                      child: new Row(
                        children: [
                          new FlatButton(
                            child:new Text('استعراض',style: new TextStyle(fontSize: 19.0,color: Colors.black45)),
                            onPressed:() => _navigateToSearch(context) ,
                          ),
                          new Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width *0.15 )),
                          new FlatButton(
                              onPressed:() => _back(context) ,
                              child: new Text('إلغاء الأمر',style: new TextStyle(fontSize: 19.0,color: Colors.black45),)),
                        ],
                      ),
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
  void _back(BuildContext context) async{
    Navigator.pop(context);
  }
//
//  void _childEvents(BuildContext context) async{
//    String result = await Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => ChildEvents(widget.child)));
//  }

  void _navigateToSearch(BuildContext context) async{
    if(!(_fromDateController.text == '') && !(_toDateController.text == '')){

    if(health){
      await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChildHealth(widget.child,_fromDateController.text,_toDateController.text)));
    }
    if(habit){
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChildHabits(widget.child,_fromDateController.text,_toDateController.text)));
    }
    if(development){
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChildDevelopments(widget.child,_fromDateController.text,_toDateController.text)));
    }
    if(event){
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChildEvents(widget.child,_fromDateController.text,_toDateController.text)));
    }else{
      _showMaterialDialogForIcons();
    }
    }else{
      _showMaterialDialog();
    }

  }

//  void _childDevelopments(BuildContext context) async{
//    String result = await Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => ChildDevelopments(widget.child)));
//  }
  _selectFromDate(BuildContext context) async {
    DateTime fromSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.white,
                onPrimary: Colors.deepOrange,
                surface: Colors.grey,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.amberAccent,
            ),
            child: child,
          );
        });

    if (fromSelectedDate != null) {
      _selectedDate = fromSelectedDate;
      _fromDateController
        ..text = DateFormat("yyyy-MM-dd hh:mm:ss").format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _fromDateController.text.length,
            affinity: TextAffinity.upstream));

    }

  }

  _selectToDate(BuildContext context) async {
    DateTime fromSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.white,
                onPrimary: Colors.deepOrange,
                surface: Colors.grey,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.amberAccent,
            ),
            child: child,
          );
        });

    if (fromSelectedDate != null) {
      _selectedDate = fromSelectedDate;
      _toDateController
        ..text = DateFormat("yyyy-MM-dd hh:mm:ss").format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _toDateController.text.length,
            affinity: TextAffinity.upstream));

    }

  }
  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("يرجى إدخال التواريخ"),
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

  _showMaterialDialogForIcons() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("يرجى إختيار أيقونة للبحث"),
          content: new Text(""),
          actions: <Widget>[
            FlatButton(
              child: Text('حسنا'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ));
  }

}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}