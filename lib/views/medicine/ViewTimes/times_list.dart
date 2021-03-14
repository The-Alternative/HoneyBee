
import '../../../Controller/medicine/medicineController.dart';
import '../../../Controller/medicine/medicineDayController.dart';
import '../../../Controller/medicine/medicineViewController.dart';
import '../../../Controller/medicine/patientController.dart';
import '../../../Controller/medicine/timesDayesController.dart';
import '../../../models/medicine/MedicineInfo.dart';
import '../../../models/medicine/MedicineTimes.dart';
import '../../../models/medicine/Patient.dart';
import '../../../models/medicine/medicineDays.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Time_list extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Time_listState();
  }
}

class Time_listState extends State<Time_list> {
  DateTime selectedDate = DateTime.now();
  String _selectedName;
  File _savedImage;
  final picker = ImagePicker();
  Future<List<Patient>> _PatientList;
  List<Patient> _currentPatientList;
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
  String _ndate = DateFormat.yMMMd().format(DateTime.now());
  String _clock =
      DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString();
  MedicineDayController _medicineDayController =MedicineDayController();
  PatientController _patientController =PatientController();
  TimesDayesController _timesDayesController =TimesDayesController();
  MedicineController _medicineController =MedicineController();
MedicineViewController _medicineViewController=MedicineViewController();
  List<MedicineInfo> cardList;
  List<MedicineDays> daysList;
  bool reff = true;
  int count = 0;
  int count2 = 0;
  int count3 = 0;
  @override
  void initState() {

    super.initState();
  }

  Time_listState() {}
  bool _loading = false;

  void _onLoading() {
    setState(() {
      _loading = true;

      new Future.delayed(new Duration(seconds: 1), _login);
    });
  }

  Future _login() async {
    setState(() {
      addCardListView();
   //   _medicineDayController.testDay();

      //  print('lengthcard;ist:${cardList.length}');
      cardList.clear();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (daysList == null) {
      daysList = List<MedicineDays>();
      addDaysListView();
    }
    if (cardList == null) {
      cardList = List<MedicineInfo>();
      addCardListView();
    }
    if (_currentPatientList == null) {
      _currentPatientList = List<Patient>();
      getListViewPerson();
    }
    if (Timesupdate.res) {
      setState(() {
        getListViewPerson();
        addCardListView();
        addDaysListView();
        // for (var ii = 0; ii < cList.length; ii++) {
        //    print(Alarmmm.alarmList[5]);
        // }

        Timesupdate.res = false;
      });
    }

    //_adbHelper.testDay();

    return build2(context);
  }

  Widget build2(BuildContext context) {
    //if (!loaded) _loadZones();
    var body = new Column(
      children: <Widget>[
        new Padding(padding: EdgeInsets.fromLTRB(0, 1, 0, 0)),
        Row(
          children: <Widget>[
            // Expanded(
            //   flex: 1,
            //   child: InkWell(
            //       child: FlatButton(
            //           child:  Icon(Icons.refresh),
            //           shape: RoundedRectangleBorder(
            //               side: BorderSide(
            //                   color: Colors.amber)),
            //           splashColor: Colors.green,
            //           color: Colors.white,
            //           onPressed: () {
            //             Timesupdate.res=true;
            //             Timesupdate.res2=true;
            //             updateCardInfo();
            //             /* ... */
            //           })),
            // )
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Text('الاسم', style: style1),
              ),
            ),

            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 25),
                  child: getDrop(),
                )),
          ],
        ),
        Divider(
          color: Colors.amber,
        ),
        new Expanded(child: Container(child: getday()))
      ],
    );
    var bodyProgress = new Container(
      child: new Stack(
        children: <Widget>[
          body,
          new Container(
            alignment: AlignmentDirectional.center,
            decoration: new BoxDecoration(
              color: Colors.white70,
            ),
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: new BorderRadius.circular(10.0)),
              width: 300.0,
              height: 600.0,
              alignment: AlignmentDirectional.center,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                    child: new SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: new CircularProgressIndicator(
                        value: null,
                        strokeWidth: 7.0,
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: new Center(
                      child: new Text(
                        "loading.. wait...",
                        style: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return new Scaffold(body: _loading ? bodyProgress : body);
  }

  Widget getDrop() {
    if (_currentPatientList.length != 0)
      return DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: false,
          style: style10,
          // Not necessary for Option 1
          value: _selectedName,
          onChanged: (newValue) {
            setState(() {
              _selectedName = newValue;
              print(_selectedName);
              getselectDaysListView(_selectedName);
              getselectCardListView(_selectedName);
            });
          },
          items: _currentPatientList.map((name) {
            return DropdownMenuItem(
              child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(
                    children: [
                      Text(
                        name.patName,
                        style: TextStyle(color: Colors.black),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                      )
                    ],
                  )),
              value: name.patName,
            );
          }).toList(),
        ),
      );
    else
      Text("لايوجد مريض");
  }

  ListView getday() {
    if (count2 != 0)
      return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(), //Added
          itemCount: count2,
          itemBuilder: (BuildContext context, int index) {
            MedicineDays day = daysList[index];
            //List<Card_info> places = zone.;
            // print(zone.toString());
            //  print(places.length);
            return InkWell(
                onTap: () {},
                child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: new InkWell(
                        child: new Column(
                      children: <Widget>[
                        Container(
                          color: Colors.black12,
                          child: ListTile(
                              leading: Text(getDayName(day.dayDate)),
                              title: Row(
                                children: <Widget>[
                                  Text(
                                    ' ${day.dayDate}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              )),
                        ),
                        getdaytime(day.dayesId),
                      ],
                    ))));
          });
  }

  ListView getdaytime(int id) {
    //addTimesListView();
    List<MedicineInfo> selecttimesList = List<MedicineInfo>();
    for (int i = 0; i < cardList.length; i++) {
      if (cardList[i].dayesId == id) selecttimesList.add(cardList[i]);
      //print ('${ cardList[i].medicine}');
    }
    return ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          ListView.builder(
              //removed Flexible
              shrinkWrap: true,
              physics: ClampingScrollPhysics(), //Added
              itemCount: selecttimesList.length,
              itemBuilder: (BuildContext ct, int ii) {
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
                          Text('${selecttimesList[ii].day_time}')
                        ]),
                      ),
                      ListTile(
                        leading: getImg(selecttimesList[ii].img_direct),
                        title: Text(
                          '${selecttimesList[ii].medTitle}',
                        ),
                        subtitle: Text('${selecttimesList[ii].personName}'),
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
                                  getAccept(selecttimesList[ii]); /* ... */
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
                            onPressed: () {
                              print(selecttimesList[ii].img_direct);
                              _delete(context, selecttimesList[ii]);
                              // *******
                              //print('card:${selecttimesList[ii].timesId}day:${selecttimesList[ii].dayesId}time:${selecttimesList[ii].day_time}');
                            }),
                      ])
                    ]));
              })
        ]);
    // return Text(
    //   "● ${selecttimesList[i].dayTime}",
    //   textAlign: TextAlign.start,
    // );
  }

  getImgparam(String img_direct) async {}
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
                                  personName: card_info.personName,notice:card_info.notice ,last_date:card_info.daydate
                                  ,first_date:card_info.first_date
                              ,doctname:card_info.doctname ,img_direct:card_info.img_direct ,diagon:card_info.diagon );
                              print(card_info.notice);
                              // print('bbbb${selectedDate.toLocal()}'.split(' ')[0].replaceAll(new RegExp(r'-'), '/'));
                              _medicineViewController.insertRecordMedicine(medicine);
                            //  _delete(context, card_info);
                            } else {
                              _update(context, card_info, selectedDate,
                                  _alarmTimeString);
                            }
                            _onLoading();
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

  String getDayName(String s) {
    var arr = List(3);
    arr = s.split('/');
    int _day = int.parse(arr[2]);
    int _month = int.parse(arr[1]);
    int _year = int.parse(arr[0]);
    var dforma = DateTime(_year, _month, _day);
    var now = DateTime.now();
    var dna = DateFormat.EEEE().format(dforma);
    return '$dna';
  }

  addCardListView() {
    Future<List<MedicineInfo>> cardListFuture;
    cardListFuture.then((cardList) {
      setState(() {
        //debugPrint("list has change");
        this.cardList = cardList;
        this.count = cardList.length;
        // print(cardList.length);
      });
    });
  }

  addDaysListView() {
    Future<List<MedicineDays>> daysFuture ;
    daysFuture.then((DaysList) {
      setState(() {
        //debugPrint("list has change");
        this.daysList = DaysList;
        this.count2 = DaysList.length;
        // print(DaysList.elementAt(0).dayDate);
      });
    });
    int a = daysList.length;
    //print('lengthday:$a');
  }

  getselectCardListView(String name) {
    Future<List<MedicineInfo>> cardListFuture;
    cardListFuture.then((cardList) {
      setState(() {
        //debugPrint("list has change");
        this.cardList = cardList;
        this.count = cardList.length;
        // print(cardList.length);
      });
    });
  }

  getselectDaysListView(String name) {
    Future<List<MedicineDays>> daysFuture ;
    daysFuture.then((DaysList) {
      setState(() {
        //debugPrint("list has change");
        this.daysList = DaysList;
        this.count2 = DaysList.length;
        // print(DaysList.elementAt(0).dayDate);
      });
    });
    int a = daysList.length;
    //print('lengthday:$a');
  }

  // addTimesListView(){
  // //  final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  //   Future<List<MedicineTimes>>timesFuture = databaseHelper.getDayTimesList();
  //   timesFuture.then((timesList) {
  //     setState(() {
  //       debugPrint("list has change");
  //       this.timesList = timesList;
  //       this.count3 = timesList.length;
  //    //    for(int i=0;i<timesList.length;i++)
  //    //      {
  //    //        int ii=timesList.elementAt(i).dayesId;
  //    // //  print('$ii'+"  "+timesList.elementAt(i).dayTime);
  //    //      }
  //
  //     });
  //   });
  // }
  void _update(BuildContext context, MedicineInfo card_info, DateTime selectedDate,
      String _alarmTimeString) async {
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
    int dayId =
        await _medicineDayController.insertDayes(MedicineDays(forma, int.parse(forma2)));
    _medicineDayController.updateDayTimes(MedicineTimes(
        dayId, _alarmTimeString, 1, card_info.diagid, card_info.timesId));
    addCardListView();
    addDaysListView();
  }

  void updateCardInfo() async {
    if (Timesupdate.res) {
      print("add");
      addDaysListView();
      //addCardListView();
      //addTimesListView();
      _onLoading();
      Timesupdate.res = false;
    }
  }

  void _delete(BuildContext context, MedicineInfo card_info) async {
    int result = await _timesDayesController.deleteDayTimes(card_info.timesId, card_info.dayesId);
    if (result != 0) {
      // _alarmHelper.d
      // _showSnackBar(context, ' Deleted Successfully');
      addCardListView();
      addDaysListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  getListViewPerson() {
    _PatientList = _patientController.getPatientList();
    _PatientList.then((pList) {
      setState(() {
        this._currentPatientList = pList;
        this.count = pList.length;
        // print('------database ${_currentMedicineList.length}');
      });
    });
  }
}

class Timesupdate {
  static bool res = false;
  static bool res2 = false;
  static List<MedicineTimes> timesList;
}
