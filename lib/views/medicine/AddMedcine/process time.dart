import 'package:bassel/Config/general.dart';
import 'package:bassel/Config/insert_data.dart';
import 'package:flutter/material.dart';

class Process_time extends StatefulWidget {
  @override
  _Process_timeState createState() => _Process_timeState();
}

class _Process_timeState extends State<Process_time> {

  int _radioValue = 0;
  String _selectedDay = limitedPeriodList[0];
  var style1 = TextStyle(fontSize: 23, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: 'Times');
  TextEditingController teratControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
                title: Text(" Times",)),
            body: Padding(padding: EdgeInsets.only(top: 5.0, bottom: 5),
                child: Card(color: Colors.white, elevation: 15.0, child: get_body(),))));
  }
  Widget get_body() {
    return ListView(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 15),
            child: ListTile(
              title: Text('مدة العلاج', style: style1,),
              trailing: Image.asset("assets/future.png" ,
                  width: 150, height: 150,)),),
        Padding(padding: const EdgeInsets.only(top: 50, right: 15),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Radio(value: 0, groupValue: _radioValue, onChanged: _handleRadioValueChange,), flex: 0,),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    child: DropdownButtonHideUnderline(
                      child: TextFormField(style: style2, expands: false, keyboardType: TextInputType.number,
                        controller: teratControl, decoration: InputDecoration(enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.amber),)),),)), flex: 1,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InputDecorator(
                      expands: false,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.amber),
                      )),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          style: style2,
                          // Not necessary for Option 1
                          value: _selectedDay,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedDay = newValue;
                            });
                          },
                          items: limitedPeriodList.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      )),
                ),
                flex: 2,
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 15, right: 15, bottom: 50),
            child: Row(children: <Widget>[
              Expanded(
                child: Radio(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                flex: 0,
              ),
              Expanded(child: Text("مدى الحياة")),
            ])),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                  child: Text(
                    'حفظ',
                    style: style2,
                  ),
                  onPressed: () {
                    update_tdata(_selectedDay, int.parse(teratControl.text));
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
              flex: 0,
            ),
          ],
        )
      ],
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  void succses_moveToLastScreen(BuildContext context1) {
    Navigator.pop(context1, true);
  }

  void fail_moveToLastScreen(BuildContext context1) {
    Navigator.pop(context1, false);
  }

  void update_tdata(String s1, int amount) {
    Entry.teratment_days = calc_teatTime(s1, amount).toString(); //عدد المرات
  }

  void clear_tdata() {
    Entry.teratment_days = "";
  }

  int calc_teatTime(String s, int amount) {
    switch (s) {
      case 'أسبوع':
        return (7 * amount);
        break;
      case 'شهر':
        return (30 * amount);
        break;
      default:
        return (amount);
    }
  }
}
