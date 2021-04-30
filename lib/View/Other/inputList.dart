
import 'file:///D:/New%20folder%20(3)/events/lib/screens/Other/inputCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../ShowTodayTask/taskCard.dart';

class InputList extends StatelessWidget {
  List<dynamic> selecEventList =[];
  final Function fun;
  var style10 = TextStyle(fontSize: 20, fontWeight: FontWeight.w200, fontFamily: 'Times',);
  var style1 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times');
  var style4 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times', color: Colors.white);
  InputList(this.selecEventList, this.fun);
  @override
  Widget build(BuildContext context) {
    return Mainbuild(context);
  }
  Widget Mainbuild(BuildContext context) {
    //if (!loaded) _loadZones();
    var body =  Column(
      children: <Widget>[Container(child:
      getdaytime(),)
      ],
    );
    return   getdaytime();
  }
  ListView getdaytime() {

    return
      ListView.builder(
        //removed Flexible
          shrinkWrap: true,
          physics: ClampingScrollPhysics(), //Added
          itemCount: selecEventList.length,
          itemBuilder: (BuildContext ct, int ii) {
          return InputCard(selecEventList[ii],fun, ii);
          });

  }

}
