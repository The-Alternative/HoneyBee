import 'dart:io';

import '../../bloc/stage_bloc.dart';
import '../../events/stage_event.dart';
import '../../models/eventModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class InputCard extends StatefulWidget {
  final String stage;
  final Function fun;
final int ind;
  InputCard(this.stage, this.fun, this.ind);
  @override
  State<StatefulWidget> createState() {
    return _EventCard(this.stage);
  }
}
class _EventCard extends State<InputCard> {
  bool _checkbox = false;
  String stage;
  _EventCard(this.stage);
  var style10 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w200,
    fontFamily: 'Times',
  );
  var style1 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Times');
  var style2 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times');
  var style4 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Times', color: Colors.white);


  @override
  Widget build(BuildContext context) {
    //check if the medicine time is lower than

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
          Expanded(child: Text(stage),flex: 4,),
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
                        StageEvent.delete(widget.ind),);
               //     widget.fun();
              },iconSize: 25,),
            ),
          flex: 1,)

        ],)
      ]),
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


}
