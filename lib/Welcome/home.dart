
import '../views/medicine/AddMedcine/main_input.dart';
import '../views/medicine/View%20Medicine/medicineView.dart';
import '../views/medicine/ViewMedecineRecord/home.dart';
import '../views/medicine/ViewTimes/timeHome.dart';
import '../views/medicine/ViewTimes/times_list.dart';
import '../views/medicine/attachmentsMedicine.dart';
import 'package:flutter/material.dart';


const List<Choice> choices = <Choice>[
  Choice(title: 'مواعيد', icons: Icons.notifications_active_rounded),
  Choice(title: 'اسماء', icons: Icons.notes,),
  Choice(title: 'سجل الدواء', icons: Icons.eleven_mp),];

class Choice {
  final String title;
  final IconData icons;
  const Choice({this.title, this.icons});
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final Widget addButton =FloatingActionButton(
      onPressed: () {
        navigateTomain_input();
      },
      tooltip: 'Add Note',
      child: Icon(Icons.add),
    );

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
              title: const Text(
                "الأدوية",
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              backgroundColor: Colors.amber[400],
              actions: <Widget>[
                IconButton(
                    visualDensity: VisualDensity(horizontal: 2, vertical: 3),
                    padding: EdgeInsets.only(left: 15),
                    icon: Icon(Icons.add, size: 45,),
                    onPressed: () {
                      navigateToAttachmentsMedicine();
                    }),
              ],
              leading: Padding(
                child: CircleAvatar(
                    child: Image.asset("assets/med.png",)),
                padding: EdgeInsets.only(top: 2, left: 8),
              ),
              titleSpacing: 4,
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: Column(children: <Widget>[
                    Divider(height: 0, color: Colors.white, thickness: 2,),
                    TabBar(
                      labelPadding: EdgeInsets.only(left: 30, right: 30),
                      labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Times'),
                      unselectedLabelColor: Colors.black,indicatorColor: Colors.white ,
                      isScrollable: true,
                      tabs: choices.map<Widget>((Choice choice) {
                        return Tab(text: choice.title,);}).toList(),
                    ),
                  ]))),
          body: gettabbar(),
          floatingActionButton:addButton, // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
  void navigateToAttachmentsMedicine() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return AttachmentsMedicine();
    }));
  }
  void navigateTomain_input() async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Main_input();
    }));

    if (result == true) {
      Timesupdate.res = true;
      Timesupdate.res2=true;
      if (Timesupdate.res){
        debugPrint("fff");
        // print('lengthkmonnnn${Alarmmm.alarmList.length}');
        //Time_listState();
        setState(() {
          debugPrint('jjjkjksjdkdjskdskd');

          return Time_listState();

        });}
      debugPrint("update");
    }
  }

  TabBarView gettabbar() {
    return TabBarView(children: choices.map((Choice choice) {
      return Padding(padding: const EdgeInsets.all(10),
        child: ChoisePage(choice: choice,),);}).toList(),
    );
  }
}

class ChoisePage extends StatelessWidget {
  const ChoisePage({Key key, this.choice}) : super(key: key);
  final Choice choice;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return ff(choice.title);
  }

  Widget ff(String s) {
    // switch(s){case'': break;}
    if (s == 'مواعيد') {
      debugPrint("refresh");
      //NoteListState().updateListView();       //note_list.updateListView();
      return TimesHome();
    } else
    if (s == 'اسماء') {
      return MedicineView();
    }else
    if (s == 'سجل الدواء') {
      return Home();
    }

    return Card(color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icons, size: 150.0, color: Colors.pink,),
            Text(choice.title, style: TextStyle(color: Colors.black),),
            Divider(height: 1,), //Directionality(textDirection: TextDecoration.rtl, child: null)
            // dd(choice.title,context),
          ],),),);}}
