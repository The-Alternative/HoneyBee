import 'package:bassel/models/medicine/alarm_info.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class Ass{

  static void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.schedule(
        alarmInfo.id,
        'تناول دوائك',
        alarmInfo.title,
        scheduledNotificationDateTime,
        platformChannelSpecifics);
    print(' رقم المنبه${alarmInfo.id}');
  }
    static Future removeNotify(int notifyId) async
    {
    return await flutterLocalNotificationsPlugin.cancel(notifyId);
  }
}