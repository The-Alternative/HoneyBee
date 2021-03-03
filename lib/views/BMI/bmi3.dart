
import '../../controllers/bmi/desccontroller.dart';
import '../../models/bmi/bmimodels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class Bmi3 extends StatefulWidget {
  BmiModel bmiModel;
  Bmi3( {this.bmiModel});

  @override
  _Bmi3State createState() => _Bmi3State(bmiModel: bmiModel);
}

class _Bmi3State extends State<Bmi3> {
  BmiModel bmiModel;

  _Bmi3State({this.bmiModel});

  DescController db = new DescController();
  Future<List<CardInfo>> _futureCardList;
  List<CardInfo> _cardList;
  BmiModel _bmiModel;

  @override
  void initState() {
    //  TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_cardList == null) {
      _cardList = List<CardInfo>();
      addCardListView();
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 60, backgroundColor: Colors.yellow[700],
                title: Row(
                  children: [
                    Image.asset("assets/group.png",),
                    SizedBox(width: 10,),
                    Text('BMI', style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    ),
                  ],
                ),
              ),

              body: new ListView.builder(
                  itemCount: _cardList.length,
                  itemBuilder: (BuildContext context, int position) {
                    return Card(
                      child:Column(children: <Widget>[

                        Container(
                        decoration: BoxDecoration(
                          color:Colors.white,
                          boxShadow:[
                            BoxShadow(color: Colors.grey[500],spreadRadius: .1,blurRadius: 1,offset: Offset(1,1),
                          )],
                        ),
                          child:
                           Column(children: <Widget>[
                            Padding(
                            padding: const EdgeInsets.only(right: 260),
                             child:  Row(
                                children: [
                                  Expanded(flex:1, child: Text(_cardList[position].datt.substring(0,10),
                                    style: TextStyle(fontSize: 15,color: Colors.grey[500]),)),

                                ],)
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(flex: 1, child: Text("الوزن",)),
                                    Expanded(flex: 1, child: Text("الطول",)),
                                    Expanded(flex: 1, child: Text("BMI",)),
                                    Expanded(flex: 2, child: Text("الوضع الصحي",)),

                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(flex: 1, child: Text(_cardList[position].wight,)),
                                    SizedBox(width: 25,),
                                    Expanded(flex: 1, child: Text(_cardList[position].length)),
                                    SizedBox(width: 25,),
                                    Expanded(flex: 1, child: Text(_cardList[position].bmi,
                                      style: TextStyle(
                                          color: color(),
                                          fontWeight: FontWeight.w900),)),
                                    SizedBox(width: 40,),
                                    Expanded(flex: 2, child: Text(_cardList[position].comment,
                                      style: TextStyle(
                                          color: color(),
                                          fontWeight: FontWeight.w900
                                      ),)),

                                    Expanded(flex: 1, child:GestureDetector(child:
                                    Icon(Icons.delete,color: Colors.black38,),
                                      onTap: () {
                                        print('${_cardList[position].id}');
                                        deleteCardListView(_cardList[position].id);
                                      },
                                    ))
                                  ],
                                ),
                              ),

                            ]),
                          )
                        ])
                      ,);
                  })
          ),

        ));
  }
  addCardListView() {
    _futureCardList = db.getAll();
    _futureCardList.then((cardList) {
      setState(() {
        this._cardList = cardList;
      });
    });
  }
  deleteCardListView(int i) {
    db.deleteobj(i);
    addCardListView();
  }

  Color color(){
    if(widget.bmiModel.result >=18.5 && widget.bmiModel.result <=25){
      return Colors.green;
    }else if(widget.bmiModel.result > 25 && widget.bmiModel.result <=30){
      return Colors.orange;
    }
    else if(widget.bmiModel.result > 30){
      return Colors.red;
    }
    else if(widget.bmiModel.result < 18.5){
      return Colors.blue;
    }
  }
}