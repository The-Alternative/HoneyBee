
import 'package:bassel/Config/insert_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Manual_entry extends StatefulWidget {
  @override
  _Manual_entryState createState() => _Manual_entryState();
}

class _Manual_entryState extends State<Manual_entry> {
  var style1 = TextStyle(fontSize: 23, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: 'Times');
  TextEditingController date1Controller = TextEditingController();
  TextEditingController clock1Controller = TextEditingController();
  TextEditingController date2Controller = TextEditingController();
  TextEditingController clock2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
                title: Text(" Times",)),
            body: Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5),
                child: Card(color: Colors.white, elevation: 15.0, child: get_body(),))));
  }

  Widget get_body() {
    return ListView(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 25.0,top: 25),
            child: ListTile(
              title: Text('المواعيد', style: style1),
              trailing: Image.asset("assets/calendar2.png" ,
    width: 75, height: 75,))),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text("الموعد الأول", style: style2,), flex: 1,),
              Expanded(
                child: TextFormField(style: style2, expands: false,
                  keyboardType: TextInputType.number,controller:date1Controller,readOnly: true,onTap: (){
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime(2050, 6, 7),
                        theme: DatePickerTheme(
                            headerColor: Colors.orange,
                            backgroundColor: Colors.blue,
                            itemStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle:
                            TextStyle(color: Colors.white, fontSize: 16)),
                        onConfirm: (date) {
                          // update.udate='confirm $date';
                          print('confirm $date');
                          ch_date(date1Controller,'$date');
                        }, currentTime: DateTime.now(), locale: LocaleType.en);

                  },
                  decoration: InputDecoration(enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.amber),)),
                ), flex: 2,),
              Expanded(
                child:
                Image.asset("assets/calendar3.png" ,
                  width: 60, height: 60,), flex: 1,)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text("الساعة", style: style2,), flex: 1,),
              Expanded(
                child: TextFormField(style: style2, expands: false, readOnly: true,controller: clock1Controller
                  ,onTap: (){

                    DatePicker.showTime12hPicker(context,
                        showTitleActions: true, onConfirm: (date) {
                          print('confirm $date');
                          clock1Controller.text =date.toString().substring(11, 16);
                         // ch_time('$date');
                        }, currentTime: DateTime.now());
                  },
                  decoration: InputDecoration(enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.amber),),),
                ), flex: 2,
              ),
              Expanded(
                child:  Image.asset("assets/clock.png" ,
                  width: 60, height: 60,),
                flex: 1,)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Divider(
            color: Colors.amber,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row
            (
            children: <Widget>
            [
              Expanded(
                child: Text("الموعد الثاني", style: style2,), flex: 1,),
              Expanded(
                child: TextFormField(
                  style: style2, expands: false, readOnly: true,controller: date2Controller,
                  onTap:() {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime(2050, 6, 7),
                        theme: DatePickerTheme(
                            headerColor: Colors.orange,
                            backgroundColor: Colors.blue,
                            itemStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle:
                            TextStyle(color: Colors.white, fontSize: 16)),
                        onConfirm: (date) {
                          // update.udate='confirm $date';
                          print('confirm $date');
                          ch_date(date2Controller,'$date');
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  decoration: InputDecoration(enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.amber),)),
                ), flex: 2,),
              Expanded(
                child: Image.asset("assets/calendar3.png" ,
                  width: 60, height: 60,), flex: 1,)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row
            (
            children: <Widget>
            [
              Expanded(child: Text("الساعة", style: style2,), flex: 1,),
              Expanded(child: TextFormField(style: style2, expands: false, readOnly: true,controller: clock2Controller,
                onTap: (){

                  DatePicker.showTime12hPicker(context,
                      showTitleActions: true, onConfirm: (date) {
                        print('confirm $date');
                        clock2Controller.text =date.toString().substring(11, 16);
                        // ch_time('$date');
                      }, currentTime: DateTime.now());
                },
                decoration: InputDecoration(enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.amber),)),), flex: 2,),
              Expanded(
                child: Image.asset("assets/clock.png" ,
                  width: 60, height: 60,), flex: 1,)
            ],
          ),
        ), Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Divider(
            color: Colors.amber,
            thickness: 1,
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>
        //   [
        //   Image.asset("assets/add_alarm.png" ,
        //    width: 25, height: 25,color: Colors.teal,)],),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>
            [
              Expanded(
                child: FlatButton(child: Text('حفظ', style: style2,),
                    onPressed: () {
                      update_tdata(date1Controller.text,clock1Controller.text,
                          date2Controller.text,clock2Controller.text);
                      if(date1Controller.text !=''&&clock1Controller.text !='')
                               Navigator.pop(context, true);
                    }), flex: 1,),
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.only(),
                  child: Text('الغاء الأمر', style: style2,),
                  onPressed: () {
                    Navigator.pop(context, false);

                  },
                ), flex:1,),
            ],
          ),
        )
      ],
    );
  }
  void update_tdata(String s1, String s2,String s3, String s4) {
    Entry.info =List<Datee>();
    if(s1 != ''&& s2 !='')
    Entry.info .add(Datee(s1, s2)); //عدد المرات
    if(s3 != ''&& s4 !='')
      Entry.info .add(Datee(s3, s4));
  }

  void clear_tdata() {
    Entry.first_clock = "";
    Entry.first_date = "";
  }
  void succses_moveToLastScreen(BuildContext context1) {
    Navigator.pop(context1, true);
  }

  void fail_moveToLastScreen(BuildContext context1) {
    Navigator.pop(context1, false);
  }
  void ch_date(TextEditingController tc,String s) {
    setState(() {
      String ss= s.substring(0, 10);
      var arr = new List(3);
      arr = ss.split('-');
      tc.text =arr[0]+"/"+arr[1]+"/"+arr[2];
    });
  }
}
