import 'dart:io';
import '../../../Config/general.dart';
import '../../../Config/insert_data.dart';
import '../../../controllers/medicine/diagonController.dart';
import '../../../controllers/medicine/medicineController.dart';
import '../../../controllers/medicine/medicineDayController.dart';
import '../../../controllers/medicine/patientController.dart';
import '../../../controllers/medicine/timesDayesController.dart';
import '../../../models/medicine/Diagon.dart';
import '../../../models/medicine/Medicine.dart';
import '../../../models/medicine/MedicineTimes.dart';
import '../../../models/medicine/Medicine_Date.dart';
import '../../../models/medicine/Medicine_clocl.dart';
import '../../../models/medicine/Patient.dart';
import '../../../models/medicine/alarm_info.dart';
import '../../../models/medicine/medicineDays.dart';
import '../../../notifications/notifications.dart';
import '../../../utils/alarm_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import '../ViewTimes/times_list.dart';
import 'times_radioButton.dart';
import 'process time.dart';
import 'another_image.dart';
import 'diagon.dart';
import 'first_date.dart';
import 'instruction.dart';

class Main_input extends StatefulWidget {
  @override
  _Main_inputState createState() => _Main_inputState();
}

class _Main_inputState extends State<Main_input> {
  DateTime _alarmTime;
  File _image;
  File _savedImage;
  final picker = ImagePicker();
  TextEditingController _nameController = TextEditingController();
  DiagonController _diagonController =DiagonController();
  MedicineController _medicineController = MedicineController();
  MedicineDayController _medicineDayController =MedicineDayController();
  PatientController _patientController =PatientController();
  TimesDayesController _timesDayesController =TimesDayesController();
  AlarmHelper _alarmHelper =AlarmHelper();
  String _appBarTitle;
  Medicine _medicin = Medicine();
  Patient _patient = new Patient.Without();
  Diagon _diagonObject = Diagon();
  //MedicineTimes _timesObject = MedicineTimes.WithId();
  TextEditingController _patnameController = TextEditingController();
  TextEditingController _noticeController = TextEditingController();
  TextEditingController _medTitleController = TextEditingController();
  TextEditingController _medAmountController = TextEditingController();
  TextEditingController _imgDirectController = TextEditingController();
  int _day, _month, _year;
  int _lastDay, _diagonId;
  int _hour;
  int alarmId;
  int _teartmentClock = 24;
  int _menuts, d;
  List<Medicine_clocl> _clockList;
  List<Medicine_Date> _dateList;
  bool insr;
  var style1 =
  TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times');
  var style4 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: 'Times',
      color: Colors.white);
  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
    });
    if (Alarmmm.alarmList == null)
      Alarmmm.alarmList = List<DateTime>();
    else
      Alarmmm.alarmList.clear();

    Alarmmm.alarmList.clear();
    Entry.imgPath = '';
    Entry.pat_name = '';
    Entry.doct_name = '';
    Entry.times_num = '';
    Entry.code = '';
    Entry.incAmount = 0;
    Entry.first_date = '';
    Entry.first_clock = '';
    Entry.teratment_days = '';
    Entry.instruc = '';
    Entry.pain = '';
    Entry.imgPath = '';
    // Entry.info.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var style3 = TextStyle(color: Colors.black, fontFamily: 'Amiri');
    return MaterialApp(
        home: Directionality(
            textDirection: TextDirection.rtl, child: homePage()));
  }

  Widget homePage() {
    return Scaffold(
      appBar: AppBar(
        title: Text("kk"),
      ),
      body: ListView(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Expanded(
              child: Padding(
                  padding:
                  EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
                  child: Text("17:35")),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                  padding:
                  EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 5),
                  child: Text("20/12/2020")),
              flex: 0,
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: _image == null ? null : FileImage(_image),
                radius: 75,
                foregroundColor: Colors.amber,
                backgroundColor: Colors.white,
              ),
              GestureDetector(onTap: _getImage, child: Icon(Icons.camera_alt))
            ],
          ),
          Padding(
              padding:
              EdgeInsets.only(right: 15.0, left: 15, bottom: 15, top: 50),
              child: TextField(
                controller: _patnameController,
                onSubmitted: (value) {},
                style: style2,
                decoration: InputDecoration(
                    labelText: 'اسم المريض',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                      borderRadius: BorderRadius.circular(15),
                    )),
              )),
          Padding(
              padding:
              EdgeInsets.only(right: 15.0, left: 15, bottom: 15, top: 5),
              child: TextField(
                controller: _medTitleController,
                style: style2,
                decoration: InputDecoration(
                    labelText: 'اسم الدواء',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              )),
          Padding(
              padding:
              EdgeInsets.only(right: 15.0, left: 15, bottom: 15, top: 5),
              child: TextField(
                controller: _medAmountController,
                style: style2,
                decoration: InputDecoration(
                    labelText: 'الجرعة',
                    hintText: "1 كبسولة",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              )),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox.fromSize(
                  size: Size(100, 100), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.black12, // button color
                      child: InkWell(
                        splashColor: Colors.green, // splash color
                        onTap: () async {
                          bool result = await Navigator.push(this.context,
                              MaterialPageRoute(builder: (context) {
                                return Radiooo();
                              }));
                          if (result == true) {
                            update_mtTitle();
                            print(Entry.code + Entry.times_num);
                          }
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/calendar2.png",
                              width: 50,
                              height: 50,
                            ), // icon
                            Text(
                              "المواعيد",
                              style: style2,
                            ), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox.fromSize(
                  size: Size(100, 100), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.black12, // button color
                      child: InkWell(
                        splashColor: Colors.green, // splash color
                        onTap: () async {
                          bool result = await Navigator.push(this.context,
                              MaterialPageRoute(builder: (context) {
                                return First_date();
                              }));
                          if (result == true) {
                            update_Firstdate();
                            print(Entry.first_clock + Entry.first_date);
                          }
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/sogatsu.png",
                              width: 50,
                              height: 50,
                            ), // icon
                            Text(
                              "تاريخ البدء",
                              style: style2,
                            ), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox.fromSize(
                  size: Size(100, 100), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.black12, // button color
                      child: InkWell(
                        splashColor: Colors.green, // splash color
                        onTap: () async {
                          bool result = await Navigator.push(this.context,
                              MaterialPageRoute(builder: (context) {
                                return Process_time();
                              }));
                          if (result == true) {
                            updateteartTime();
                            print(Entry.teratment_days);
                          }
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/future.png",
                              width: 50,
                              height: 50,
                            ), // icon
                            Text(
                              "مدة العلاج",
                              style: style2,
                            ), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox.fromSize(
                    size: Size(100, 100), // button width and height
                    child: ClipOval(
                      child: Material(
                        color: Colors.black12, // button color
                        child: InkWell(
                          splashColor: Colors.green, // splash color
                          onTap: () async {
                            bool result = await Navigator.push(this.context,
                                MaterialPageRoute(builder: (context) {
                                  return Instruction();
                                }));
                            if (result == true) {
                              updateInstruction();
                              debugPrint(Entry.instruc);
                            }
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/medical-book.png",
                                width: 50,
                                height: 50,
                              ), // icon
                              Text(
                                "التعليمات",
                                style: style2,
                              ), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size(100, 100), // button width and height
                    child: ClipOval(
                      child: Material(
                        color: Colors.black12, // button color
                        child: InkWell(
                          splashColor: Colors.green, // splash color
                          onTap: () async {
                            bool result = await Navigator.push(this.context,
                                MaterialPageRoute(builder: (context) {
                                  return Diagonsis();
                                }));
                            if (result == true) {
                              update_diagon();
                              print(Entry.pain + Entry.doct_name);
                            }
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/doctor.png",
                                width: 50,
                                height: 50,
                              ), // icon
                              Text(
                                "التشخيص",
                                style: style2,
                              ), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size(100, 100), // button width and height
                    child: ClipOval(
                      child: Material(
                        color: Colors.black12, // button color
                        child: InkWell(
                          splashColor: Colors.green, // splash color
                          onTap: () async {
                            bool result = await Navigator.push(this.context,
                                MaterialPageRoute(builder: (context) {
                                  return ImageSave();
                                }));
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/Path105.png",
                                width: 50,
                                height: 50,
                              ), // icon
                              Text(
                                "مرفقات",
                                style: style2,
                              ), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
          Padding(
              padding:
              EdgeInsets.only(right: 15.0, left: 15, bottom: 0, top: 15),
              child: TextField(
                controller: _noticeController,
                style: style2,
                decoration: InputDecoration(
                    labelText: 'ملاحظات',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              )),
          Divider(
            color: Colors.amber,
          ),
          ListTile(
            title: Text(
              "إظهار المواعيد",
              style: style1,
            ),
            subtitle: Text(
              "إظهار مواعيد هذا الدواء في قائمة المهام في الصفحة الرئيسية للتطبيق",
              style: style2,
            ),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                setState(() {});
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ),
          Divider(
            color: Colors.amber,
          ),
          ListTile(
            leading: Icon(Icons.music_note, size: 50, color: Colors.black),
            title: Text(
              "نغمة الرنين",
              style: style1,
            ),
            trailing: DropdownButton(),
          ),
          Divider(
            color: Colors.amber,
          ),
          ListTile(
            leading: Icon(Icons.palette, size: 50, color: Colors.black),
            title: Text("اللون", style: style1),
            trailing: DropdownButton(),
          ),
          Divider(
            color: Colors.amber,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                      color: Colors.green,
                      padding: EdgeInsets.only(
                          left: 35, right: 35, top: 15, bottom: 5),
                      child: Text(
                        "موافق",
                        style: style4,
                      ),
                      onPressed: () {
                        setState(() {
                          _save();

                        });
                        print('Nooooooooha ${Alarmmm.alarmList.length}');
                      }),
                  MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.only(
                          left: 35, right: 35, top: 15, bottom: 5),
                      child: Text("الغاء الأمر", style: style4),
                      onPressed: () {
                        //  _cancel();
                        Timesupdate.res = true;
                        moveToLastScreen();
                      })
                ]),
          )
        ],
      ),
    );
  }

  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    setState(() {
      _image = image;
    });
  }

  void update_patname() {
    _patient.patName = _patnameController.text;
  }

  void update_medTitle() {
    _medicin.medTitle = _medTitleController.text;
  }

  void update_medAmount() {
    _diagonObject.medAmount = _medAmountController.text;
  }

  void update_mtTitle() {
    _diagonObject.times = Entry.times_num;
    if (Entry.code == 'يوميا') {
      _teartmentClock = 24;
    } else if (Entry.code == 'أسبوعيا') {
      _teartmentClock = 7 * 24;
    } else if (Entry.code == 'شهريا') {
      _teartmentClock = 28 * 24;
    } else if (Entry.code == 'سنوي') {
      _teartmentClock = 28 * 12 * 24;
    } else if (Entry.code == 'every') {
      _teartmentClock = Entry.incAmount;
    }

    print('mosa here :$_teartmentClock');
  }

  void updateteartTime() {
    _diagonObject.dayes = Entry.teratment_days;
  }

  void updateInstruction() {
    _diagonObject.instruction = Entry.instruc;
  }

  void update_Firstdate() {
    _diagonObject.firstClock = Entry.first_clock;
    _diagonObject.firstDate = Entry.first_date;
    var arr = List(3);

    arr = Entry.first_date.split('/');
    _day = int.parse(arr[2]);
    _month = int.parse(arr[1]);
    _year = int.parse(arr[0]);
    print(_month);
    arr = Entry.first_clock.split(':');
    _hour = int.parse(arr[0]);
    _menuts = int.parse(arr[1]);
    print(_hour);
  }

  void update_diagon() {
    _diagonObject.doctName = Entry.doct_name;
    _diagonObject.diagon = Entry.pain;
  }

  void update_relatedMed() {
    //.description = relatedMedTitleController.text;
  }
  void update_doctname() {
    // diagon.doctName = doctnameController.text;
  }
  void update_img_direct() {
    // _diagonObject.img_direct = _imgDirectController.text;
  }

////////////////////////////////////////////////////////////////////////////
  void _save() async {
    Timesupdate.res2 = true;
    Timesupdate.res = true;
    _medicin.medTitle = _medTitleController.text;
    _medicin.medform = _medAmountController.text;
    //_diagonObject.medAmount=_medAmountController.text;
    _patient.patName = _patnameController.text;
    _diagonObject.notice = _noticeController.text;
    _diagonObject.img_direct = Entry.imgPath;
    _diagonObject.patId = await _patientController.insertPatient(_patient);
    if (_diagonObject.patId  == 0) {
      // Success
      _showAlertDialog('لايمكن اضافة مريض', 'عدد المرضى تجاوز:$limitUser ');
      print('عدد المرضى تجاوز:$limitUser ');

      return;
    }
    else{
    _diagonObject.medId = await _medicineController.insert(_medicin);
    //id
    _diagonId = await _diagonController.insertDiagon(_diagonObject);
    _dateList = List<Medicine_Date>();
    _clockList = List<Medicine_clocl>();
    if (Entry.code == 'Manual_entry') {
      for (var i = 0; i < Entry.info.length; i++) {
        String forma2 =
        Entry.info[i].date.split('')[0].replaceAll(new RegExp(r'/'), '');
        int dayId = await _medicineDayController.insertDayes(MedicineDays(Entry.info[i].date, int.parse(forma2)));
        _timesDayesController.insert_DayTimes(
            MedicineTimes(dayId, Entry.info[i].time, 1, _diagonId));
        print('ubbbbbb$forma2');
        insr = true;
        // onSaveAlarm( dayId,insr);
      }
    } else {
      _calcDaylist(int.parse(Entry.teratment_days));
      if (_diagonId != 0 &&
          _dateList.length != 0 &&
          int.parse(Entry.times_num) != 0) _cancel(_diagonId);
    }
    moveToLastScreen();}
  }

/////////////////////////////////////////////////////////////////////////////////
  void moveToLastScreen() {
    Navigator.pop(this.context, true);
  }

////////////////////////////
  _cancel(int diagid) {
    Timesupdate.res2 = true;
    _dateList = List<Medicine_Date>();
    _clockList = List<Medicine_clocl>();

    _calcDaylist(int.parse(Entry.teratment_days));
    _calcTimeList();

    int l = _clockList.length;

    // print('_clockList :$l');

    // for(int i=0;i<_clockList.length;i++)
    //   {
    //     int a= _clockList[i].dayDate;
    //
    //     print('$a :'+_clockList[i].clock);
    //   }
  }

/////////////////////////////////////////////////////////////////////////////////
  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    message = "mosa";
    showDialog(context: this.context, builder: (_) => alertDialog);
  }
  ////////////////////////////////////////////////////////////////////////////

  _calcTimeList() async {
    var arr = List(2);
    int dayId = 0;
    // _clockList=  List<Medicine_clocl>();
    arr = Entry.first_clock.split(':');
    _hour = int.parse(arr[0]);

    _clockList.clear();
    _menuts = int.parse(arr[1]);
    for (var x = 0; x < _dateList.length; x++) {
      int a = _dateList.elementAt(x).day;
      int b = _dateList.elementAt(x).month;
      int c = _dateList.elementAt(x).year;
      _year = c;
      _month = b;
      _day = a;
      String forma = '$c' + '/' + formal(b) + '/' + formal(a);
      String forma2 = '$c' + formal(b) + formal(a);
      dayId = 0;
      dayId = await _medicineDayController.insertDayes(MedicineDays(forma, int.parse(forma2)));
      // print('new day:$dayId');
      if (dayId != 0) _calcTimeDay(dayId);
    }
    //print('  طول المصفوفة ${Alarmmm.alarmList.length}');
    for (var b = 0; b < Alarmmm.alarmList.length; b++)
      onSaveAlarm(Alarmmm.alarmList[b],_diagonId);
    // print('${Alarmmm.alarmList[b]}');
  }

  String formal(int num) {
    String forma = '$num';
    if (forma.length == 1) forma = '0' + forma;
    return forma;
  }

  _calcTimeDay(int dateDayId) async {
    double times_num = _teartmentClock / int.parse(Entry.times_num);

    double w = times_num;
    if (_teartmentClock % int.parse(Entry.times_num) == 0) {
      while (_hour < 24) {
        String s = formal(_hour) + ':' + formal(_menuts);
        //add to list
        _clockList.add(Medicine_clocl(dateDayId, s));
        //int q = await _helper.insert_DayTimes(MedicineTimes(dateDayId,s,1));
        // if()
        _hour = _hour + w.toInt();
      }
    } else {
      while (_hour < 24) {
        String s = formal(_hour) + ':' + formal(_menuts);
        //add to list
        _clockList.add(Medicine_clocl(dateDayId, s));
        newHour(_hour, _menuts, w);
      }
    }
    for (int i = 0; i < _clockList.length; i++) {
      int a = _clockList[i].dayDate;
      String ss = _clockList[i].clock;
      print('$a :' + ss);
      var arr = List(2);
      ss = ss.substring(0, 5);
      arr = ss.split(':');
      print('format' + ss);
      // _clockList[i].
      int hour = int.parse(arr[0]);
      int minute = int.parse(arr[1]);
      print('clock:$hour');
      _alarmTime = DateTime(_year, _month, _day, hour, minute);
      Alarmmm.alarmList.add(_alarmTime);
      //String forma2 = selectedDate.toLocal().toString().split(' ')[0].replaceAll(new RegExp(r'-'), '');
      _timesDayesController.insert_DayTimes(MedicineTimes(dateDayId, ss, 1, _diagonId));
    }

    //Alarmmm.alarmList = new List<int>();

    _clockList.clear();
    _hour = _hour - 24;
  }

  void newHour(int hour, int minute, double numb) {
    String result = '';
    String n = numb.toStringAsFixed(2);
    var ar = List(2);
    ar = n.split('.');
    int mplus = ((int.parse(ar[1]) * 60) / 100).round();
    _menuts = _menuts + mplus;
    if (_menuts >= 60) {
      _hour = _hour + 1;
      _menuts = _menuts - 60;
    }
    _hour = _hour + numb.toInt();

    String shour = _hour.toString();
    if (shour.length == 1) shour = '0' + shour;
    String sminute = _menuts.toString();
    if (sminute.length == 1) sminute = '0' + sminute;

    result = shour + ':' + sminute;
    print(result);
  }

  _calcDaylist(int teartmentDay) {
    var arr = List(3);
    arr = Entry.first_date.split('/');
    int maxDayes = 0;
    _day = int.parse(arr[2]);
    _month = int.parse(arr[1]);
    _year = int.parse(arr[0]);
    d = 0;
    int j = 1;
    int w;
    _lastDay = _day + teartmentDay;
    //print(_day);
    //print(_lastDay);
    _dateList.clear();

    for (d = _day; d < _lastDay; d++) {
      if ((_month == 1) ||
          (_month == 3) ||
          (_month == 5) ||
          (_month == 7) ||
          (_month == 8) ||
          (_month == 10)) {
        w = 31;
        if (d <= 31) {
          _calc1MadicineDateDay(d);
        } else {
          if (_month == 7) w = 32;
          if (_month == 1) {
            if (_year % 4 == 0)
              w = 30;
            else
              w = 29;
          }
          calc2MadicineDateDay(j, w);
        }
      }
      if ((_month == 4) || (_month == 6) || (_month == 9) || (_month == 11)) {
        w = 32;
        if (d < 31) {
          _calc1MadicineDateDay(d);
        } else {
          calc2MadicineDateDay(j, w);
        }
      }
      if (_month == 12) {
        if (d <= 31) {
          _calc1MadicineDateDay(d);
        } else {
          calc3MadicineDateDay(d, j);
        }
      }
      if (_month == 2) {
        w = 32;
        if (_year % 4 == 0)
          maxDayes = 29;
        else
          maxDayes = 28;
        if (d < maxDayes) {
          _calc1MadicineDateDay(d);
        } else {
          calc2MadicineDateDay(j, w);
        }
      }
    }
  }

  _calc1MadicineDateDay(int i) {
    _dateList.add(Medicine_Date(i, _month, _year));
  }

  calc2MadicineDateDay(int j, int w) {
    _month++;
    print('work2');
    while (j < w && d < _lastDay) {
      _dateList.add(Medicine_Date(j, _month, _year));
      j++;
      d++;
    }
    j = 1;
  }

  calc3MadicineDateDay(int i, int j) {
    _year++;
    while (j <= 31 && i < _lastDay) {
      _dateList.add(Medicine_Date(j, 1, _year));
      j++;
      i++;
    }
    _month = 1;

    j = 1;
  }


  void onSaveAlarm(DateTime dt,int diag) async {
    DateTime scheduleAlarmDateTime;
    _alarmTime = dt;
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      return;
    var alarmInfo = AlarmInfo(
        alarmDateTime: scheduleAlarmDateTime,
        title: 'alarm',diag: diag
    );
    int a = await _alarmHelper.insertAlarm(alarmInfo);
    alarmInfo.id = a;
    Ass.scheduleAlarm(scheduleAlarmDateTime,alarmInfo);
    print('${alarmInfo.alarmDateTime}');

    //Navigator.pop(this.context);
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
  }

  _getImage() async {
    PickedFile imageFile = await picker.getImage(source: ImageSource.camera);
    if (imageFile == null) return;
    File tmpFile = File(imageFile.path);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);
    tmpFile = await tmpFile.copy('${appDir.path}/$fileName');
    Entry.imgPath = tmpFile.path;

    setState(() {
      _image = tmpFile;
    });
  }
}

class Alarmmm {
  static int notid;
  static List<DateTime> alarmList;
}
