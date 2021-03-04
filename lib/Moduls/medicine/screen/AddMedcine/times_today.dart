import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Times_day extends StatefulWidget {
  @override
  _Times_dayState createState() => _Times_dayState();
}

class _Times_dayState extends State<Times_day> {
  bool _isSwitched = false;
  TextEditingController _timesController = TextEditingController();
  TextEditingController _repeatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
                title: Text(" يوميا",)),
            body: dd(context)));
  }

  void ch_date(String s) {
    setState(() {
      Res.udate2 = s.substring(0, 10);
    });
  }

  void ch_time(String s) {
    setState(() {
      Res.utime = s.substring(11, 16);
    });
  }

  Widget dd(BuildContext context) {
    return ListView(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(5),
        child: Text("المواعيد"),
      ),
      Padding(
          padding: EdgeInsets.all(5),
          child: Card(
              color: Colors.white,
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
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
                                        color: Colors.greenAccent, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: Colors.black38, width: 1.0),
                                  ),
                                  hintText: '',
                                ),
                                controller: _timesController,
                              )),
                          flex: 3,
                        ),
                        Expanded(
                          child: Text("مرة"),
                          flex: 1,
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("تكرار لمدة"),
                          flex: 3,
                        ),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 15.0, right: 15.0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                maxLength: 4,
                                controller: _repeatController,
                                maxLengthEnforced: true,
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.greenAccent, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: Colors.black38, width: 1.0),
                                  ),
                                  hintText: '',
                                ),
                              )),
                          flex: 3,
                        ),
                        Expanded(
                          child: Text("يوم"),
                          flex: 1,
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("مدى الحياة"),
                          flex: 2,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 15.0, left: 15.0, right: 15.0),
                            child: Switch(
                              value: _isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  _isSwitched = value;
                                  print(_isSwitched);
                                });
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Text(""),
                          flex: 1,
                        )
                      ],
                    ),
                    get_time(context),
                    getttime(context)
                  ],
                ),
              )
              )),
      Padding(
        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Colors.white,
                child: Text('حفظ', textScaleFactor: 1.5),
                onPressed: () {
                  setState(() {
                    Res.y = true;
                    Navigator.pop(context, true);
                    //Route route = MaterialPageRoute(builder: (context) => Info());
                    // Navigator.push(context, route);//
                    // debugPrint(Res.y);
                    //    _save();
                  });
                },
              ),
            ),
            Container(
              width: 5.0,
            ),
            Expanded(
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Colors.white,
                child: Text(
                  'الغاء الأمر',
                  textScaleFactor: 1.5,
                ),
                onPressed: () {
                  setState(() {
                    Res.y = false;
                    Navigator.pop(context, true);

                    //    _delete();
                  });
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Widget get_time(BuildContext context) {
    String s = '';
    return Row(
      children: <Widget>[
        IconButton(
            padding: EdgeInsets.only(top: 5, right: 1, left: 5),
            icon: Icon(
              Icons.date_range,
              size: 50,
              color: Colors.blue[500],
            ),
            onPressed: () {
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
                      doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
                  onConfirm: (date) {
                // update.udate='confirm $date';
                print('confirm $date');
                ch_date('$date');
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            }),
        Text("تاريخ البدء"),
        IconButton(
            padding: EdgeInsets.only(top: 5, right: 40, left: 25),
            icon: Icon(
              Icons.access_time_sharp,
              size: 50,
              color: Colors.blue[500],
            ),
            onPressed: () {
              DatePicker.showTime12hPicker(context, showTitleActions: true,
                  onChanged: (date) {
                print('change $date in time zone ' +
                    date.timeZoneOffset.inHours.toString());
              }, onConfirm: (date) {
                print('confirm $date');
                ch_time('$date');
              }, currentTime: DateTime.now());
            }),
        Text("التوقيت"),
      ],
    );
  }

  Widget getttime(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 50, bottom: 25),
            child: Text(Res.udate2)),
        Padding(
            padding: EdgeInsets.only(right: 50, bottom: 25),
            child: Text(Res.utime)),
      ],
    );
  }
}

class Res {
  static String udate2 = DateTime.now().toString().substring(0, 10);
  static String utime = DateTime.now().toString().substring(11, 16);
  static String times = '';
  static String repeat = '';
  static bool y = false;
}

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime currentTime, LocaleType locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }
  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex());
  }
}
