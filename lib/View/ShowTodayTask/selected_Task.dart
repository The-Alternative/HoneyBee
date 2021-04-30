import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/Config/general.dart';
import 'package:flutter_task/Config/insert_data.dart';
import 'package:flutter_task/View/AddTask/connectionTask.dart';
import 'package:flutter_task/View/AddTask/publicTask.dart';
import 'package:flutter_task/View/InvidualList/exceuatedList.dart';
import 'package:flutter_task/View/InvidualList/suspendedList.dart';
import 'package:flutter_task/bloc/stage_bloc.dart';
import 'package:flutter_task/models/taskInfo.dart';

import '../../models/eventModel.dart';
import '../../utils/controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

import '../AddTask/add_event.dart';
import 'taskList.dart';
import '../AddTask/selection.dart';



class SelectedEvent extends StatefulWidget {
 // Diary diary;
  List<dynamic> selectedEvents =[];
  EventModel eventModel;
  String text;
  DateTime day;
  SelectedEvent(this.selectedEvents,this.day);
  @override
  _FirstPageState createState() => _FirstPageState(selectedEvents);
}

class _FirstPageState extends State<SelectedEvent> {
  List<EventModel> events = new List();
  List<dynamic> selectedEvents =[];
  List<dynamic> PendingTasks =[];
  List<dynamic> ExeTasks =[];

  _FirstPageState(this.selectedEvents);
  DateTime now = new DateTime.now();
  DateTime date;

  @override
  initState()  {

    date = new DateTime(now.year, now.month, now.day);
    String dayate =new DateTime(widget.day.year, widget.day.month, widget.day.day).toString();
    getPendingTaskList(dayate);
    getExeTaskList(dayate);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;


    return
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: Row(
              children: [
                CircleAvatar(radius: 20,
                  child: Image.asset("assets/to-do-list.png"),backgroundColor: Colors.white,),
                SizedBox(width: 20,),
                Text("المهمات", style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          body:Padding(
              padding: const EdgeInsets.all(0),
              child: ListView(
                children: [
                  Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10), height: 40,
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: "بحث..",
                              hintStyle: TextStyle(
                                  color: Colors.grey[500], fontSize: 13),
                              suffixIcon: Icon(
                                Icons.search, color: Colors.amber, size: 30,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),),
                              enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.white)
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.white)

                              ),
                            ),
                          ),

                        ),
                        Row(mainAxisAlignment:MainAxisAlignment.center ,children: [
                        IconButton(
                        icon: Icon(Icons.arrow_forward_ios_sharp),color: Colors.black, onPressed: () {
                          setState(() {
                            widget.day=widget.day.add(Duration(days: 1));
                          setTimesData('${widget.day}');
                            getPendingTaskList('${widget.day}');
                            getExeTaskList('${widget.day}');

                          });                      },)
                          ,Text('${ DateFormat.yMEd().format(widget.day)}'),
                          IconButton(icon: Icon(Icons.arrow_back_ios_sharp), color: Colors.black, onPressed: () {
                            setState(() {
                              widget.day=widget.day.subtract(Duration(days: 1));
                              setTimesData('${widget.day}');
                              getPendingTaskList('${widget.day}');
                              getExeTaskList('${widget.day}');


                            });
                          },
                          ),],),

                      ],
                    ),
                  ),
                  EventList(widget.selectedEvents,_awaitReturnValueFromAddEventForUpdate),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.grey[500]),
                        boxShadow:[BoxShadow(color: Colors.black12,spreadRadius: .1,blurRadius: 1,)],
                        borderRadius:BorderRadius.circular(5),
                        color: Colors.grey[100],//unpress
                      ),child:ExpansionTile(title: Text('المهمات المنجزة'+'   '+'${ExeTasks.length}'
                          ,style: TextStyle(color:Colors.black54,fontWeight: FontWeight.bold,fontSize: 20),),
                                   leading: SizedBox(height: 25,width: 25,child: Image.asset("assets/true.png")),
                                   backgroundColor: Colors.grey,initiallyExpanded: false,children: [//press
                            Container(child: SuspendedList(ExeTasks),height: 300,color:Colors.white),

                        ],
                      )

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.grey[500]),
                          boxShadow:[BoxShadow(color: Colors.white,spreadRadius: .1,blurRadius: 1,)],
                          borderRadius:BorderRadius.circular(5),
                          color: Colors.grey[300],
                        ),child:ExpansionTile(title: Text('مهمات معلقة',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                          ,leading: SizedBox(height: 25,width: 25,child: Image.asset("assets/indicate.png")),
                          backgroundColor: Colors.white,initiallyExpanded: false,children: [
                            Container(child: SuspendedList(PendingTasks),height: 300,color:Colors.white ,),

                          ],
                        )

                    ),
                  ),
                  Padding(padding: EdgeInsets.all(15),
                      child: new MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
                      elevation: 5.0,
                      minWidth: 150.0,
                      height: 50,
                      color: Colors.red,
                      child: new Text('انشاء مهمة',
                          style: new TextStyle(fontSize: 25.0, color: Colors.white)),
                      onPressed: () async {
                        bool result=false;
                        Entry.incAmount =0;
                        try{
                         result = await  Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return SelectIcons();
                        }));
                        if(result){
                          widget.day = DateTime(Entry.insertDay.year, Entry.insertDay.month
                              , Entry.insertDay.day);
                          setTimesData('${Entry.insertDay}');

                          //addCardListView();
                        }
                      }
                      catch(e){

                      }
                      }
                  ))],
            )));
  }
  String getDayName() {

    String s='26/5/2020';
    var arr = List(3);
    arr = s.split('/');
    var now = DateTime.now();
    int _day = int.parse(arr[2]);
    int _month = int.parse(arr[1]);
    int _year = int.parse(arr[0]);
    date = new DateTime(now.year, now.month,now.day);
    var dna = DateFormat.yMEd().format(date);
    return '$dna';
  }

  setTimesData(String dayate) async {
    print( dayate);

    widget.selectedEvents.clear();
    (await EventController().getInfo('event',dayate,0)).forEach((timeMap) {
      setState(() {
        widget.selectedEvents.add(timeMap);
        print( widget.selectedEvents.length);


      });
      print( widget.selectedEvents.length);

    });

  }
  getPendingTaskList(String dayate) async {
    print( dayate);

    PendingTasks.clear();
    (await EventController().getInfo('event',dayate,1)).forEach((timeMap) {
      setState(() {
        PendingTasks.add(timeMap);
      });

    });

  }
  getExeTaskList(String dayate) async {
    print( dayate);

    ExeTasks.clear();
    (await EventController().getInfo('event',dayate,2)).forEach((timeMap) {
      setState(() {
        ExeTasks.add(timeMap);
      });

    });

  }

  _awaitReturnValueFromAddEventForUpdate(EventModel event) async {
    List<TaskInfo>  stages =[];
    List<TaskInfo>  persons;
    List<TaskInfo>  notices;

    stages = await EventController().getRelatedInfo(event.id);
    persons = await EventController().getPersonInfo(event.id);
    notices = await EventController().getNoticeInfo(event.id);

    if (event.title ==taskTypes[3] )
      {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BlocProvider<StageBloc>(
                create: (context) => StageBloc(),
                child: DialupTask(title: event.title,event:  event,stages:stages,notices: notices,persons: persons,),)
          ),
        );
    if(result){
      widget.day = DateTime(Entry.insertDay.year, Entry.insertDay.month
          , Entry.insertDay.day);
      setTimesData('${Entry.insertDay}');
      getPendingTaskList('${Entry.insertDay}');
      getExeTaskList('${Entry.insertDay}');
      //addCardListView();
    }
    setState(() {

    });

  } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                BlocProvider<StageBloc>(
                  create: (context) => StageBloc(),
                  child: PublicTask(title: event.title,task:  event,stages:stages,notices: notices,persons: persons,),)

        ),
      );
      if(result){
        widget.day = DateTime(Entry.insertDay.year, Entry.insertDay.month
            , Entry.insertDay.day);
        setTimesData('${Entry.insertDay}');
        getPendingTaskList('${Entry.insertDay}');
        getExeTaskList('${Entry.insertDay}');
        //addCardListView();
      }
      setState(() {
        // valueFromAddEvent = result;
        // if (valueFromAddEvent) {
        //   _reloadPage();
        // }
      });
    }




  }



}