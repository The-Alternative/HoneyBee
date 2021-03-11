import 'package:HoneyBee/Config/insert_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class First_date extends StatefulWidget {
  @override
  _First_dateState createState() => _First_dateState();
}

class _First_dateState extends State<First_date> {
  var style1 = TextStyle(fontSize: 23, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: 'Times');
  TextEditingController dateController = TextEditingController();
  TextEditingController clockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
                title: Text(
              " Times",
            )),
            body: Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5),
                child: Card(
                  color: Colors.white,
                  elevation: 15.0,
                  child: get_body(context),
                ))));
  }

  Widget get_body(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 25.0,top: 25),
            child: ListTile(
              title: Text('تاريخ البدء', style: style1),
              trailing: Image.asset("assets/sogatsu.png" ,
                width: 75, height: 75),
            )),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "التاريخ",
                  style: style2,
                ),
                flex: 1,
              ),
              Expanded(
                child: TextFormField(
                  style: style2,
                  expands: false,
                  controller: dateController,
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime(2050, 6, 7),
                        theme: DatePickerTheme(
                            headerColor: Colors.orange,
                            backgroundColor: Colors.blue,
                            itemStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        onConfirm: (date) {
                      // update.udate='confirm $date';
                      print('confirm $date');
                      ch_date('$date');
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.amber),
                  )),
                ),
                flex: 2,
              ),
              Expanded(
                child:Image.asset("assets/calendar3.png" ,
                    width: 50, height: 50),
                flex: 1,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "الساعة",
                  style: style2,
                ),
                flex: 1,
              ),
              Expanded(
                child: TextFormField(
                  style: style2,
                  expands: false,
                  controller: clockController,
                  readOnly: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.amber),
                  )),
                  onTap: () {
                    DatePicker.showTime12hPicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      print('confirm $date');
                      ch_time('$date');
                    }, currentTime: DateTime.now());
                  },
                ),
                flex: 2,
              ),
              Expanded(
                child:Image.asset("assets/clock.png" ,
                    width: 50, height: 50),
                flex: 1,
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                  child: Text(
                    'حفظ',
                    style: style2,
                  ),
                  onPressed: () {
                    update_tdata(dateController.text, clockController.text);
                    succses_moveToLastScreen(context);
                  }),
              flex: 1,
            ),
            Expanded(
              child: FlatButton(
                padding: EdgeInsets.only(),
                child: Text(
                  'الغاء الأمر',
                  style: style2,
                ),
                onPressed: () {
                  clear_tdata();
                  fail_moveToLastScreen(context);
                },
              ),
              flex: 1,
            ),
          ],
        )
      ],
    );
  }

  void ch_time(String s) {
    setState(() {
      String ss= s.substring(11, 16);
      var arr = new List(2);
      arr = ss.split(':');
      clockController.text =arr[0]+":"+arr[1];
    });
  }

  void ch_date(String s) {
    setState(() {
      String ss= s.substring(0, 10);
      var arr = new List(3);
      arr = ss.split('-');
      dateController.text =arr[0]+"/"+arr[1]+"/"+arr[2];
    });
  }

  void succses_moveToLastScreen(BuildContext context1) {
    Navigator.pop(context1, true);
  }

  void fail_moveToLastScreen(BuildContext context1) {
    Navigator.pop(context1, false);
  }

  void update_tdata(String s1, String s2) {
    Entry.first_date = s1; //عدد المرات
    Entry.first_clock = s2;
  }

  void clear_tdata() {
    Entry.first_clock = "";
    Entry.first_date = "";
  }
}