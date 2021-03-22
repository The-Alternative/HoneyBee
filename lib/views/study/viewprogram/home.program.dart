import 'package:flutter/material.dart';
import 'package:honeyBee/controllers/study/programcontroller.dart';
import 'package:honeyBee/models/study/program.dart';
import 'package:honeyBee/views/study/viewprogram/listprogram.dart';

class HomePrgramp extends StatefulWidget {
  @override
  _HomePrgrampState createState() => _HomePrgrampState();
}

class _HomePrgrampState extends State<HomePrgramp> {
  ProgramController _programController = ProgramController();
  List<Program> programlist = List<Program>();
  @override
  void initState() {
    super.initState();
    setState(() {
      setData();
    });
  }

  Future setData() async {
    programlist.clear();
    (await _programController.getInfo('programs')).forEach((medMap) {
      setState(() {
        programlist.add(Program().courseMapToObject(medMap));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          programlist.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(width: 43),
                      SizedBox(height: 127),
                      Image(
                        width: 280,
                        height: 280,
                        image: AssetImage(
                          "assets/center.png",
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                )
              : ListProgram(programlist, setData),
        ],
      ),
    );
  }
}
