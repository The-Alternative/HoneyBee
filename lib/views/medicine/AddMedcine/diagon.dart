
import 'package:bassel/constants/const_data.dart';
import 'package:flutter/material.dart';

class Diagonsis extends StatefulWidget {
  @override
  _DiagonsisState createState() => _DiagonsisState();
}
class _DiagonsisState extends State<Diagonsis> {

  TextEditingController path_diag = TextEditingController();
  TextEditingController doct_name = TextEditingController();
  var style1 = TextStyle(fontSize: 23, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: 'Times');

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
                  child: get_Body(),
                ))));
  }

  Widget get_Body() {
    return ListView(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(bottom: 50.0,top: 25,left: 5),
          child: ListTile(
            title: Text('التشخيص', style: style1),
            trailing: Image.asset("assets/doctor.png" ,
              width: 150, height: 150,),
          )),
      Padding(
          padding: EdgeInsets.only(right: 15.0, left: 15, bottom: 15, top: 5),
          child: TextField(
            controller: path_diag,
            style: style2,
            decoration: InputDecoration(
                labelText: 'التشخيص المرضي',
                hintText: "التشخيص المرضي",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          )),
      Padding(
          padding: EdgeInsets.only(right: 15.0, left: 15, bottom: 70, top: 5),
          child: TextField(
            controller: doct_name,
            style: style2,
            decoration: InputDecoration(
                labelText: 'الطبيب',
                hintText: "اسم الطبيب ",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          )),
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
                  update_tdata(doct_name.text, path_diag.text);
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
    ]);
  }

  void succses_moveToLastScreen(BuildContext context1) {
    Navigator.pop(context1, true);
  }

  void fail_moveToLastScreen(BuildContext context1) {
    Navigator.pop(context1, false);
  }

  void update_tdata(String s1, String s2) {
    Entry.doct_name = s1; //عدد المرات
    Entry.pain = s2;
  }

  void clear_tdata() {
    Entry.doct_name = "";
    Entry.pain = "";
  }
}
