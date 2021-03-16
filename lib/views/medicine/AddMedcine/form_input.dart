import 'dart:io';
import 'package:honeyBee/Controller/medicine/diagonController.dart';

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


class FormInput extends StatelessWidget {
  FormInput(this.context,this._patient,this._medicin,this._diagonObject,
      this._day, this._month, _year,_teartmentClock,_hour,_menuts){
  }
  File _image;
  BuildContext context;
  Medicine _medicin = Medicine();
  Patient _patient = new Patient.Without();
  Diagon _diagonObject = Diagon();
  int _day, _month, _year,_teartmentClock,_hour,_menuts;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _patnameController = TextEditingController();
  TextEditingController _noticeController = TextEditingController();
  TextEditingController _medTitleController = TextEditingController();
  TextEditingController _medAmountController = TextEditingController();
  TextEditingController _imgDirectController = TextEditingController();
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
  Widget build(BuildContext context) {
    return homePage();
  }
  Widget homePage() {
    return Column(
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
          Padding(
              padding:
              EdgeInsets.only(right: 15.0, left: 15, bottom: 15, top: 50),
              child: TextField(
                controller: _patnameController,
                onSubmitted: (value) {
                  update_patname();
                },
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
                style: style2,onSubmitted: (value){update_medTitle();},
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
                style: style2,onSubmitted:(value){_diagonObject.medAmount =_medAmountController.text;} ,
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
        ],
      );
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
  void update_patname() {
    _patient.patName = _patnameController.text;
  }

  void update_medTitle() {
    _medicin.medTitle = _medTitleController.text;
  }

  void update_medAmount() {
    _diagonObject.medAmount = _medAmountController.text;
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
}
