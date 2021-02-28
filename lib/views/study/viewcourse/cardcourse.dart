import 'dart:io';
import 'package:bassel/controllers/medicine/medicineDayController.dart';
import 'package:bassel/controllers/medicine/medicineViewController.dart';
import 'package:bassel/controllers/medicine/timesDayesController.dart';
import 'package:bassel/models/medicine/Medicine.dart';
import 'package:bassel/models/medicine/MedicineInfo.dart';
import 'package:bassel/models/medicine/MedicineTimes.dart';
import 'package:bassel/models/medicine/medicineDays.dart';
import 'package:bassel/models/study/course.dart';
import 'package:bassel/notifications/notifications.dart';
import 'package:bassel/utils/alarm_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimesCard extends StatefulWidget {
  final Course medicine;
  final Function setData;
  TimesCard(this.medicine, this.setData);
  @override
  State<StatefulWidget> createState() {
    return _TimesCard(this.medicine, this.setData);
  }
}

class _TimesCard extends State<TimesCard> {
  AlarmHelper _alarmHelper = AlarmHelper();
  MedicineDayController _medicineDayController = MedicineDayController();
  TimesDayesController _timesDayesController = TimesDayesController();
  MedicineViewController _medicineViewController = MedicineViewController();
  Course medicine;
  Function setData;
  _TimesCard(this.medicine, this.setData);
  var style10 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w200,
    fontFamily: 'Times',
  );
  var style1 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times');
  var style4 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: 'Times',
      color: Colors.white);
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        print('$selectedDate');
      });
  }

  DateTime _alarmTime;
  String _alarmTimeString;

  @override
  Widget build(BuildContext context) {
    //check if the medicine time is lower than actual
    return Card(
        color: Colors.white,
        elevation: 5.0,
        shadowColor: Colors.amber,
        child: Column(children: <Widget>[
          Container(
            color: Colors.amber,
            child: Row(children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(left: 15.0, right: 15, top: 5, bottom: 5),
                child: Image.asset("assets/med.png", width: 40, height: 40),
              ),
              Text("الأدوية ", style: style1),
              Padding(
                padding: const EdgeInsets.only(right: 100.0, left: 15),
                child: Icon(
                  Icons.alarm,
                  size: 20,
                  color: Colors.green,
                ),
              ),
              Text('${medicine.namecourse}')
            ]),
          ),
        ]));
  }

  //============================================================================================
  //-----------------------|getImg|-------------------------------------

  //============================================================================================

  //-----------------------|accept|-------------------------------------
}
