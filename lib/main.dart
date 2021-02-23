import 'dart:isolate';

import 'package:bassel/Welcome/home.dart';
import 'package:bassel/utils/notifiers.dart';
import 'package:bassel/utils/notifiredb.dart';
import 'package:bassel/views/BMI/bmi1.dart';
import 'package:bassel/views/children/Home.dart';
import 'package:bassel/views/login_page.dart';
import 'package:bassel/views/study/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  // print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

bool result =false;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const List<Choice> choices = <Choice>[
  Choice(title: 'مواعيد', icons: Icons.notifications_active_rounded),
  Choice(title: 'اسماء', icons: Icons.notes,),
  Choice(title: 'سجل الدواء', icons: Icons.eleven_mp),];

class Choice {
  final String title;
  final IconData icons;
  const Choice({this.title, this.icons});
}

// main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   var initializationSettingsAndroid =
//   AndroidInitializationSettings('codex_logo');
//   var initializationSettingsIOS = IOSInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       onDidReceiveLocalNotification:
//           (int id, String title, String body, String payload) async {});
//   var initializationSettings = InitializationSettings(
//       initializationSettingsAndroid, initializationSettingsIOS);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: (String payload) async {
//         if (payload != null) {
//           debugPrint('notification payload: ' + payload);
//         }
//       });
//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider<SingleNotifier>(
//         create: (_) => SingleNotifier(),
//       ),
//       ChangeNotifierProvider<MultipleNotifier>(
//         create: (_) => MultipleNotifier([]),
//       ),
//       ChangeNotifierProvider<CountryProvider>(
//           create: (context) => CountryProvider()),
//     ],
//     child: MyApp(),
//   ));
//
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//           primaryColor: Colors.redAccent,
//           primaryColorDark: Colors.red,
//           fontFamily: 'Times'),
//       home: DefaultTabController(
//         length: 3, child: MyHomePage(title: 'Flutter  Home Page'),
//       ),
//     );
//   }
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid =
  AndroidInitializationSettings('codex_logo');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String payload) async {
  //   print(payload);
  //       if (payload != null) {
  //         debugPrint('notification payload: ' + payload);
  //       }
  //     });
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: LoginPage(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HoneyBee'),
      ),
      body: Center(
        child: Column(
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
          ],
        )
      ),
    );
  }
}


  