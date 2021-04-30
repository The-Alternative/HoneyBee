import 'dart:math';

import 'package:flutter_task/Config/general.dart';
import 'package:flutter_task/Config/general.dart';
import 'package:flutter_task/Config/general.dart';
import 'package:flutter_task/Config/insert_data.dart';
import 'package:flutter_task/Config/theme_data.dart';
import 'package:flutter_task/models/stageModel.dart';
import 'package:flutter_task/Config/general.dart';
import 'package:flutter_task/bloc/stage_bloc.dart';
import 'package:flutter_task/events/stage_event.dart';
import 'package:flutter_task/custoum_widgets/custom_button.dart';
import 'package:flutter_task/mixins/validation_mixin.dart';
import 'package:flutter_task/models/eventModel.dart';
import 'package:flutter_task/models/taskInfo.dart';
import 'package:flutter_task/utils/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../InvidualList/stage_list.dart';

class DialupTask extends StatefulWidget {
  final String title;
  final EventModel event;
  final List<TaskInfo>  stages;
  final List<TaskInfo>  persons;
  final List<TaskInfo>  notices;


  const DialupTask({this.event, this.title, this.stages, this.persons, this.notices});
  @override
  _DialupTaskState createState() => _DialupTaskState();
}

class _DialupTaskState extends State<DialupTask> with ValidationMixin {
  EventController eventController;
  int taskId=0;
  List<String> listInfo =[];
  String _selectedPeroid = limitedPeriodList[0];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _title;
  TextEditingController _description;
  DateTime _eventDate;
  TimeOfDay _time;
  bool processing;
  int numOfStages=0;
  bool _value=false;
  String piriorty ='';
  String _selectedPeroid2= limitedPeriodList[0];
  String header = "Add New Task";
  String buttonText = "حفظ";
  bool addNewTask = true;
  TextStyle style1=TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black54);
  TextStyle style2=TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.grey[400]);
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController inputContrller = TextEditingController();

  String foos = 'One';
  int _key;

  _collapse() {
    int newKey;
    do {
      _key = new Random().nextInt(10000);
    } while(newKey == _key);}
  @override
  void initState() {
    super.initState();
    eventController = EventController();
    _title = TextEditingController();
    _description = TextEditingController();
    _eventDate = DateTime.now();
    _time = TimeOfDay.now();
    if (widget.event != null) {
      populateForm();
    }
    processing = false;
  }

  void populateForm() {
    _title.text = widget.event.description;
    _description.text = widget.event.description;
    _eventDate = widget.event.eventDate;
    dateController.text = "${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}";
    _time = widget.event.time;
    timeController.text ="${_time.hour}:${_time.minute}";
    header = "Update Task";
    buttonText = "Update";
    addNewTask = false;
    setState(() {
      header = "Update Task";
      buttonText = "Update";
      addNewTask = false;
    });
  }

  void saveTask() async {

    try {
      if (addNewTask) {
       taskId=  await eventController.saveTask(EventModel(
            title: 'اتصال هاتفي',
            description: _title.text,
            piriority: piriorty,
            eventDate: _eventDate,
            time: _time));
       Entry.insertDay = new DateTime(_eventDate.year, _eventDate.month, _eventDate.day);

       if(taskId != 0 && BlocProvider.of<StageBloc>(context).state.isNotEmpty){
         for(int i=0;i<BlocProvider.of<StageBloc>(context).state.length;i++)
           eventController.insertStage(Stage(columntitle: BlocProvider.of<StageBloc>(context).state.elementAt(i),taskId: taskId));
       }
      } else {
        await eventController.updateTask(EventModel(
            id: widget.event.id,
            title: _title.text,
            description: _description.text,
            eventDate: _eventDate,
            time: _time),0);
      }

      setState(() {
        processing = false;
      });
      await _goBack();
    } catch (e) {
      print("Error $e");
    }
  }

  void deleteTask() async {
    try {
      Entry.insertDay = new DateTime(_eventDate.year, _eventDate.month, _eventDate.day);
      await eventController.deleteobj(widget.event.id);
      setState(() {
        processing = false;
      });
      await _goBack();
    } catch (e) {
      print("Error $e");
    }
  }

  Future<bool> _goBack() async {
    Navigator.of(context).pop(true);
    return false;
  }

  Future<bool> _onBackPressedWithButton() async {
    Navigator.of(context).pop(false);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: _onBackPressedWithButton,
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.bottomLeft,
                height: 80,
                child: Row(children: [Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Image.asset(
                    "assets/call.png",
                    width: 30,
                    height: 30,
                  ),
                ),Text('اتصال',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold ),)],
                    ),
              ),

              Expanded(
                child: Form(
                  key: _formKey,

                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Expanded(flex: 2,
                                child: TextFormField(cursorColor: Colors.red[900],
                                  style: style1,
                                  controller: _title,
                                  validator: validateTextInput,
                                  decoration: InputDecoration(isDense: true,prefixIcon: Padding(
                                    padding: EdgeInsets.all(10), // add padding to adjust icon
                                    child:  Image.asset(
                                      "assets/account.png",        fit: BoxFit.fill,


                                    )),hintText: 'الاسم',hintStyle: style1,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(style: BorderStyle.solid)),
                                    contentPadding: EdgeInsets.only(right: 10,bottom: 15,top: 15),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,
                                        style:BorderStyle.solid)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                         SizedBox(height: 20,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Expanded(flex: 2,
                                child: TextFormField(cursorColor: Colors.red[900],
                                  style: style1,
                                  readOnly: true,
                                  controller: dateController,
                                  validator: validateTextInput,
                                  onTap: () async {
                                    DateTime picked = await showDatePicker(
                                        context: context,
                                        initialDate: _eventDate,
                                        firstDate: DateTime(_eventDate.year - 5),
                                        lastDate: DateTime(_eventDate.year + 5));
                                    if (picked != null) {
                                      setState(() {
                                        _eventDate = picked;
                                        dateController.text = "${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}";

                                      });
                                    }
                                  },
                                  decoration: InputDecoration(hoverColor: Colors.red,isDense: true,prefixIcon: Padding(
                                      padding: EdgeInsets.all(10), // add padding to adjust icon
                                      child:  Image.asset(
                                        "assets/calend.png",color: Colors.cyan,
                                        fit: BoxFit.fill,height:40 ,width:40 ,


                                      )),hintText: 'التاريخ',hintStyle: style2,

                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(style: BorderStyle.solid)),
                                    contentPadding: EdgeInsets.only(right: 10,bottom: 15,top: 15),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,
                                        style:BorderStyle.solid)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Expanded(flex: 2,
                                child: TextFormField(cursorColor: Colors.red[900],
                                  style: style1,
                                  readOnly: true,
                                  controller: timeController,
                                  validator: validateTextInput,onTap: () async {
                                    TimeOfDay picked = await showTimePicker(
                                        context: context, initialTime: _time);

                                    if (picked != null) {
                                      setState(() {
                                        _time = picked;
                                        timeController.text =_time.format(context);
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(hoverColor: Colors.red,isDense: true,prefixIcon: Padding(
                                      padding: EdgeInsets.all(10), // add padding to adjust icon
                                      child:  Image.asset(
                                        "assets/clock.png",
                                        fit: BoxFit.fill,height:40 ,width:40 ,


                                      )),hintText: 'الوقت',hintStyle: style2,

                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(style: BorderStyle.solid)),
                                    contentPadding: EdgeInsets.only(right: 10,bottom: 15,top: 15),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,
                                        style:BorderStyle.solid)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),

                          Container(margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Colors.grey[500]),
                                boxShadow:[BoxShadow(color: Colors.white,spreadRadius: .1,blurRadius: 1,)],
                                borderRadius:BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),child:ExpansionTile(
                                title: BlocProvider.of<StageBloc>(context).state.isEmpty?Text('بنود وتفاصيل',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),):
                                Text(' بند'+' '+'${BlocProvider.of<StageBloc>(context).state.length}',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                                backgroundColor: Colors.white,initiallyExpanded: false,children: [
                                  Container(child:  StageList(setData),
                                    color:Colors.white ,),ListTile(
                                    leading:  Icon(
                                    Icons.check_box_outline_blank,
                                    color: Colors.grey,
                                    size: 30.0,
                                    semanticLabel: 'Text to announce in accessibility modes',)
                                    ,title: TextFormField(controller:inputContrller ,onFieldSubmitted: (value) {
                                      setState(() {
                                        if(value!=''){
                                          BlocProvider.of<StageBloc>(context).add(
                                            StageEvent.add(inputContrller.text),
                                          );
                                        print(BlocProvider.of<StageBloc>(context).state.length);
                                        inputContrller.text='';
                                        }

                                      });
                                    },),)

                                ],
                              )

                          ),
                          SizedBox(height: 20,),

                          Container(margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Colors.grey[500]),
                                boxShadow:[BoxShadow(color: Colors.white,spreadRadius: .1,blurRadius: 1,)],
                                borderRadius:BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),child:ExpansionTile(
                                leading: Icon(
                                  Icons.add_alert,
                                  color: Colors.amber,
                                  size: 30.0,
                                  semanticLabel: 'Text to announce in accessibility modes',),
                                title: Text('التنبيهات',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                backgroundColor: Colors.white,initiallyExpanded: false,children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15, right: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text("1 - قبل ",), flex: 0,),

                                      Expanded(
                                        child: Container(margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1,color: Colors.grey[500]),
                                              boxShadow:[BoxShadow(color: Colors.white,spreadRadius: .1,blurRadius: 1,)],
                                              borderRadius:BorderRadius.circular(1),
                                              color: Colors.grey[300],
                                            ),child: DropdownButtonHideUnderline(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10,right: 10),
                                                child: DropdownButton(
                                                  // Not necessary for Option 1
                                                  value: _selectedPeroid,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _selectedPeroid = newValue;
                                                      print(_selectedPeroid);
                                                    });
                                                  },
                                                  items: limitedPeriodList.map((location) {
                                                    return DropdownMenuItem(
                                                      child: new Text(location),
                                                      value: location,
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            )),
                                        flex: 2,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15, right: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text("2 - قبل ",), flex: 0,),

                                      Expanded(
                                        child: Container(margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1,color: Colors.grey[500]),
                                              boxShadow:[BoxShadow(color: Colors.white,spreadRadius: .1,blurRadius: 1,)],
                                              borderRadius:BorderRadius.circular(1),
                                              color: Colors.grey[300],
                                            ),child: DropdownButtonHideUnderline(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10,right: 10),
                                                child: DropdownButton(
                                                  // Not necessary for Option 1
                                                  value: _selectedPeroid2,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _selectedPeroid2 = newValue;
                                                      print(_selectedPeroid2);
                                                    });
                                                  },
                                                  items: limitedPeriodList.map((location) {
                                                    return DropdownMenuItem(
                                                      child: new Text(location),
                                                      value: location,
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            )),
                                        flex: 2,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                              )

                          ),
                          SizedBox(height: 20,),

                         SizedBox(height: 20,),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 16.0, vertical: 8.0),
                          //   child: TextFormField(
                          //     textInputAction: TextInputAction.done,
                          //     controller: _description,
                          //     minLines: 3,
                          //     maxLines: 5,
                          //     validator: validateTextInput,
                          //     decoration: InputDecoration(
                          //         labelText: "description",
                          //         border: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(10))),
                          //   ),
                          // ),

                    //Conta
                          Container(margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Colors.grey[500]),
                                boxShadow:[BoxShadow(color: Colors.white,spreadRadius: .1,blurRadius: 1,)],
                                borderRadius:BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),child:ExpansionTile(
                                title: piriorty ==''? Text('الأهمية',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                                  :Text(piriorty,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                                backgroundColor: Colors.white,initiallyExpanded: _value,
                                key: new Key(_key.toString()),children: [
                                  Row(children: [

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(width:100 ,height: 100,
                                      child: Column(children: [
                                        IconButton(icon:Image.asset(
                                          taskPeriorityShape[4],
                                      width: 50,
                                      height: 50,
                                    ) ,
                                          onPressed:(){setState(() {
                                            piriorty =taskPeriority[4];
                                            _collapse();

                                          });},iconSize: 50,),
                                      Text(taskPeriority[4])],),color: PiriorityColors.unImp,),
                                  ),flex: 1,
                                ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(children: [
                                            IconButton(icon:Image.asset(
                                              taskPeriorityShape[3],
                                              width: 50,
                                              height: 50,
                                            ) ,
                                              onPressed:(){setState(() {
                                                piriorty =taskPeriority[3];

                                                _collapse();

                                              });},iconSize: 50,),
                                            Text(taskPeriority[3])],),color:PiriorityColors.lessImp,),
                                      ),flex: 1,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(children: [
                                            IconButton(icon:Image.asset(
                                              taskPeriorityShape[2],
                                              width: 50,
                                              height: 50,
                                            ) ,
                                              onPressed:(){setState(() {
                                                piriorty =taskPeriority[2];
                                                _collapse();

                                              });},iconSize: 50,),
                                            Text(taskPeriority[2])],),color: PiriorityColors.medImp,),
                                      ),flex: 1,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(children: [
                                            IconButton(icon:Image.asset(
                                              taskPeriorityShape[1],
                                              width: 50,
                                              height: 50,
                                            ) ,
                                              onPressed:(){setState(() {
                                                piriorty =taskPeriority[1];
                                                _collapse();

                                              });},iconSize: 50,),
                                            Text(taskPeriority[1])],),color:PiriorityColors.Imp,),
                                      ),flex: 1,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(children: [
                                            IconButton(icon:Image.asset(
                                              taskPeriorityShape[0],
                                              width: 50,
                                              height: 50,
                                            ) ,
                                              onPressed:(){setState(() {
                                                piriorty =taskPeriority[0];
                                                _collapse();

                                              });},iconSize: 50,),
                                            Text(taskPeriority[0])],),color: PiriorityColors.highImp,),
                                      ),flex: 1,
                                    ),

                              ],)]
                              )

                          ),
                          SizedBox(height: 10.0),
                          processing
                              ? Center(child: CircularProgressIndicator())
                              : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: <Widget>[
                                CustomButton(
                                  fontSize: 20,
                                  buttonColor: GradientColors.sea[0],
                                    buttonText: buttonText,
                                    width:
                                    MediaQuery.of(context).size.width,
                                    onPressed: () async {
                                      if (_formKey.currentState
                                          .validate()) {
                                        setState(() {
                                          processing = true;
                                        });
                                        saveTask();
                                      }
                                    }),
                                SizedBox(height: 10.0),
                                Container(
                                  child: !addNewTask
                                      ? CustomButton(
                                      buttonText: "Delete",
                                      width: MediaQuery.of(context)
                                          .size
                                          .width,
                                      buttonColor: Colors.redAccent,
                                      onPressed: () async {
                                        setState(() {
                                          processing = true;
                                        });
                                        deleteTask();
                                      })
                                      : Container(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void setData(){
    setState(() {

    });
  }

}