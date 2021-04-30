
import 'package:flutter/material.dart';
import 'package:flutter_task/Config/general.dart';
import 'package:flutter_task/Config/insert_data.dart';
import 'package:provider/provider.dart';

class Radiooo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RadioGroupWidget();
  }
}

class TM {
  String name;
  int index;
  TM({this.name, this.index});
}

List<String> selecteItems;

class RadioGroupWidget extends State<Radiooo> {
  TextStyle Style1 =
  TextStyle(fontSize: 23, fontWeight: FontWeight.bold, fontFamily: 'Amiri');
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController controllerEvery =TextEditingController();
  String codeDialog;
  String _valueText;
  String _selectedDay = RepeatList[0];
  // Default Radio Button Item
  String radioItem = '';
  int _radioValue = 0;
  int id = 0;
  List<TM> fList = [TM(index: 1, name: "يوميا",), TM(index: 2, name: "أسبوعيا",), TM(index: 3, name: "شهريا",),
    TM(index: 4, name: "سنوي",), TM(index: 5, name: "أيام محددة من الأسبوع",),];
  var style1 = TextStyle(fontSize: 23, fontWeight: FontWeight.bold, fontFamily: 'Schyler');
  var style2 = TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: 'Schyler');
  TextEditingController times_numController = TextEditingController();

  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: dd(context));
  }

  Widget dd(BuildContext context) {
    // clear_tdata();
    return ListView(     physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 5),
            ),
        Column(
          children: fList
              .map((data) => RadioListTile(
              title: Text("${data.name}", style: style2,),
              groupValue: _radioValue,
              value: data.index,
              onChanged: _handleRadioValueChange
          )).toList(),
        ),

      ],
    );
  }

  void succses_moveToLastScreen() {
  //  Navigator.pop(context, true);
  }

  void fail_moveToLastScreen() {
    //Navigator.pop(context, false);
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          _showAddNoteDialog(context, 'يوميا', 'الأيام');
          break;
        case 2:
          _showAddNoteDialog(context, 'أسبوعيا', 'الأسابيع');
          break;
        case 3:
          _showAddNoteDialog(context, 'شهريا', 'الشهور');
          break;
        case 4:
          _showAddNoteDialog(context, 'سنويا', 'السنين');
          break;
        case 5:
          Entry.code ='selctedday';

         // _showMultipleChoiceDialog(context);
          break;

      }
    });
  }


  // _showMultipleChoiceDialog(BuildContext context) => showDialog(
  //     context: context,
  //     builder: (context) {
  //       final _multipleNotifier = Provider.of<MultipleNotifier>(context);
  //       return AlertDialog(
  //         content: SingleChildScrollView(
  //           child: Container(
  //               width: double.infinity,
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: weekDaysList
  //                     .map((e) => CheckboxListTile(
  //                   title: Text(e,),
  //                   onChanged: (value) {
  //                     value
  //                         ? _multipleNotifier.addItem(e)
  //                         : _multipleNotifier.removeItem(e);
  //                   },
  //                   value: _multipleNotifier.isHaveItem(e),
  //                 ))
  //                     .toList(),
  //               )),
  //         ),
  //         actions: [
  //           FlatButton(
  //             padding: EdgeInsets.only(right: 75),
  //             child: Text('الغاء الأمر', style: style2,),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               selecteItems.clear();
  //             },
  //           ),
  //           FlatButton(child: Text('حفظ', style: style2,),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               selecteItems = _multipleNotifier.selectedItems;
  //             },
  //           ),
  //         ],
  //       );
  //     });

  _showAddNoteDialog(BuildContext context, String s1, String s2) => showDialog(

    context: context,
    builder: (context) {

      return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(s1),
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,maxLength:2,
                      decoration: InputDecoration(
                          prefixStyle: TextStyle(color: Colors.amber),
                          hintText: ' عدد ' + s2,
                          icon: Icon(Icons.note_add)),
                      controller: times_numController,
                    )
                  ],
                ),
              ),
            ),
            actions: [
              FlatButton(
                child: Text("حفظ"),
                onPressed: () {
                  update_tdata(times_numController.text,
                      fList.elementAt(_radioValue-1).name);
               Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text("الغاء الأمر"),
                onPressed: () {
                  clear_tdata();
                  Navigator.pop(context, false);
                },
              ),
            ],
          ));
    },
  );
  void update_tdata(String s1, String s2) {
    Entry.incAmount = int .parse(s1); //عدد المرات
    Entry.code = s2;
    print(Entry.incAmount);    print(s2);

    succses_moveToLastScreen();
  }

  void clear_tdata() {
    Entry.code = "";
    Entry.times_num = "";
    Entry.incAmount=0;
    fail_moveToLastScreen();
  }
}
