import 'dart:io';
import 'package:bassel/controllers/medicine/medicineDayController.dart';
import 'package:bassel/controllers/medicine/medicineViewController.dart';
import 'package:bassel/controllers/medicine/timesDayesController.dart';
import 'package:bassel/models/medicine/MedicineInfo.dart';
import 'package:bassel/models/medicine/MedicineTimes.dart';
import 'package:bassel/models/medicine/medicineDays.dart';
import 'package:bassel/notifications/notifications.dart';
import 'package:bassel/utils/alarm_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimesCard extends StatefulWidget {
  final MedicineInfo medicine;
  final Function setData;
  TimesCard(this.medicine,this.setData);
  @override
  State<StatefulWidget> createState() {
    return _TimesCard(this.medicine,this.setData);
  }
}
class _TimesCard extends State<TimesCard> {

  AlarmHelper _alarmHelper= AlarmHelper();
  MedicineDayController _medicineDayController = MedicineDayController();
  TimesDayesController _timesDayesController =TimesDayesController();
  MedicineViewController _medicineViewController =MedicineViewController();
  MedicineInfo medicine;
  Function setData;
  _TimesCard(this.medicine,this.setData);
  var style10 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w200,
    fontFamily: 'Times',
  );
  var style1 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times');
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
                padding: EdgeInsets.only(
                    left: 15.0, right: 15, top: 5, bottom: 5),
                child: Image.asset("assets/med.png",
                    width: 40, height: 40),
              ),
              Text("الأدوية ", style: style1),
              Padding(
                padding:
                const EdgeInsets.only(right: 100.0, left: 15),
                child: Icon(
                  Icons.alarm,
                  size: 20,
                  color: Colors.green,
                ),
              ),
              Text('${medicine.day_time}')
            ]),
          ),
          ListTile(
            leading: getImg(medicine.img_direct),
            title: Text(
              '${medicine.medTitle}',
            ),
            subtitle: Text('${medicine.personName}'),
            trailing: Text(""),
            onTap: () {
              debugPrint("ListTile Tapped");
              // navigateToDetail(this.noteList[position],'Edit ');
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 75.0),
            child: Text("1ساعة 35 دقيقة"),
          ),
          Divider(
            color: Colors.amber,
            thickness: 1,
          ),
          Row(children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0, right: 75, left: 75),
                child: FlatButton(
                    child: const Text(
                      'تم',
                      style: TextStyle(
                          color: Colors.white, fontSize: 20),
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.teal)),
                    splashColor: Colors.white10,
                    color: Colors.green,
                    onPressed: () {
                      getAccept(medicine); /* ... */
                    })),
            Divider(
              thickness: 2,
              height: 5,
            ),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.blue,
                ),
                onPressed: () async {
                  //   str_todate(medicine.daydate,medicine.day_time);
                  _delete(context, medicine);

                  // *******
                  //print('card:${selecttimesList[ii].timesId}day:${selecttimesList[ii].dayesId}time:${selecttimesList[ii].day_time}');
                }),
          ])
        ]));
  }
  //============================================================================================
  //-----------------------|getImg|-------------------------------------
  Widget getImg(String img_direct) {
    if (img_direct != '') {
      var file = new File(img_direct);
      img_direct = '';

      return Image.file(
        file,
        fit: BoxFit.contain,
        height: 75.0,
      );
    } else {
      print('mosassssssssss');

      return Text('No image');
    }
  }
  //============================================================================================

  //-----------------------|accept|-------------------------------------
  getAccept(MedicineInfo card_info) {
    var arr = List(3);
    arr = card_info.daydate.split('/');
    int _day = int.parse(arr[2]);
    int _month = int.parse(arr[1]);
    int _year = int.parse(arr[0]);
    selectedDate = DateTime(_year, _month, _day);

    var arr2 = List(2);
    arr2 = card_info.day_time.split(':');
    int hh = int.parse(arr2[1]);
    int mm = int.parse(arr2[0]);

    _alarmTimeString = card_info.day_time;
    showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(0),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                height: 2000,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(right: 75),
                          child: Text(
                            'تناول عدد 1 كبسولة',
                            textAlign: TextAlign.right,
                          ),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(right: 85),
                          child: Text(card_info.personName,
                              textAlign: TextAlign.right),
                        )),
                    ListTile(
                      title: Divider(
                        color: Colors.amber,
                        thickness: 2,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 120),
                          child: IconButton(
                            icon: Image.asset("assets/clock.png",
                                width: 75, height: 75),
                            onPressed: () async {
                              var selectedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (selectedTime != null) {
                                final now = DateTime.now();
                                var selectedDateTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    selectedTime.hour,
                                    selectedTime.minute);
                                _alarmTime = selectedDateTime;
                                setModalState(() {
                                  _alarmTimeString = DateFormat('HH:mm')
                                      .format(selectedDateTime);
                                });
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon: Image.asset("assets/calendarr.png",
                              width: 120, height: 120),
                          onPressed: () async {
                            final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101));
                            if (picked != null && picked != selectedDate)
                              setModalState(() {
                                selectedDate = picked;
                                print('$selectedDate');
                              });
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text('$_alarmTimeString'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 75),
                          child: Text("$selectedDate".substring(0, 10)),
                          //  ${selectedDate.toLocal()}".split(' ')[0]
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              str_todate(card_info.daydate, card_info.day_time);
                              Navigator.pop(context);

                            },
                            icon: Icon(Icons.cancel_outlined),
                            label: Text('الغاء الأمر'),
                            backgroundColor: Colors.red,

                          ),
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            card_info.daydate.replaceAll(new RegExp(r'/'), '-');
                            if ('${selectedDate.toLocal()}'.split(' ')[0] ==
                                card_info.daydate
                                    .replaceAll(new RegExp(r'/'), '-') &&
                                _alarmTimeString == card_info.day_time) {
                              var medicine = MedicineInfo(
                                  medTitle: card_info.medTitle,
                                  medform: 'amount',
                                  amount:card_info.amount ,
                                  personName: card_info.personName,
                                  notice:card_info.notice
                                  ,last_date:card_info.daydate
                                  ,first_date:card_info.first_date
                                  ,doctname:card_info.doctname ,
                                  img_direct:card_info.img_direct ,
                                  diagon:card_info.diagon );
                              _medicineViewController.insertRecordMedicine(medicine);
                              _delete(context, card_info);
                            } else {
                              _update(context, card_info, selectedDate,
                                  _alarmTimeString);
                              setData();
                            }
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.alarm),
                          label: Text('حفظ'),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
  //============================================================================================
  void _delete(BuildContext context, MedicineInfo card_info) async {
    int a = await _alarmHelper.getId(
        card_info.diagid, str_todate(card_info.daydate, card_info.day_time));
    int result = await _timesDayesController.deleteDayTimes(
        card_info.timesId, card_info.dayesId);
    print('moooo$a');
    Ass.removeNotify(a);
    _alarmHelper.delete(a);
    if (result != 0) {
      setData();
    }
  }

  //============================================================================================
  void _update(BuildContext context, MedicineInfo card_info, DateTime selectedDate, String _alarmTimeString) async
  {
    print('updated');
    String forma = selectedDate
        .toLocal()
        .toString()
        .split(' ')[0]
        .replaceAll(new RegExp(r'-'), '/');
    String forma2 = selectedDate
        .toLocal()
        .toString()
        .split(' ')[0]
        .replaceAll(new RegExp(r'-'), '');
    print(forma);
    int dayId = await _medicineDayController.insertDayes(MedicineDays(forma, int.parse(forma2)));
    _medicineDayController.updateDayTimes(MedicineTimes(dayId, _alarmTimeString, 1,
        card_info.diagid, card_info.timesId));
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  DateTime str_todate(String s1,String s2){
    var arr = List(3);
    arr = s1.split('/');
    int dd = int.parse(arr[2]);
    int mm = int.parse(arr[1]);
    int yyyy = int.parse(arr[0]);
    var arr2 = List(2);
    arr2 = s2.split(':');
    int mi = int.parse(arr2[1]);
    int ho = int.parse(arr2[0]);
    var selectedDateTime = DateTime(
        yyyy,
        mm,
        dd,
        ho,
        mi);
    // print ('$selectedDateTime');
    return selectedDateTime;
  }
  //============================================================================================

  //--------------------------| SHOW THE DELETE DIALOG ON THE SCREEN |-----------------------

  void _showDeleteDialog(BuildContext context, String medicineName, int medicineId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Delete ?"),
          content: Text("Are you sure to delete $medicineName medicine?"),
          contentTextStyle:
          TextStyle(fontSize: 17.0, color: Colors.grey[800]),
          actions: [
            FlatButton(
              splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
              child: Text(
                "Cancel",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
              child: Text("Delete",
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: ()  {
                //
                // await Repository().deleteData('Pills', medicineId);
                // await Notifications().removeNotify(notifyId, flutterLocalNotificationsPlugin);
                setData();
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }
//============================================================================================


}
