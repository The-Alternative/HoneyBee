import '../../events/stage_event.dart';

import '../../bloc/stage_bloc.dart';
import '../../models/stageModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Other/inputCard.dart';
class SuspendedList extends StatefulWidget {
  final List<dynamic> infoList;
  SuspendedList(this.infoList);
  @override
  _SuspendedListState createState() => _SuspendedListState();
}

class _SuspendedListState extends State<SuspendedList> {
  bool _checkbox = false;
  var style10 = TextStyle(fontSize: 20, fontWeight: FontWeight.w200, fontFamily: 'Times',);
  var style1 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times');
  var style4 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times', color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.infoList.length,
      itemBuilder: (context, index) {
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
                  Expanded(flex: 4,child: ListTile(title:Text(widget.infoList[index].title) ,subtitle: Text(widget.infoList[index].description),
                    trailing: CircleAvatar(radius: 15,
                      child: Image.asset("assets/A.png"),backgroundColor: Colors.red,)
                    ,leading: Image.asset("assets/doctor.png"),
                    onTap: (){},
                  )),
                  Expanded(flex: 1,child: Container(color: Colors.black12,height: 100,
                      child:Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(height: 40,width: 40,child: Image.asset("assets/alarm-clock.png")),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text('${widget.infoList[index].time.format(context) }', style: TextStyle(fontSize: 14),),
                        ),
                      ],)
                  )),

                ],)
              ])),
        );

      },);
  }
}

