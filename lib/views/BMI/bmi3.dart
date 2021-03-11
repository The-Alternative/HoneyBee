import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honeyBee/dao/bmidao.dart';
import 'package:honeyBee/entity/bmi.dart';
import '../../models/bmi/bmimodels.dart';

class Bmi3 extends StatefulWidget {
  BmiDAO bmiDAO;
  BmiModel bmiModel;

  Bmi3({this.bmiModel, this.bmiDAO});

  @override
  _Bmi3State createState() => _Bmi3State(bmiModel: bmiModel, bmiDAO: bmiDAO);
}

class _Bmi3State extends State<Bmi3> {
  BmiModel bmiModel;
  BmiDAO bmiDAO;

  _Bmi3State({this.bmiModel, this.bmiDAO});
  Future<List<Bmi>> _futureBmiList;
  List<Bmi> _bmiList;

  BmiModel _bmiModel;

  @override
  void initState() {
    //  TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_bmiList == null) {
      _bmiList = List<Bmi>();
      addBmiListView();
    }
    return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 60,
                backgroundColor: Colors.yellow[700],
                title: Row(
                  children: [
                    Image.asset(
                      "assets/group.png",
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'BMI',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              body: new ListView.builder(
                  itemCount: _bmiList.length,
                  itemBuilder: (BuildContext context, int position) {
                    return Padding(
                      padding: const EdgeInsets.only(top:18.0),
                      child: Card(
                        child: Column(children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[500],
                                  spreadRadius: .1,
                                  blurRadius: 1,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),
                            child: Column(children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: 100, left: 100, top: 25),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                          flex: 10,
                                          child: Text(
                                            _bmiList[position]
                                                .date
                                                .substring(0, 10),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[500]),
                                          )),
                                    ],
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "الوزن",
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "الطول",
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "BMI",
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                          "الوضع الصحي",
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          _bmiList[position].weight,
                                        )),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Text(_bmiList[position].height)),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                          _bmiList[position].bmi,
                                          style: TextStyle(
                                              color: color(_bmiList[position].comment),
                                              fontWeight: FontWeight.w900),
                                        )),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                          _bmiList[position].comment,
                                          style: TextStyle(
                                              color: color(_bmiList[position].comment),
                                              fontWeight: FontWeight.w900),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.black38,
                                          ),
                                          onTap: () {
                                            print(
                                                'mooo ${_bmiList[position].id}');
                                            deleteCardListView(
                                                _bmiList[position].id);
                                          },
                                        ))
                                  ],
                                ),
                              ),
                            ]),
                          )
                        ]),
                      ),
                    );
                  })),
        );
  }

  addBmiListView() {
    _futureBmiList = bmiDAO.getAllItemInBmiByUid();
    _futureBmiList.then((bmiList) {
      setState(() {
        this._bmiList = bmiList;
      });
    });
  }

  deleteCardListView(int i) {
    bmiDAO.clearBmiById(i);
    addBmiListView();
  }

  Color color(String comment) {
    switch(comment){
      case 'وزن صحي':
        return Colors.green;
      case 'وزن زائد':
        return Colors.orange;
      case 'سمنة مفرطة':
        return Colors.red;
      case 'نحيف':
        return Colors.blue;

    }
  }

}
