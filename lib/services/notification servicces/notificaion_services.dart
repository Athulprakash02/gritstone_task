import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/services/alarm%20service/alarm_service.dart';

class AlarmManager {
  static final AlarmService alarmService = AlarmService();
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future<void> initialize() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> addAlarm(AlarmModel alarm) async {
    final DateTime alarmTime =
        alarmService.convertTimeOfDayToDateTime(alarm.time);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'Alarm_channel',
      'alarm',
      channelDescription: 'Notification chsnnel',
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('alarm_sound'),
      importance: Importance.max,
      priority: Priority.high,
    );
      final NotificationDetails platformChannelSpecifics =NotificationDetails(android: androidPlatformChannelSpecifics);


      // await _flutterLocalNotificationsPlugin.zonedSchedule(alarm.id!, alarm.label, 'Come on!!', alarmTime, platformChannelSpecifics, uiLocalNotificationDateInterpretation: )
  }


}
