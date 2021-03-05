import '../../model/MedicineInfo.dart';
import 'package:flutter/material.dart';


class MedicineCard extends StatelessWidget {

  final MedicineInfo medicine;
  final Function setData;
  MedicineCard(this.medicine,this.setData);

  @override
  Widget build(BuildContext context) {
    //check if the medicine time is lower than actual
    return Padding(
      padding: const EdgeInsets.only(bottom:16.0),
      child: Container(
          color: Colors.amber,
          child: Card(
              elevation: 2.0,
              margin: EdgeInsets.all( 1.0),
              color: Colors.white,
              child:Column(children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15, top: 5, bottom: 5),
                    child: Image.asset("assets/med.png",
                        width: 40, height: 40),
                  ),
                  Text("${medicine.medTitle} ",),
                  Padding(
                    padding:
                    const EdgeInsets.only(right: 100.0, left: 15),
                    child: Icon(
                      Icons.alarm,
                      size: 20,
                      color: Colors.green,
                    ),
                  ),
                  Text('')
                ]),Divider(color:Colors.amber,thickness:3,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text("تاريخ البدء:${medicine.first_date}",style: TextStyle(fontSize: 12))),
                      Expanded(flex: 1, child: Text("تاريخ الإنتهاء:${medicine.last_date}",style: TextStyle(fontSize: 12),)),],), ),
                Divider(color:Colors.amber),
                Padding(
                  padding: const EdgeInsets.only(right: 32,left: 32),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 1, child: Text("الجرعة")), Expanded(
                          child: SizedBox(
                            height:1,
                          )),
                      Expanded(flex: 1, child: Text("عدد الجرعات")),

                    ],), ),
                Padding(
                  padding: const EdgeInsets.only(right: 32,left: 32,top: 10),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child:
                      Container(margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5,color: Colors.amber),
                            boxShadow:[BoxShadow(color: Colors.amber,spreadRadius: .1,blurRadius: 1,)],
                            borderRadius:BorderRadius.circular(5),
                            color: Colors.white,
                          ),child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${medicine.amount}"),
                          ))), Expanded(
                        child: SizedBox(
                          height:1,
                        ),
                      ),
                      Expanded(flex: 1, child:
                      Container(margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5,color: Colors.amber),
                            boxShadow:[BoxShadow(color: Colors.amber,spreadRadius: .1,blurRadius: 1,)],
                            borderRadius:BorderRadius.circular(5),
                            color: Colors.white,
                          ),child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${medicine.medform}"),
                          ))),

                    ],), ),
                Divider(color:Colors.amber),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text("اسم الطبيب:")),
                      Expanded(flex: 1, child: Text("${medicine.doctname}")),

                    ],), ),
                Divider(color:Colors.amber),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text("التشخيص المرضي:")),
                      Expanded(flex: 1, child: Text("${medicine.diagon}")),

                    ],), ),
                Divider(color:Colors.amber),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text("الملاحظات")),
                      Expanded(flex: 1, child: Text("${medicine.notice}")),

                    ],), ),
                Divider(color:Colors.amber),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text("المرفقات")),


                    ],), ),
              ])
          )),
    );
  }


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
              onPressed: () async {
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
