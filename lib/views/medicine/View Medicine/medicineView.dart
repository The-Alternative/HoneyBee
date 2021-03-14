
import '../../../Controller/medicine/medicineController.dart';
import '../../../Controller/medicine/patientController.dart';
import '../../../models/medicine/MedicineInfo.dart';
import '../../../models/medicine/Patient.dart';
import '../../../views/medicine/AddMedcine/main_update.dart';
import '../../../views/medicine/ViewTimes/times_list.dart';
import 'package:flutter/material.dart';

class MedicineView extends StatefulWidget {
  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineView> {
  MedicineController _medicineController =MedicineController();
  PatientController _patientController =PatientController();
  int count;
  String _selectedName ;

  Future<List<MedicineInfo>> _medicineList;
  List<Patient> NamesList = List<Patient>();
  List<MedicineInfo> _currentMedicineList;
  var style10 = TextStyle(fontSize: 20, fontWeight: FontWeight.w200, fontFamily: 'Times',);
  var style2 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times');
  var style4 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times', color: Colors.white);
  @override
  void initState() {
    setNames();
    super.initState();
  }
  void loadMedicine() {
    _medicineList = _medicineController.getFMedicine();
    print('------database ');
    _currentMedicineList =List<MedicineInfo>();
    NamesList =List<Patient>();

    // getListViewMedicine();
    // getListViewPerson();

    if (mounted) setState(() {});

  }
  @override
  Widget build(BuildContext context) {
    if(_currentMedicineList==null){
      _currentMedicineList =List<MedicineInfo>();

      // getListViewMedicine();

    }

    return build2(context);
  }
  Widget build2(BuildContext context) {
    //if (!loaded) _loadZones();
    return Scaffold(body: new Column(
      children: <Widget>[
        new Padding(padding: EdgeInsets.fromLTRB(0, 1, 0, 0)),
        Row(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child:  Text('الاسم',style: style10),
              ),
            ),
            Expanded(
              flex: 2,
              child:
              Padding(
                padding: const EdgeInsets.only(top:15.0,left: 25),
                child:getDrop()
                ,
              ),
            ),
          ],
        )
        ,      new Expanded(
            child:  getBody())

      ],
    ),);


  }
  Widget getDrop(){
    if(NamesList.length !=0)
      return   DropdownButtonHideUnderline(
        child: DropdownButton(isExpanded: false,
          style: style10,
          // Not necessary for Option 1
          value: _selectedName,
          onChanged: (newValue) {
            setState(() {
              _selectedName = newValue;
              print(_selectedName);
              getselectListViewMedicine(_selectedName);
            });
          },
          items: NamesList.map((name) {

            return DropdownMenuItem(
                child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Column(children: [  Text(name.patName,
                      style: TextStyle(color: Colors.black) ,),
                      Divider(thickness: 1,height: 1,)],)
                ),
                value: '${name.patId}'
            );
          }).toList(),
        ),
      );
    else
      Text("لايوجد مريض");
  }
  Widget getBody(){
    if(_currentMedicineList.length ==0)
      return
        Padding(
          padding: const EdgeInsets.all(100.0),
          child: (Text('لايوجد أدوية...')),
        );
    else
      return ListView.builder(
          shrinkWrap: true, physics: ClampingScrollPhysics(),  //Added
          //removed Flexible
          itemCount: _currentMedicineList.length,
          itemBuilder: (BuildContext ct, int ii) {
            return
              Container(margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5,color: Colors.amber),
                  boxShadow:[BoxShadow(color: Colors.amber,spreadRadius: .1,blurRadius: 1,)],
                  borderRadius:BorderRadius.circular(5),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child:Row(children: <Widget>[
                  Expanded(child:   Text('${_currentMedicineList[ii].medTitle}',style: style10,),flex: 100,),
                  Expanded(child:  Container(
                    width: 1,
                    height: 50,
                    color: Colors.amber,
                  ),flex: 1,),
                  Expanded(child:
                  IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.lightBlue,
                      onPressed: () {_update(context,_currentMedicineList[ii]);
                      }),flex: 20,),
                  Expanded(child:  Container(
                    width: 1,
                    height: 50,
                    color: Colors.amber,
                  ),flex: 1,),
                  Expanded(child:
                  IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.lightBlue,
                      onPressed: () {_delet(context,_currentMedicineList[ii]);
                      }),flex: 20,),
                ]),);
          }) ;
  }
  void _delete(BuildContext context, int id) async {
    int result = await _medicineController.deleteMedicine(id);
    if (result != 0) {
      loadMedicine();
    }
  }
  void _update(BuildContext context, MedicineInfo medicineInfo) async {
    //NamesList.clear();
    CardInfoUpdate.medicineInfo=medicineInfo;
    CardInfoUpdate.updOpr=true;
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Main_update( CardInfoUpdate.medicineInfo);
    }));

    if (result == true) {
      Timesupdate.res = false;
      Timesupdate.res2 = false;
      CardInfoUpdate.updOpr=false;

      setState(() {

        setNames();
        print(_selectedName);
        getselectListViewMedicine(_selectedName);

      });
    }
    CardInfoUpdate.updOpr=false;

  }
  getListViewMedicine(){
    _medicineList = _medicineController.getFMedicine();
    _medicineList.then((medList) {
      setState(() {
        this._currentMedicineList = medList;
        this.count = medList.length;
        print('------database ${_currentMedicineList.length}');

      });
    });
  }
  getselectListViewMedicine(String name){
    _medicineList = _medicineController.getselectMedicine(name);
    _medicineList.then((medList) {
      setState(() {
        this._currentMedicineList = medList;
        this.count = medList.length;
        print('------database ${_currentMedicineList.length}');

      });
    });
  }

  Future setNames() async {
    NamesList.clear();
    (await _patientController.getPatientMapList()).forEach((patientMap) {
      setState(() {
        NamesList.add(Patient("").patientMapToObject(patientMap));
      });
    });
    print('------database mosssssssss');

  }

  void _delet(BuildContext context, MedicineInfo medicineInfo) async {
    int result = await _medicineController.deleteselectedMedicine(medicineInfo);
    if (result != 0) {
      // _showSnackBar(context, ' Deleted Successfully');
      getselectListViewMedicine(_selectedName);
      //_selectedDay = '';
    }
  }



}
class CardInfoUpdate {
  static MedicineInfo medicineInfo;
  static bool updOpr;
}