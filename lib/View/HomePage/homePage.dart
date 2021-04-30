
import '../ShowTodayTask/selected_Task.dart';
import '../AddTask/add_event.dart';
import '../../utils/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/eventModel.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _calendarController;
  TextEditingController _eventController;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  List<EventModel> allEvents;
  EventController dbService;
  bool valueFromAddEvent = false;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    allEvents =[];
    _selectedEvents = [];
    dbService = EventController();
  }

  Map<DateTime, List<dynamic>> _fromModelToEvent(List<EventModel> events) {
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(
          event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });

    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  _awaitReturnValueFromAddEvent() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddEvent(),
        ));

    setState(() {});
  }

  _awaitReturnValueFromAddEventForUpdate(EventModel event) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddEvent(
            event: event,
          ),
        ));

    setState(() {
      valueFromAddEvent = result;
      if (valueFromAddEvent) {
        _reloadPage();
      }
    });
  }

  _reloadPage() async {
    print("reload");
    await new Future.delayed(const Duration(milliseconds: 0));
    Navigator.of(context, rootNavigator: false).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => HomePage(),
          transitionDuration: Duration(seconds: 0),
        ),
            (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body:  FutureBuilder<List<EventModel>>(
        // future: dbService.getEvents(),
          future: dbService.getAll(0),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              allEvents = snapshot.data;
              if (allEvents.isNotEmpty) {
                _events = _fromModelToEvent(allEvents);
              }
            }
            return Directionality(textDirection:TextDirection.ltr , child:
            SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 64),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          SizedBox(height: 15),

                           MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0),)),
                              elevation: 5.0,splashColor:Colors.amber ,
                              minWidth: 300.0,
                              height: 40,
                              color: Colors.white,highlightColor:Colors.amber ,
                              child:  Text('مواعيد ومهمات',
                                  style: new TextStyle(fontSize: 16.0, color: Colors.black)),
                              onPressed: () async {
                                DateTime now = new DateTime.now();
                                now = new DateTime(now.year, now.month, now.day);
                                if (allEvents.isNotEmpty ) {
                                  _selectedEvents.clear();
                                  allEvents.forEach((element) {
                                    if(new DateTime(element.eventDate.year,element.eventDate.month,element.eventDate.day) == now)
                                      _selectedEvents.add(element);

                                  });

                                }
                                moveToScreen(_selectedEvents,now);
                              }
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Divider(color: Colors.amber,thickness: 2,),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8 ,right:8 ,bottom: 8,top:0 ),
                      child: TableCalendar(

                        events: _events,
                        formatAnimation: FormatAnimation.slide,
                        availableGestures: AvailableGestures.all,
                        availableCalendarFormats: const {
                          CalendarFormat.month: '',
                          CalendarFormat.week: '',
                        },
                        initialCalendarFormat: CalendarFormat.month,
                        calendarStyle: CalendarStyle(
                          todayColor: Theme.of(context).primaryColor,
                          selectedColor: Theme.of(context).primaryColor,
                          todayStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white),
                          weekendStyle:
                          TextStyle(color: Colors.black.withOpacity(0.2)),
                          outsideDaysVisible: false,
                        ),
                          headerStyle: HeaderStyle(
                            centerHeaderTitle: true,
                            formatButtonVisible: false,
                          ),
                        startingDayOfWeek: StartingDayOfWeek.sunday,weekendDays: [5,6],
                        daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            weekendStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        onDaySelected: (day, events, holidays) {
                          DateTime now = new DateTime.now();
                          now = new DateTime(now.year, now.month, now.day);
                          setState(() {
                            _selectedEvents = events;
                            moveToScreen(_selectedEvents,new DateTime(day.year, day.month, day.day));

                          });
                        },
                        builders: CalendarBuilders(
                          dayBuilder:(context, date, events) {
                            if(events == null)
                            events =List<dynamic>();
                            if(events.length>0)
                           return Container(
                                margin: EdgeInsets.all(4),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.amber, width: 2),
                                    shape: BoxShape.circle),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.black),
                                ));
                            else
                              return Container(
                                  margin: EdgeInsets.all(4),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white10,
                                      shape: BoxShape.circle),
                                  child: Text(
                                    date.day.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ));
                          },

                            selectedDayBuilder: (context, date, events) =>
                                Container(
                                    margin: EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle),
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(color: Colors.white),
                                    )),

                            todayDayBuilder: (context, date, enevts) =>
                                Container(
                                    margin: EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle),
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(color: Colors.black),
                                    ))
                        ,  markersBuilder: (context, date, events, holidays) {

                          final children = <Widget>[];

                          if (events.isNotEmpty) {
                            children.add(
                              Positioned(
                                right: 0,
                                top:  0,
                                child: _buildEventsMarker(date, events),
                              ),
                            );
                          }


                          return children;
                        }
                        ),
                        calendarController: _calendarController,


                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Daily Tasks',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    ..._selectedEvents.map((event) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                child: Text(
                                  event.time.format(context),
                                  // event.time.toString(),
                                  style: TextStyle(fontSize: 16),
                                )),
                            GestureDetector(
                              onTap: () {
                                _awaitReturnValueFromAddEventForUpdate(event);
                              },
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.teal[300],
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0, 2),
                                            blurRadius: 2.0)
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        event.title,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        event.description,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        )))
                  ],
                )));
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _awaitReturnValueFromAddEvent();
          }),
    );
  }
  moveToScreen(List<dynamic> selectedEvents,DateTime day) async {
    print(day);
    bool result = await  Navigator.push(context, MaterialPageRoute(builder: (context) {
      return
        Directionality(child:SelectedEvent(selectedEvents,day) ,textDirection:TextDirection.rtl,);
    }));
    result =false;
    if(result){
      //addCardListView();
    }
    setState(() {});

  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.red
            : _calendarController.isToday(date)
            ? Colors.red
            : Colors.red[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}