
import 'package:HoneyBee/models/medicine/MedicineInfo.dart';
import 'package:HoneyBee/models/medicine/medicineDays.dart';
import 'package:HoneyBee/views/medicine/ViewTimes/times_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimesList extends StatelessWidget {
  var style10 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w200,
    fontFamily: 'Times',
  );
  var style1 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times');
  var style4 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: 'Times',
      color: Colors.white);
  List<MedicineInfo> cardList;
  List<MedicineDays> daysList;
  final Function setData;
  TimesList(this.cardList,this.daysList,this.setData);
  bool _loading=true;
  @override
  Widget build(BuildContext context) {
    return Mainbuild(context);
  }
  Widget Mainbuild(BuildContext context) {
    //if (!loaded) _loadZones();
    var body =  Column(
      children: <Widget>[
        Container(child: getday())
      ],
    );
    return   body;
  }
  ListView getday() {
    if (daysList.length != 0)
      return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(), //Added
          itemCount: daysList.length,
          itemBuilder: (BuildContext context, int index) {
            MedicineDays day = daysList[index];
            return InkWell(
                onTap: () {},
                child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: new InkWell(
                        child: new Column(
                          children: <Widget>[
                            Container(
                              color: Colors.black12,
                              child: ListTile(
                                  leading: Text(getDayName(day.dayDate)),
                                  title: Row(
                                    children: <Widget>[
                                      Text(
                                        ' ${day.dayDate}',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  )),
                            ),
                            getdaytime(day.dayesId),
                          ],
                        ))));
          });
  }
  String getDayName(String s) {
    var arr = List(3);
    arr = s.split('/');
    int _day = int.parse(arr[2]);
    int _month = int.parse(arr[1]);
    int _year = int.parse(arr[0]);
    var dforma = DateTime(_year, _month, _day);
    var now = DateTime.now();
    var dna = DateFormat.EEEE().format(dforma);
    return '$dna';
  }
  ListView getdaytime(int id) {
    //addTimesListView();
    List<MedicineInfo> selecttimesList = List<MedicineInfo>();
    for (int i = 0; i < cardList.length; i++) {
      if (cardList[i].dayesId == id)
        selecttimesList.add(cardList[i]);
    }
    return ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          ListView.builder(
            //removed Flexible
              shrinkWrap: true,
              physics: ClampingScrollPhysics(), //Added
              itemCount: selecttimesList.length,
              itemBuilder: (BuildContext ct, int ii) {
                return TimesCard(selecttimesList[ii],setData);
              })
        ]);

  }

}
