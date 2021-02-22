import 'dart:io';

import 'package:bassel/controllers/medicine/diagonController.dart';
import 'package:bassel/controllers/medicine/medicineController.dart';
import 'package:bassel/controllers/medicine/patientController.dart';
import 'package:bassel/models/medicine/Diagon.dart';
import 'package:bassel/models/medicine/Medicine.dart';
import 'package:bassel/models/medicine/Patient.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'ViewTimes/times_list.dart';

class AttachmentsMedicine extends StatefulWidget {
  @override
  _AttachmentsMedicineState createState() => _AttachmentsMedicineState();
}

class _AttachmentsMedicineState extends State<AttachmentsMedicine> {
  DateTime _alarmTime;
  File _image;
  TextEditingController _nameController = TextEditingController();
  DiagonController _diagonController =DiagonController();
  MedicineController _medicineController = MedicineController();
  PatientController _patientController =PatientController();
  Medicine _medicin = Medicine();
  Patient _patient = new Patient.Without();
  Diagon _diagonObject = Diagon();
   int _diagonId;
  TextEditingController _patnameController = TextEditingController();
  TextEditingController _noticeController = TextEditingController();
  TextEditingController _medTitleController = TextEditingController();
  TextEditingController _medAmountController = TextEditingController();
  TextEditingController _imgDirectController = TextEditingController();
    var style1 = TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 14, fontWeight: FontWeight.normal, fontFamily: 'Times');
  var style4 = TextStyle(fontSize: 14, fontWeight: FontWeight.normal, fontFamily: 'Times', color: Colors.white);
  @override
  void initState() {
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
                backgroundColor: Colors.amber,
              ),
              GestureDetector(onTap: pickImage, child: Icon(Icons.camera_alt))
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
                        _save();
                      }),
                  MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.only(
                          left: 35, right: 35, top: 15, bottom: 5),
                      child: Text("الغاء الأمر", style: style4),
                      onPressed: () {
                        // _cancel();
                        Timesupdate.res2 =true;
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
  void update_relatedMed() {
    //.description = relatedMedTitleController.text;
  }


////////////////////////////////////////////////////////////////////////////
  void _save() async {
    Timesupdate.res2 =true;
    _medicin.medTitle = _medTitleController.text;
    _medicin.medform = "كبسولة";
    _patient.patName = _patnameController.text;
    _diagonObject.notice = _noticeController.text;
    _diagonObject.medId = await _medicineController.insert(_medicin);
    _diagonObject.patId = await _patientController.insertPatient(_patient); //id
    _diagonId = await _diagonController.insertDiagon(_diagonObject);

    moveToLastScreen();

    if (_diagonId != 0) {
      // Success
      _showAlertDialog('Status', 'diagon:$_diagonId Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'daiagon Saving Note');
    }
    //moveToLastScreen();

  }

/////////////////////////////////////////////////////////////////////////////////
  void moveToLastScreen() {


    Navigator.pop(context, true);
  }
/////////////////////////////////////////////////////////////////////////////////////////////
  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    message = "mosa";
    showDialog(context: context, builder: (_) => alertDialog);
  }
  ////////////////////////////////////////////////////////////////////////////


}