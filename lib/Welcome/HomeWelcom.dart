import '../Moduls/medicine/screen//google/upload.dart';

import '../Moduls/sign_in/sign_in_with_google/service/sign_in.dart';
import '../Moduls/bmi/screen/bmi1.dart';
import '../Moduls/children/screen/Home.dart';
import '../Moduls/study/screen/home.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'home.dart';
class HomeWelcom extends StatelessWidget {
  final bool isSignIn ;
  HomeWelcom(this.isSignIn);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HoneyBee'),
      ),
      body: Padding(padding: EdgeInsets.all(100.1),
          child: Container(
            child:  Center(
                child: ListView(
                  children: [
                    ElevatedButton(
                      child: Text('الدراسة'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StudyHome()),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text('يوميات الاولاد'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChildrenHome()),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text('الادوية'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DefaultTabController(
                            length: 3, child: MyHomePage(title: 'Flutter  Home Page'),
                          )),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text('BMI'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Bmi1()),
                        );
                      },
                    ),
                    (this.isSignIn == true)?
                    ElevatedButton(
                      child: Text('signOut'),
                      onPressed: () {
                        signOutGoogle();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeWelcom(false)),
                        );
                      },
                    ):
                    ElevatedButton(
                      child: Text('signIn'),
                      onPressed: () {
                        signInWithGoogle().whenComplete(() async {
                          // String x = await signInWithGoogle();
                          // if(!(x == "false")){

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return HomeWelcom(true);
                              },
                            ),
                          );
                          // }else{
                          //   _showMaterialDialog();
                          // }

                        });
                      },
                    ),
                    ElevatedButton(
                      child: Text('google drive'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DriveScreen()),
                        );
                      },
                    ),
                  ],
                )
            ),)),
    );
  }
}