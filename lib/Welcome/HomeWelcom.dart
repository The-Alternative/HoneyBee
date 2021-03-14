import '../Controller/sign_in.dart';

import '../views/medicine/google/upload.dart';

import '../views/BMI/bmi1.dart';
import '../views/children/Home.dart';
import '../views/init.dart';
import '../views/login_page.dart';
import '../views/study/home.dart';
import 'package:flutter/material.dart';

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
      body: Padding(padding: EdgeInsets.all(50),
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
