import '../../../Config/general.dart';
import '../../../Config/insert_data.dart';
import '../../../utils/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'manual_entry.dart';

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
  String _selectedDay = limitedPeriodList[0];
  // Default Radio Button Item
  String radioItem = '';
  int _radioValue = 0;
  int id = 0;
  List<TM> fList = [TM(index: 1, name: "يوميا",), TM(index: 2, name: "أسبوعيا",), TM(index: 3, name: "شهريا",),
    TM(index: 4, name: "سنوي",), TM(index: 5, name: "أيام محددة من الأسبوع",), TM(index: 6, name: "إدخال يدوي",),];
  var style1 = TextStyle(fontSize: 23, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: 'Times');
  TextEditingController times_numController = TextEditingController();

  Widget build(BuildContext context) {
    RadioGroupWidget();
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(title: Text(" Times",)),
            body: Padding(padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0, bottom: 5),
                child: Card(color: Colors.white, elevation: 5.0, child: dd(context),
                ))));
  }

  Widget dd(BuildContext context) {
    // clear_tdata();
    return ListView(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 5),
            child: ListTile(
              title: Text('المواعيد', style: style1,),
              trailing: Image.asset("assets/calendar2.png" ,
                  width: 150, height: 150),
            )),
        Column(
          children: fList
              .map((data) => RadioListTile(
                    title: Text("${data.name}", style: style2,),
                    groupValue: _radioValue,
                    value: data.index,
                    onChanged: _handleRadioValueChange
                  )).toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15, right: 15),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Radio(value: 7, groupValue: _radioValue, onChanged: _handleRadioValueChange,), flex: 0,),
              Expanded(
                child: Text("كل", style: style2,), flex: 0,),
              Expanded(
                child: Padding(padding: const EdgeInsets.only(left: 6, right: 6),
                    child: DropdownButtonHideUnderline(
                      child: TextFormField(controller:controllerEvery,style: style2, expands: false, keyboardType: TextInputType.number,
                        decoration: InputDecoration(enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.amber),
                        )),
                      ),
                    )),
                flex: 1,
              ),
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
                              print(_selectedDay);
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
        )
      ,        Padding(
          padding: const EdgeInsets.only(bottom: 15,top:2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>
            [
              Expanded(
                child: FlatButton(child: Text('حفظ', style: style2,),
                    onPressed: () {
                  if(Entry.code =='every' && controllerEvery.text !=''){
                   // print ('addel');
                    if(_selectedDay =='يوم' )
                      Entry.incAmount= int.parse(controllerEvery.text)*24 ;

                    if(_selectedDay =='أسبوع')
                      Entry.incAmount= int.parse(controllerEvery.text)*7*24 ;

                    if(_selectedDay =='شهر')
                      Entry.incAmount= int.parse(controllerEvery.text)*30 *24;

                    update_tdata('1','every');
                      //succses_moveToLastScreen();
                  }
                    }), flex: 1,),
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.only(),
                  child: Text('الغاء الأمر', style: style2,),
                  onPressed: () {
                    clear_tdata();
                  },
                ), flex:1,),
            ],
          ),
        )
      ],
    );
  }

  void succses_moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void fail_moveToLastScreen() {
    Navigator.pop(context, false);
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          _showAddNoteDialog(context, 'يوميا', 'باليوم');
          break;
        case 2:
          _showAddNoteDialog(context, 'أسبوعيا', 'بالأسبوع');
          break;
        case 3:
          _showAddNoteDialog(context, 'شهريا', 'بالشهر');
          break;
        case 4:
          _showAddNoteDialog(context, 'سنويا', 'بالسنة');
          break;
        case 5:
          Entry.code ='selctedday';

          _showMultipleChoiceDialog(context);
          break;
        case 6:
          Entry.code ='Manual_entry';
          navigateTo_manual();

          break;
        case 7:
          Entry.code ="every";

          break;
      }
    });
  }

  void navigateTo_manual() async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Manual_entry();
    }));
    if(result)
      succses_moveToLastScreen();

  }

  void navigateToDetail(String title) async {
    switch (title) {
      case 'يوميا':
        _showAddNoteDialog(context, 'يوميا', 'باليوم');

        // bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return Times_day();
        // }));
        break;
      case 'أسبوعيا':
        break;
      case 'أيام محددة من الأسبوع':
        _showMultipleChoiceDialog(context);
       // print(selecteItems.length);

        break;
      case 'سنوي':
        break;
      case 'شهريا':
        _showAddNoteDialog(context, 'شهريا', 'بالشهر');

        break;
      case 'كل':
        // _displayTextInputDialog(context);

        break;
      case 'إدخال يدوي':
        Entry.code ='Manual_entry';
        bool result =
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Manual_entry();
        }));
        if(result)
          succses_moveToLastScreen();
        break;
    }
  }


  _showMultipleChoiceDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        final _multipleNotifier = Provider.of<MultipleNotifier>(context);
        return AlertDialog(
          content: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: weekDaysList
                      .map((e) => CheckboxListTile(
                            title: Text(e,),
                            onChanged: (value) {
                              value
                                  ? _multipleNotifier.addItem(e)
                                  : _multipleNotifier.removeItem(e);
                            },
                            value: _multipleNotifier.isHaveItem(e),
                          ))
                      .toList(),
                )),
          ),
          actions: [
            FlatButton(
              padding: EdgeInsets.only(right: 75),
              child: Text('الغاء الأمر', style: style2,),
              onPressed: () {
                Navigator.of(context).pop();
                selecteItems.clear();
              },
            ),
            FlatButton(child: Text('حفظ', style: style2,),
              onPressed: () {
                Navigator.of(context).pop();
                selecteItems = _multipleNotifier.selectedItems;
              },
            ),
          ],
        );
      });

  _showAddNoteDialog(BuildContext context, String s1, String s2) => showDialog(

        context: context,
        builder: (context) {
          int x;
          if(s2 == 'باليوم')  x=1;
          else             x=2;
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
                          keyboardType: TextInputType.number,maxLength:x,
                          decoration: InputDecoration(
                              prefixStyle: TextStyle(color: Colors.amber),
                              hintText: ' عدد المرات ' + s2,
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
                      succses_moveToLastScreen();
                    },
                  ),
                  FlatButton(
                    child: Text("الغاء الأمر"),
                    onPressed: () {
                      clear_tdata();
                      fail_moveToLastScreen();
                    },
                  ),
                ],
              ));
        },
      );
  void update_tdata(String s1, String s2) {
    Entry.times_num = s1; //عدد المرات
    Entry.code = s2;
    succses_moveToLastScreen();
  }

  void clear_tdata() {
    Entry.code = "";
    Entry.times_num = "";
    Entry.incAmount=0;
    fail_moveToLastScreen();
  }
}
Future<void> _displayTextInputDialog(BuildContext context) async {
  showGeneralDialog(context: context, barrierDismissible: true, barrierLabel:
  MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.height - 100,
                  padding: EdgeInsets.all(0),
                  color: Colors.white,
                  child: Center(
                    child: Scaffold(
                      body: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text("عدد المرات باليوم"),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.0, left: 15.0, right: 15.0),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        maxLength: 2,
                                        maxLengthEnforced: true,
                                        decoration: new InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.greenAccent,
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  color: Colors.black38,
                                                  width: 1.0),
                                            ),
                                            hintText: ''),
                                        //controller: timesController
                                      )),
                                  flex: 4,
                                ),
                                Expanded(
                                  child: Text("مرة"),
                                  flex: 1,
                                )
                              ],
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xFF1BC0C5),
                          )
                        ],
                      ),
                    ),
                  )),
            ));
      });
}
