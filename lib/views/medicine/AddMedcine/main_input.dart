import 'dart:io';
import 'package:honeyBee/Controller/medicine/diagonController.dart';
import 'package:honeyBee/views/medicine/AddMedcine/form_input.dart';

import '../../../Config/general.dart';
import '../../../Config/insert_data.dart';
import '../../../Controller/medicine/medicineController.dart';
import '../../../Controller/medicine/medicineDayController.dart';
import '../../../Controller/medicine/patientController.dart';
import '../../../Controller/medicine/timesDayesController.dart';
import '../../../models/medicine/Diagon.dart';
import '../../../models/medicine/Medicine.dart';
import '../../../models/medicine/MedicineTimes.dart';
import '../../../models/medicine/Medicine_Date.dart';
import '../../../models/medicine/Medicine_clocl.dart';
import '../../../models/medicine/Patient.dart';
import '../../../models/medicine/alarm_info.dart';
import '../../../models/medicine/medicineDays.dart';
import '../../../utils/notifications.dart';
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

          FormInput(this.context,_patient,_medicin,_diagonObject ,
              _day, _month, _year,_teartmentClock,_hour,_menuts),
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
////////////////////////////////////////////////////////////////////////////
  void _save() async {
    Timesupdate.res2 = true;
    Timesupdate.res = true;
    // _medicin.medTitle = _medTitleController.text;
    // _medicin.medform = _medAmountController.text;
    // //_diagonObject.medAmount=_medAmountController.text;
    // _patient.patName = _patnameController.text;
    // _diagonObject.notice = _noticeController.text;
      _diagonObject.img_direct = Entry.imgPath;
    _diagonObject.patId = await _patientController.insertPatient(_patient);
    if (_diagonObject.patId  == 0) {
      // Success
      _showAlertDialog('لايمكن اضافة مريض', 'عدد المرضى تجاوز:$limitUser ');
      print('عدد المرضى تجاوز:$limitUser ');

      return;
    }
    else{
    _diagonObject.medId = await _medicineController.insert_medicine(_medicin);
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
    if (
    _teartmentClock % int.parse(Entry.times_num) == 0) {
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
