import 'dart:isolate';

import 'Welcome/HomeWelcom.dart';
import 'Welcome/home.dart';
import 'utils/notifiers.dart';
import 'utils/notifiredb.dart';
import 'views/BMI/bmi1.dart';
import 'views/children/Home.dart';
import 'views/init.dart';
import 'views/study/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

bool result = false;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SingleNotifier>(
        create: (_) => SingleNotifier(),
      ),
      ChangeNotifierProvider<MultipleNotifier>(
        create: (_) => MultipleNotifier([]),
      ),
      ChangeNotifierProvider<CountryProvider>(
          create: (context) => CountryProvider()),
    ],
    child: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.amber,
          primaryColorDark: Colors.amber,
          fontFamily: 'Times'),
      home: App(),
    );
  }
}
