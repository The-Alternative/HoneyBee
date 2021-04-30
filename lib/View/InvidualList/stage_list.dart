import '../../events/stage_event.dart';

import '../../bloc/stage_bloc.dart';
import '../../models/stageModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Other/inputCard.dart';
class StageList extends StatefulWidget {
  final Function fun;
  StageList(this.fun);
  @override
  _StageListState createState() => _StageListState();
}

class _StageListState extends State<StageList> {
  bool _checkbox = false;
  String stage;
  var style10 = TextStyle(fontSize: 20, fontWeight: FontWeight.w200, fontFamily: 'Times',);
  var style1 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times');
  var style4 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times', color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: BlocConsumer<StageBloc, List<String>>(
          buildWhen: (List<String> previous, List<String> current) {
            return true;
          },
          listenWhen: (List<String> previous, List<String> current) {
            if (current.length > previous.length) {
              return true;
            }

            return false;
          },
          builder: (context, foodList) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    Row(mainAxisAlignment:MainAxisAlignment.start ,children: [


                      Expanded(
                        child: Checkbox(
                          value: _checkbox,
                          onChanged: (value) {
                            setState(() {
                              _checkbox = !_checkbox;
                            });
                          },
                        ),
                        flex: 1,),
                      Expanded(child: Text(foodList[index]),flex: 4,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10,),
                          child:
                          DropdownButton(
                            underline: Container(
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.transparent))
                              ),
                            ),
                            icon: new
                            Icon(Icons.more_horiz_outlined),dropdownColor: Colors.amber,iconSize: 40,
                            items: [

                              DropdownMenuItem(child: IconButton(icon:Image.asset("assets/chat.png",),onPressed: null,
                                color: Colors.amber,),

                                value: "",
                                onTap: (){
                                  //   navigateToDiary(this._cardList[position],"Edit Diary");
                                  // updatelistview();
                                },),



                            ],
                            onChanged: (String value){
                              value = "";
                            },
                          ),
                        ),
                        flex: 3,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10,),
                          child: IconButton(icon: Icon(Icons.clear), onPressed: () {
                            BlocProvider.of<StageBloc>(context).add(
                              StageEvent.delete(index),);
                             widget.fun();
                          },iconSize: 25,),
                        ),
                        flex: 1,)

                    ],)
                  ]),
                );

              },
            );
          },
          listener: (BuildContext context, foodList) {

            //
            // Scaffold.of(context).showSnackBar(
            //   SnackBar(content: Text('Added!')),
            // );
          },
        ));
  }
}

