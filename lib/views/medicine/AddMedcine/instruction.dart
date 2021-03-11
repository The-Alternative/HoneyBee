import 'package:flutter/material.dart';
import 'package:HoneyBee/Config/insert_data.dart';

class IM {
  String name;
  int index;

  IM({this.name, this.index});
}

class Instruction extends StatefulWidget {
  @override
  _InstructionState createState() => _InstructionState();
}

class _InstructionState extends State<Instruction> {
  List<IM> IList = [
    IM(
      index: 1,
      name: "قبل الطعام",
    ),
    IM(
      index: 2,
      name: "بعد الطعام",
    ),
    IM(
      index: 3,
      name: "أدخل بنفسك",
    )
  ];
  int _radioValue = 0;
  String instTitle = "";
  var style1 = TextStyle(fontSize: 23, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: 'Times');
  TextEditingController instructionController = TextEditingController();

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
                padding:
                    EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0, bottom: 5),
                child: Card(
                  color: Colors.white,
                  elevation: 5.0,
                  child: get_body(),
                ))));
  }

  Widget get_body() {
    return ListView(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 25.0,top:25),
            child: ListTile(
              title: Text('التعليمات', style: style1),
              trailing: Image.asset("assets/medical-book.png" ,
                  width: 120, height: 120),
            )),
        Column(
          children: IList.map((data) => RadioListTile(
                title: Text(
                  "${data.name}",
                  style: style2,
                ),
                groupValue: _radioValue,
                value: data.index,
                onChanged: _handleRadioValueChange,
              )).toList(),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 15, right: 15, bottom: 15),
            child: Row(children: <Widget>[
              Expanded(
                child: get_Row(),
                flex: 1,
              ),
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
                    update_tdata(instTitle);
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
        case 1:
          setState(() {
            instTitle = IList.elementAt(_radioValue - 1).name;
          });
          break;
        case 2:
          setState(() {
            instTitle = IList.elementAt(_radioValue - 1).name;
          });

          break;
        case 3:
          break;
      }
    });
  }

  Widget get_Row() {
    if (_radioValue == 3)
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: (TextField(
          controller: instructionController,
          style: style2,
          onSubmitted: (value) {
            instTitle = value;
          },
          decoration: InputDecoration(
              labelText: 'ادخل بنفسك',
              hintText: " تعليمات......",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        )),
      );
    else
      return (Text(""));
  }

  void succses_moveToLastScreen(BuildContext context1) {
    Navigator.pop(context1, true);
  }

  void fail_moveToLastScreen(BuildContext context1) {
    Navigator.pop(context1, false);
  }

  void update_tdata(String s1) {
    Entry.instruc = s1; //عدد المرات
  }

  void clear_tdata() {
    Entry.instruc = "";
  }
}
