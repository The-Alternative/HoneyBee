import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../controllers/medicine/medicineViewController.dart';
import '../../../controllers/medicine/patientController.dart';
import '../../../models/medicine/MedicineInfo.dart';
import '../../../models/medicine/Patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'medicines_Reclist.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var style10 = TextStyle(fontSize: 20, fontWeight: FontWeight.w200, fontFamily: 'Times',);
  var style1 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times');
  var style4 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times', color: Colors.white);
  String _selectedName;
  PatientController _patientController =PatientController();
  MedicineViewController _medicineViewController =MedicineViewController();


  //--------------------| List of medicine from database |----------------------
  List<MedicineInfo> allListOfMedicine = List<MedicineInfo>();
  List<MedicineInfo> SearchList = List<MedicineInfo>();
  List<Patient> NamesList = List<Patient>();

  //=========================================================================


  @override
  void initState() {
    super.initState();
    setState(() {
      setData();
      setNames();

    });

  }
  //--------------------GET ALL DATA FROM DATABASE---------------------
  Future setData() async {
    allListOfMedicine.clear();
    (await _medicineViewController.getInfo('med_view')).forEach((medMap) {
      setState(() {
        allListOfMedicine.add(MedicineInfo().medicineMapToObject(medMap));

      });
      print(  allListOfMedicine.length);
      NamesList.clear();
    });

  }
  //===================================================================

  //--------------------GET ALL NAMES FROM DATABASE---------------------
  Future setNames() async {
    NamesList.clear();
    (await _medicineViewController.getInfo('patent_table')).forEach((patientMap) {
      setState(() {
        NamesList.add(Patient("").patientMapToObject(patientMap));
      });
      print(  NamesList.length);
    });
  }
  //===================================================================

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    print(  allListOfMedicine.length);


    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                top: 0.0, left: 5.0, right:5.0, bottom: 0.0),
            child: Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: deviceHeight * 0.1,
                    child:  Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child:searchTextField(),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                SizedBox(height: deviceHeight * 0.03),
                allListOfMedicine.isEmpty
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
                    isRepeatingAnimation: true,
                    speed: Duration(milliseconds: 50),
                  ),
                )
                    : MedicinesList(allListOfMedicine,setData)
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
  Widget searchTextField()
  {
    return(allListOfMedicine.isNotEmpty?
    TextField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(width: 1,color: Colors.amberAccent),
          ),
          hintText: '',
          hintStyle: TextStyle(fontSize: 16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(width: 1,color: Colors.amberAccent),
          ),
          labelStyle: TextStyle(
              color: Colors.amberAccent
          ),

          contentPadding: EdgeInsets.only(left: 10,right: 10),
          fillColor: Colors.white70,
          prefixIcon: Icon(Icons.search,color: Colors.amberAccent,)
      ),
    ):Divider());
  }
//===============================================================================


}
