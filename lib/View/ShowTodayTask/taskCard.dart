import 'dart:io';
import 'dart:math';

import 'package:flutter_task/Config/general.dart';

import '../../models/eventModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatefulWidget {
  final EventModel event;
  final Function fun;

  EventCard(this.event, this.fun);
  @override
  State<StatefulWidget> createState() {
    return _EventCard(this.event);
  }
}
class _EventCard extends State<EventCard> {
 EventModel event;
  _EventCard(this.event);
  var style10 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w200,
    fontFamily: 'Times',
  );
  var style1 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times');
  var style4 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times', color: Colors.white);
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
    //check if the medicine time is lower than

    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
      border: Border.all(width: 0.5,color: Colors.amber),
      boxShadow:[BoxShadow(color: Colors.amber,spreadRadius: .1,blurRadius: 1,)],
      borderRadius:BorderRadius.circular(5),
      color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(children: <Widget>[
        Row(mainAxisAlignment:MainAxisAlignment.center ,children: [
          Expanded(flex: 4,child: ListTile(title:Text(event.title) ,subtitle: Text(event.description),
              trailing: CircleAvatar(radius: 15,
                child: event.piriority !=''?
                Image.asset(selectPriority(event.piriority)):Container(),
                backgroundColor: selectcolor(event.piriority))
         ,leading: Image.asset(selectIcon(event.title)),
            onTap: (){
            print('${event.piriority}');
            widget.fun(event);},
            )),
          Expanded(flex: 1,child: Container(color: Colors.black12,height: 100,
              child:Column(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(height: 40,width: 40,child: Image.asset("assets/alarm-clock.png")),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text('${event.time.format(context) }', style: TextStyle(fontSize: 14),),
                ),
              ],)
          )),

        ],)
      ])),
    );
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


 String selectIcon( String title){
   switch(title)
   {
     case 'عمل':
       return taskShapes[0];
       break;
     case 'رياضة':
       return taskShapes[1];
       break;
     case 'قائمة مشتريات':
       return taskShapes[2];
       break;
     case 'اتصال هاتفي':
       return taskShapes[3];
       break;
     case 'موعد طبي':
       return taskShapes[4];
       break;
     case 'مناسبات':
       return taskShapes[5];
       break;
     case 'سفر':
       return taskShapes[6];
       break;
     case 'مدفوعات':
       return taskShapes[7];
       break;
     case 'ترفيه':
       return taskShapes[8];
       break;
     case 'شخصية':
       return taskShapes[9];
       break;
     case 'زيارة':
       return taskShapes[10];
       break;
     case 'مهمات اخرى':
       return taskShapes[11];
       break;
   }
}
 String selectPriority( String title){
   switch(title)
   {
     case 'عالي الأهمية':
       return taskPeriorityShape[0];
       break;
     case 'هام':
       return taskPeriorityShape[1];
       break;
     case 'متوسط الأهمية':
       return taskPeriorityShape[2];
       break;
     case 'أهمية منخفصة':
       return taskPeriorityShape[3];
       break;
     case 'غير هام':
       return taskPeriorityShape[4];
       break;

   }
 }
 Color selectcolor( String title){
   switch(title)
   {
     case 'عالي الأهمية':
       return Colors.red;
       break;
     case 'هام':
       return Colors.blueAccent;
       break;
     case 'متوسط الأهمية':
       return Colors.green;
       break;
     case 'أهمية منخفصة':
       return Colors.amber;
       break;
     case 'غير هام':
       return Colors.black45;
       break;
     default: {
       return Colors.white38;

     }   }
 }

}
