import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/Config/general.dart';
import 'package:flutter_task/Config/insert_data.dart';
import 'package:flutter_task/Config/theme_data.dart';
import 'package:flutter_task/View/AddTask/repeater.dart';
import 'package:flutter_task/View/InvidualList/PlaceList.dart';
import 'package:flutter_task/View/InvidualList/noticeList.dart';
import 'package:flutter_task/View/InvidualList/personList.dart';
import 'package:flutter_task/View/InvidualList/stage_list.dart';
import 'package:flutter_task/bloc/stage_bloc.dart';
import 'package:flutter_task/custoum_widgets/custom_button.dart';
import 'package:flutter_task/events/stage_event.dart';
import 'package:flutter_task/mixins/validation_mixin.dart';
import 'package:flutter_task/models/AlarmInfo.dart';
import 'package:flutter_task/models/eventModel.dart';
import 'package:flutter_task/models/notice.dart';
import 'package:flutter_task/models/person.dart';
import 'package:flutter_task/models/stageModel.dart';
import 'package:flutter_task/models/taskInfo.dart';
import 'package:flutter_task/utils/alarm_helper.dart';
import 'package:flutter_task/utils/controller.dart';
import 'package:flutter_task/utils/notification.dart';
import 'package:image_picker/image_picker.dart';

class PublicTask extends StatefulWidget {
  final EventModel task;
  final String title;

  final List<TaskInfo> stages;
  final List<TaskInfo> persons;
  final List<TaskInfo> notices;

  PublicTask({this.task, this.title, this.stages, this.persons, this.notices});

  @override
  _PublicTaskState createState() => _PublicTaskState();
}

class _PublicTaskState extends State<PublicTask> with ValidationMixin {
  String titleIcon ='';
  EventController taskController;
  DateTime _alarmTime, _selectedAlarmTime1, _selectedAlarmTime2;
  AlarmHelper _alarmHelper = AlarmHelper();
  int taskId = 0;
  int _selectedPeeriodAlarmTime1 = 0;
  int _selectedPeeriodAlarmTime2 = 0;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  List<String> pesonList = [];
  List<String> noticeList = [];
  String  plasceList = '';
  String pesonLine = '';
  String noticeLine = '';
  String plasceLine = '';
  String _selectedPeroid = limitedPeriodList[0];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _title;
  TextEditingController _description;
  DateTime _eventDate;
  List<DateTime> repeatList = [];
  TimeOfDay _time;
  bool processing;
  int numOfStages = 0;
  bool _value = false;
  String piriorty = '';
  String _selectedPeroid2 = limitedPeriodList[0];
  String header = "Add New Task";
  String buttonText = "حفظ";
  bool addNewTask = true;
  TextStyle style1 = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black54);
  TextStyle style2 = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 25, color: Colors.grey[400]);
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  TextEditingController inputContrller = TextEditingController();
  TextEditingController pirortyContrller = TextEditingController();

  String foos = 'One';
  int _key;

  _collapse() {
    int newKey;
    do {
      _key = new Random().nextInt(10000);
    } while (newKey == _key);
  }

  @override
  void initState() {
    super.initState();
    Entry.imgPath='';
    titleIcon= !addNewTask ?selectIcon(widget.task.title):selectIcon(widget.title);
    taskController = EventController();
    _title = TextEditingController();
    _description = TextEditingController();
    _eventDate = DateTime.now();
    _time = TimeOfDay.now();
    if (widget.task != null) {
      populateForm();
    }
    processing = false;
  }
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
  void populateForm() {
    print('${widget.task.columnPath1}');
    _title.text = widget.task.description;
    _description.text = widget.task.description;
    _eventDate = widget.task.eventDate;
    piriorty = widget.task.piriority;
     placeController.text =widget.task.columnPlaces;

    dateController.text = "${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}";
    _time = widget.task.time;
    timeController.text = "${_time.hour}:${_time.minute}";
    print(widget.notices.length);
    widget.notices.forEach((element) {
      noticeList.add(element.noticeTitle);
    });
    widget.persons.forEach((element) {
      pesonList.add(element.name);
    });

    if (widget.stages.isNotEmpty)
      widget.stages.forEach((element) {
        BlocProvider.of<StageBloc>(context).state.add(element.columntitle);
      });
    header = "Update Task";
    buttonText = "Update";
    addNewTask = false;
    setState(() {
      header = "Update Task";
      buttonText = "Update";
      addNewTask = false;
    });
  }

  void saveTask(int TaskState) async {
    DateTime mm = DateTime(_eventDate.year, _eventDate.month, _eventDate.day,
        _time.hour, _time.minute);
    calcRepeatList(_eventDate);
    try {
      if (addNewTask)
      {
        if (_selectedPeeriodAlarmTime1 != 0)
          _selectedAlarmTime1 = mm.subtract(Duration(minutes: _selectedPeeriodAlarmTime1));

        if (_selectedPeeriodAlarmTime2 != 0)
          _selectedAlarmTime2 = mm.subtract(Duration(minutes: _selectedPeeriodAlarmTime2));
        Entry.insertDay = new DateTime(_eventDate.year, _eventDate.month, _eventDate.day);
        if (repeatList.isEmpty) {
          taskId = await taskController.saveTask(EventModel(
              title: widget.title,
              description: _title.text,
              piriority: piriorty,
              columnPlaces: placeController.text,
              columnPath1: Entry.imgPath,
              eventDate: _eventDate,
              time: _time));
          Entry.insertDay = new DateTime(_eventDate.year, _eventDate.month, _eventDate.day);

          if (taskId != 0) {
            if (_selectedPeeriodAlarmTime1 != 0) {
              onSaveAlarm(_selectedAlarmTime1, taskId);
              print('mosa here $_selectedAlarmTime1');
            }
            if (_selectedPeeriodAlarmTime2 != 0) {
              onSaveAlarm(_selectedAlarmTime2, taskId);
              print('mosa here $_selectedAlarmTime2');
            }
            if (noticeList.isNotEmpty) {
              for (int i = 0; i < noticeList.length; i++)
                taskController.insertnotice(NoticeModel(
                    noticeTitle: noticeList.elementAt(i), taskId: taskId));
            }
            if (pesonList.isNotEmpty) {
              for (int i = 0; i < pesonList.length; i++)
                taskController.insertPerson(
                    PersonModel(name: pesonList.elementAt(i), taskId: taskId));
            }
            if (taskId != 0 &&
                BlocProvider.of<StageBloc>(context).state.isNotEmpty) {
              for (int i = 0;
                  i < BlocProvider.of<StageBloc>(context).state.length;
                  i++)
                taskController.insertStage(Stage(
                    columntitle:
                        BlocProvider.of<StageBloc>(context).state.elementAt(i),
                    taskId: taskId));
            }
            // if(noticeList.isNotEmpty)
            // {
            //   for(int i =0;i<noticeList.length;i++)
            //     taskController.insertnotice(NoticeModel(noticeTitle: noticeList.elementAt(i),taskId:taskId ));
            // }
          }
        } else {
          for (int i = 0; i < repeatList.length; i++) {
            mm = DateTime(repeatList[i].year, repeatList[i].month,
                repeatList[i].day, _time.hour, _time.minute);

            if (_selectedPeeriodAlarmTime1 != 0)
              _selectedAlarmTime1 = mm.subtract(Duration(minutes: _selectedPeeriodAlarmTime1));

            if (_selectedPeeriodAlarmTime2 != 0)
              _selectedAlarmTime2 = mm.subtract(Duration(minutes: _selectedPeeriodAlarmTime2));

            taskId = await taskController.saveTask(EventModel(
                title: widget.title,
                description: _title.text,
                piriority: piriorty,
                columnPlaces: placeController.text,
                columnPath1: Entry.imgPath,
                eventDate: repeatList[i],
                time: _time));
            if (taskId != 0) {
              if (_selectedPeeriodAlarmTime1 != 0)
                onSaveAlarm(_selectedAlarmTime1, taskId);
              if (_selectedPeeriodAlarmTime2 != 0) {
                onSaveAlarm(_selectedAlarmTime2, taskId);
              }
              if (noticeList.isNotEmpty) {
                for (int i = 0; i < noticeList.length; i++)
                  taskController.insertnotice(NoticeModel(
                      noticeTitle: noticeList.elementAt(i), taskId: taskId));
              }
              if (pesonList.isNotEmpty) {
                for (int i = 0; i < pesonList.length; i++)
                  taskController.insertPerson(PersonModel(
                      name: pesonList.elementAt(i), taskId: taskId));
              }
              if (taskId != 0 &&
                  BlocProvider.of<StageBloc>(context).state.isNotEmpty) {
                for (int i = 0;
                    i < BlocProvider.of<StageBloc>(context).state.length;
                    i++)
                  taskController.insertStage(Stage(
                      columntitle: BlocProvider.of<StageBloc>(context)
                          .state
                          .elementAt(i),
                      taskId: taskId));
              }
            }
          }
        }
      } else {
        print(_eventDate);
        taskId = await taskController.updateTask(
            EventModel(
                id: widget.task.id,
                title: widget.title,
                description: _title.text,
                piriority: piriorty,
                columnPath1: Entry.imgPath,
                columnPlaces: placeController.text,
                eventDate: _eventDate,
                time: _time),
            TaskState);
        Entry.insertDay =
            new DateTime(_eventDate.year, _eventDate.month, _eventDate.day);
        taskController.delRelated(widget.task.id);

        if (noticeList.isNotEmpty) {
          for (int i = 0; i < noticeList.length; i++)
            taskController.insertnotice(NoticeModel(
                noticeTitle: noticeList.elementAt(i), taskId: taskId));
        }

        for (int i = 0; i < pesonList.length; i++)
          taskController.insertPerson(
              PersonModel(name: pesonList.elementAt(i), taskId: taskId));

        if (BlocProvider.of<StageBloc>(context).state.isNotEmpty) {
          for (int i = 0;
              i < BlocProvider.of<StageBloc>(context).state.length;
              i++)
            taskController.insertStage(Stage(
                columntitle:
                    BlocProvider.of<StageBloc>(context).state.elementAt(i),
                taskId: taskId));
        }

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
      await taskController.deleteobj(widget.task.id);
      taskController.delRelated(widget.task.id);
      setState(() {
        processing = false;
      });
      await _goBack();
    } catch (e) {
      print("Error $e");
    }
  }

  void suspendTask(int state) async {
    try {
      await taskController.deleteobj(widget.task.id);
      taskController.delRelated(widget.task.id);
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

  void setData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: _onBackPressedWithButton,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Container(
                child: !addNewTask
                    ? IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.cyan,
                        ),
                        onPressed: () {
                          setState(() {
                            processing = true;
                          });
                          deleteTask();
                        },
                      )
                    : Container(),
              ),
              IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context, false);
                  }),
            ],
            backgroundColor: Colors.white,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Image.asset("assets/to-do-list.png"),
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "المهمات",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.bottomLeft,
                height: 80,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Image.asset(
                        titleIcon,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
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
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  cursorColor: Colors.red[900],
                                  style: style1,
                                  controller: _title,
                                  validator: validateTextInput,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.all(10),
                                        // add padding to adjust icon
                                        child: Image.asset(
                                          "assets/account.png",
                                          fit: BoxFit.fill,
                                        )),
                                    hintText: 'اسم الموعد',
                                    hintStyle: style1,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid)),
                                    contentPadding: EdgeInsets.only(
                                        right: 10, bottom: 15, top: 15),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey,
                                            style: BorderStyle.solid)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey[500]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: .1,
                                    blurRadius: 1,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: ExpansionTile(
                                title: BlocProvider.of<StageBloc>(context)
                                        .state
                                        .isEmpty
                                    ? Text(
                                        'المهمات والبنود الفرعية',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    : Text(
                                        ' بند' +
                                            ' ' +
                                            '${BlocProvider.of<StageBloc>(context).state.length}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                backgroundColor: Colors.white,
                                initiallyExpanded: false,
                                children: [
                                  Container(
                                    child: StageList(setData),
                                    color: Colors.white,
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.check_box_outline_blank,
                                      color: Colors.grey,
                                      size: 30.0,
                                      semanticLabel:
                                          'Text to announce in accessibility modes',
                                    ),
                                    title: TextFormField(
                                      controller: inputContrller,
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          if (value != '') {
                                            BlocProvider.of<StageBloc>(context)
                                                .add(
                                              StageEvent.add(
                                                  inputContrller.text),
                                            );
                                            print(BlocProvider.of<StageBloc>(
                                                    context)
                                                .state
                                                .length);
                                            inputContrller.text = '';
                                          }
                                        });
                                      },
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  cursorColor: Colors.red[900],
                                  style: style1,
                                  readOnly: true,
                                  controller: dateController,
                                  validator: validateTextInput,
                                  onTap: () async {
                                    DateTime picked = await showDatePicker(
                                        context: context,
                                        initialDate: _eventDate,
                                        firstDate:
                                            DateTime(_eventDate.year - 5),
                                        lastDate:
                                            DateTime(_eventDate.year + 5));
                                    if (picked != null) {
                                      setState(() {
                                        _eventDate = picked;
                                        dateController.text =
                                            "${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}";
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hoverColor: Colors.red,
                                    isDense: true,
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.all(10),
                                        // add padding to adjust icon
                                        child: Image.asset(
                                          "assets/calend.png",
                                          color: Colors.cyan,
                                          fit: BoxFit.fill,
                                          height: 40,
                                          width: 40,
                                        )),
                                    hintText: 'التاريخ',
                                    hintStyle: style2,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid)),
                                    contentPadding: EdgeInsets.only(
                                        right: 10, bottom: 15, top: 15),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey,
                                            style: BorderStyle.solid)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  cursorColor: Colors.red[900],
                                  style: style1,
                                  readOnly: true,
                                  controller: timeController,
                                  validator: validateTextInput,
                                  onTap: () async {
                                    TimeOfDay picked = await showTimePicker(
                                        context: context, initialTime: _time);

                                    if (picked != null) {
                                      setState(() {
                                        _time = picked;
                                        timeController.text =
                                            _time.format(context);
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hoverColor: Colors.red,
                                    isDense: true,
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.all(10),
                                        // add padding to adjust icon
                                        child: Image.asset(
                                          "assets/clock.png",
                                          fit: BoxFit.fill,
                                          height: 40,
                                          width: 40,
                                        )),
                                    hintText: 'الوقت',
                                    hintStyle: style2,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid)),
                                    contentPadding: EdgeInsets.only(
                                        right: 10, bottom: 15, top: 15),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey,
                                            style: BorderStyle.solid)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey[500]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: .1,
                                    blurRadius: 1,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: ExpansionTile(
                                leading: Icon(
                                  Icons.add_alert,
                                  color: Colors.amber,
                                  size: 30.0,
                                  semanticLabel:
                                      'Text to announce in accessibility modes',
                                ),
                                title: Text(
                                  'التكرار',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                backgroundColor: Colors.white,
                                initiallyExpanded: false,
                                children: [Radiooo()],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey[500]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: .1,
                                    blurRadius: 1,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: ExpansionTile(
                                leading: Icon(
                                  Icons.add_alert,
                                  color: Colors.amber,
                                  size: 30.0,
                                  semanticLabel:
                                      'Text to announce in accessibility modes',
                                ),
                                title: Text(
                                  'التنبيهات',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                backgroundColor: Colors.white,
                                initiallyExpanded: false,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, right: 15),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "1 - قبل ",
                                          ),
                                          flex: 0,
                                        ),
                                        Expanded(
                                          child: Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey[500]),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    spreadRadius: .1,
                                                    blurRadius: 1,
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                                color: Colors.grey[300],
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: DropdownButton(
                                                    // Not necessary for Option 1

                                                    value: _selectedPeroid,
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        _selectedPeroid =
                                                            newValue;
                                                        calcAlarm2(newValue);
                                                      });
                                                    },
                                                    items: limitedPeriodList
                                                        .map((location) {
                                                      return DropdownMenuItem(
                                                        child:
                                                            new Text(location),
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
                                    padding: const EdgeInsets.only(
                                        bottom: 15, right: 15),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "2 - قبل ",
                                          ),
                                          flex: 0,
                                        ),
                                        Expanded(
                                          child: Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey[500]),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    spreadRadius: .1,
                                                    blurRadius: 1,
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                                color: Colors.grey[300],
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: DropdownButton(
                                                    // Not necessary for Option 1
                                                    value: _selectedPeroid2,
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        _selectedPeroid2 =
                                                            newValue;
                                                        calcAlarm1(newValue);
                                                        print(_selectedPeroid2);
                                                      });
                                                    },
                                                    items: limitedPeriodList
                                                        .map((location) {
                                                      return DropdownMenuItem(
                                                        child:
                                                            new Text(location),
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
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey[500]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: .1,
                                    blurRadius: 1,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: ExpansionTile(
                                title: pesonList.isEmpty
                                    ? Text(
                                        'الأشخاص',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    : Text(
                                        ' اشخاص' + ' ' + '${pesonList.length}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                backgroundColor: Colors.white,
                                initiallyExpanded: false,
                                children: [
                                  Container(
                                    child: PersonList(setData, pesonList),
                                    color: Colors.white,
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.check_box_outline_blank,
                                      color: Colors.grey,
                                      size: 30.0,
                                      semanticLabel:
                                          'Text to announce in accessibility modes',
                                    ),
                                    title: TextFormField(
                                      controller: inputContrller,
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          if (value != '') {
                                            pesonList.add(inputContrller.text);
                                            inputContrller.text = '';
                                          }
                                        });
                                      },
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey[500]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: .1,
                                    blurRadius: 1,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: ExpansionTile(
                                title: noticeList.isEmpty
                                    ? Text(
                                        'ملاحظات',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    : Text(
                                        ' ملاحظات' +
                                            ' ' +
                                            '${noticeList.length}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                backgroundColor: Colors.white,
                                initiallyExpanded: false,
                                children: [
                                  Container(
                                    child: NoticeList(setData, noticeList),
                                    color: Colors.white,
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.check_box_outline_blank,
                                      color: Colors.grey,
                                      size: 30.0,
                                      semanticLabel:
                                          'Text to announce in accessibility modes',
                                    ),
                                    title: TextFormField(
                                      controller: inputContrller,
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          if (value != '') {
                                            noticeList.add(inputContrller.text);
                                            inputContrller.text = '';
                                          }
                                        });
                                      },
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey[500]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: .1,
                                    blurRadius: 1,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: ExpansionTile(
                                title: placeController.text ==''
                                    ? Text(
                                        'المكان',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    : Text(
                                        '${placeController.text}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                backgroundColor: Colors.white,
                                initiallyExpanded: false,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:20,right: 20,bottom: 10),
                                    child: TextFormField(
                                      cursorColor: Colors.red[900],
                                      style: style1,
                                      controller: placeController,
                                      validator: validateTextInput,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        prefixIcon: Padding(
                                            padding: EdgeInsets.all(10),
                                            // add padding to adjust icon
                                            child: Image.asset(
                                              "assets/google-maps.png",
                                              fit: BoxFit.fill,
                                            )),
                                        hintText: 'المكان',
                                        hintStyle: style1,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid)),
                                        contentPadding: EdgeInsets.only(
                                            right: 10, bottom: 15, top: 15),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.grey)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                style: BorderStyle.solid)),
                                      ),
                                    )
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey[500]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: .1,
                                    blurRadius: 1,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: ExpansionTile(
                                title: Text(
                                  ' المرفقات',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                backgroundColor: Colors.white,
                                initiallyExpanded: false,
                                children: [imageProfile()],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.grey[500]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: .1,
                                    blurRadius: 1,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: ExpansionTile(
                                  title: piriorty == ''
                                      ? Text(
                                          'الأهمية',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )
                                      : Text(
                                          piriorty,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                  backgroundColor: Colors.white,
                                  initiallyExpanded: _value,
                                  key: new Key(_key.toString()),
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              child: Column(
                                                children: [
                                                  IconButton(
                                                    icon: Image.asset(
                                                      taskPeriorityShape[4],
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        piriorty =
                                                            taskPeriority[4];
                                                        _collapse();
                                                      });
                                                    },
                                                    iconSize: 50,
                                                  ),
                                                  Text(taskPeriority[4])
                                                ],
                                              ),
                                              color: PiriorityColors.unImp,
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  IconButton(
                                                    icon: Image.asset(
                                                      taskPeriorityShape[3],
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        piriorty =
                                                            taskPeriority[3];

                                                        _collapse();
                                                      });
                                                    },
                                                    iconSize: 50,
                                                  ),
                                                  Text(taskPeriority[3])
                                                ],
                                              ),
                                              color: PiriorityColors.lessImp,
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  IconButton(
                                                    icon: Image.asset(
                                                      taskPeriorityShape[2],
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        piriorty =
                                                            taskPeriority[2];
                                                        _collapse();
                                                      });
                                                    },
                                                    iconSize: 50,
                                                  ),
                                                  Text(taskPeriority[2])
                                                ],
                                              ),
                                              color: PiriorityColors.medImp,
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  IconButton(
                                                    icon: Image.asset(
                                                      taskPeriorityShape[1],
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        piriorty =
                                                            taskPeriority[1];
                                                        _collapse();
                                                      });
                                                    },
                                                    iconSize: 50,
                                                  ),
                                                  Text(taskPeriority[1])
                                                ],
                                              ),
                                              color: PiriorityColors.Imp,
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  IconButton(
                                                    icon: Image.asset(
                                                      taskPeriorityShape[0],
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        piriorty =
                                                            taskPeriority[0];
                                                        _collapse();
                                                      });
                                                    },
                                                    iconSize: 50,
                                                  ),
                                                  Text(taskPeriority[0])
                                                ],
                                              ),
                                              color: PiriorityColors.highImp,
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                      ],
                                    )
                                  ])),
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
                                      !addNewTask? Container():CustomButton(
                                          fontSize: 20,
                                          buttonColor: GradientColors.sea[0],
                                          buttonText: textbutton[0],
                                          width:
                                              MediaQuery.of(context).size.width,
                                          onPressed: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              setState(() {
                                                processing = true;
                                              });
                                              saveTask(0);
                                            }
                                          }),
                                      SizedBox(height: 10.0),
                                      Container(
                                        child: !addNewTask
                                            ? CustomButton(
                                                buttonText: textbutton[1],
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                buttonColor: Colors.redAccent,
                                                onPressed: () async {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    setState(() {
                                                      processing = true;
                                                    });
                                                    saveTask(1);
                                                  }
                                                })
                                            : Container(),
                                      ),
                                      SizedBox(height: 10.0),
                                      Container(
                                        child: !addNewTask
                                            ? CustomButton(
                                                buttonText: textbutton[2],
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                buttonColor: kColorInStock,
                                                onPressed: () async {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    setState(() {
                                                      processing = true;
                                                    });
                                                    saveTask(2);
                                                  }
                                                })
                                            : Container(),
                                      ),
                                      SizedBox(height: 20.0),
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

  String populateline(List<String> list) {
    int i = 1;
    String info = list[0];
    if (list.length > 1) {
      while (i < list.length) {
        info = info + ':' + list[i];
        i = i + 1;
      }
    }
    print(info);
    return info;
  }

  calcRepeatList(DateTime day) {
    int j = 0;
    if (Entry.incAmount != 0) {
      repeatList.clear();
      switch (Entry.code) {
        case 'يوميا':
          for (int i = 0; i < Entry.incAmount; i++) {
            repeatList.add(day.add(Duration(days: i)));
          }
          break;

        case 'أسبوعيا':
          for (int i = 0; i < Entry.incAmount; i++) {
            repeatList.add(day.add(Duration(days: j)));
            j = j + 7;
          }
          break;

        case 'شهريا':
          for (int i = 0; i < Entry.incAmount; i++) {
            repeatList.add(day.add(Duration(days: j)));
            j = j + 28;
          }
          break;

        case 'سنويا':
          for (int i = 0; i < Entry.incAmount; i++) {
            repeatList.add(day.add(Duration(days: j)));
            j = j + 365;
          }
          break;
      }
    }
  }

  void onSaveAlarm(DateTime dt, int task) async {
    print('herre');
    DateTime scheduleAlarmDateTime;
    _alarmTime = dt;
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      return;
    var alarmInfo = AlarmInfo(
        alarmDateTime: scheduleAlarmDateTime, title: 'alarm', taskId: taskId);
    int a = await _alarmHelper.insertAlarm(alarmInfo);
    alarmInfo.id = a;
    Ass.scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    print('${alarmInfo.alarmDateTime}');

    //Navigator.pop(this.context);
  }

  calcAlarm1(String hh) {
    const String s = '';
    switch (hh) {
      case 'ربع ساعة':
        _selectedPeeriodAlarmTime1 = 15;
        break;
      case 'نصف ساعة':
        _selectedPeeriodAlarmTime1 = 30;
        break;
      case 'ساعة':
        _selectedPeeriodAlarmTime1 = 60;
        break;
      case 'ساعتان':
        _selectedPeeriodAlarmTime1 = 120;
        break;
      case 'يوم':
        _selectedPeeriodAlarmTime1 = 24 * 60;
        break;
      case 'يومان':
        _selectedPeeriodAlarmTime1 = 24 * 60 * 2;

        break;
      case 'أسبوع':
        _selectedPeeriodAlarmTime1 = 24 * 60 * 7;
        break;
    }
  }

  calcAlarm2(String hh) {
    const String s = '';
    switch (hh) {
      case 'ربع ساعة':
        _selectedPeeriodAlarmTime2 = 15;
        break;
      case 'نصف ساعة':
        _selectedPeeriodAlarmTime2 = 30;
        break;
      case 'ساعة':
        _selectedPeeriodAlarmTime2 = 60;
        break;
      case 'ساعتان':
        _selectedPeeriodAlarmTime2 = 120;
        break;
      case 'يوم':
        _selectedPeeriodAlarmTime2 = 24 * 60;
        break;
      case 'يومان':
        _selectedPeeriodAlarmTime2 = 24 * 60 * 2;

        break;
      case 'أسبوع':
        _selectedPeeriodAlarmTime2 = 24 * 60 * 7;
        break;
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text("اختر صورة ",
              style: TextStyle(
                fontSize: 18.0,
              )),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("التقاط صورة"),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("معرض الصور"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          Container(
            child: _imageFile == null
                ? !addNewTask?(widget.task.columnPath1 != null?
      Image.file(File(widget.task.columnPath1)):Text(' لا يوجد صورة'))
        :Text('سجل تجاري')
                :
            Image.file(File(_imageFile.path)),
            width: 160.0,
            height: 180,
          ),
          Positioned(
              bottom: 10.0,
              right: 15.0,
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet()),
                    );
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 35,
                  )))
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
      Entry.imgPath=_imageFile.path;
      print(_imageFile.path);
    });
  }
}
