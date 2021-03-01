import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bassel/controllers/medicine/cardinfoController.dart';
import 'package:bassel/controllers/medicine/medicineDayController.dart';
import 'package:bassel/controllers/medicine/patientController.dart';
import 'package:bassel/controllers/medicine/timesDayesController.dart';
import 'package:bassel/models/medicine/MedicineInfo.dart';
import 'package:bassel/models/medicine/Patient.dart';
import 'package:bassel/models/medicine/medicineDays.dart';
import 'package:bassel/views/medicine/ViewTimes/timeList.dart';
import 'package:bassel/views/medicine/ViewTimes/times_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimesHome extends StatefulWidget {
  @override
  _TimesHomeState createState() => _TimesHomeState();
}

class _TimesHomeState extends State<TimesHome> {
  var style10 = TextStyle(fontSize: 20, fontWeight: FontWeight.w200, fontFamily: 'Times',);
  var style1 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times');
  var style4 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal,
      fontFamily: 'Times', color: Colors.white);
  String _selectedName;
  //--------------------| Lists of tables from database |----------------------
  MedicineDayController _medicineDayController =MedicineDayController();
  PatientController _patientController =PatientController();
  TimesDayesController _timesDayesController =TimesDayesController();
  CardinfoController _cardinfoController =CardinfoController();
  List<MedicineInfo> cardList = List<MedicineInfo>();
  List<MedicineDays> daysList = List<MedicineDays>();
  List<Patient> NamesList = List<Patient>();

  //=========================================================================


  @override
  void initState() {
    super.initState();
    setState(() {
      setDayData('');
      setNames();
      setTimesData('');

    });

  }

  setdata()  {
    print(  '${daysList.length}');
    setState(() {
      setDayData(_selectedName);
      setTimesData(_selectedName);
    });

  }
  //--------------------GET ALL DATA FROM DATABASE---------------------
  setDayData(String name) async {
    daysList.clear();
    (await _medicineDayController.getmidDayesMapList(name)).forEach((dayMap) {
      setState(() {
        daysList.add(  MedicineDays.WithId().fromMapObject(dayMap));
      });
      print(  'daysList.length');
    });

  }
  //===================================================================
  setTimesData(String name) async {

    cardList.clear();
    (await _cardinfoController.getSelectCards(name)).forEach((timeMap) {
      setState(() {
        cardList.add(timeMap);

      });
      print( ' card.length');

    });

  }
  //===================================================================
  Future setNames() async {
    NamesList.clear();
    (await _patientController.getPatientMapList()).forEach((patientMap) {
      setState(() {
        NamesList.add(Patient("").patientMapToObject(patientMap));
      });
    });
  }
  //===================================================================

  @override
  Widget build(BuildContext context) {

    if (Timesupdate.res) {
      // setdata();
      setNames();
      Timesupdate.res=false;}
    if (Timesupdate.res2) {
      //   setTimesData();
      Timesupdate.res2=false;}
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    print( NamesList .length);
    print( cardList .length);


    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                top: 0.0, left: 1.0, right:1.0, bottom: 0.0),
            child: Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: deviceHeight * 0.1,
                    child:  Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Text('الاسم'),
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
                  ),
                ),

                SizedBox(height: deviceHeight * 0.03),
                cardList.isEmpty
                    ? SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: WavyAnimatedTextKit(
                    textStyle: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text: [
                      "No data..."
                    ],
                    isRepeatingAnimation: false,
                    speed: Duration(milliseconds: 50),
                  ),
                )
                    : TimesList(cardList,daysList,setdata)
              ],
            ),
          ),
        ),
      ),
    );
  }


  //-------------------------| Click on the calendar day |-------------------------
  Widget getDrop() {
    return(
        NamesList.isEmpty?
        Text("لايوجد مريض") :DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: false,
            style: style10,
            // Not necessary for Option 1
            value: _selectedName,
            onChanged: (newValue) {
              setState(() {
                _selectedName = newValue;
                print(_selectedName);
                // getselectDaysListView(_selectedName);
                // getselectCardListView(_selectedName);
                setDayData(_selectedName);
                setTimesData(_selectedName);

              });
            },
            items: NamesList.map((name) {
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
        ));

  }
}

