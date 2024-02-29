import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/controller/services/alarm%20service/alarm_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class AlarmManager {
  static final AlarmService alarmService = AlarmService();
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await _flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher')),
        onDidReceiveBackgroundNotificationResponse:
            (NotificationResponse payload) async {
      await cancelAlarm(1);
    }, onDidReceiveNotificationResponse: (NotificationResponse payload) async {
      await cancelAlarm(1);
    });
    
    tz.initializeTimeZones();
  }

  static Future<void> addAlarm(AlarmModel alarm) async {
    final PermissionStatus status = await Permission.location.request();
    await Permission.notification.request();

    if (status.isGranted) {
      try {
        final Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        final List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        if (placemarks.isNotEmpty) {
          final String country = placemarks.first.country.toString();

          // Converting alarm to the timexone of the current location
          final DateTime alarmTime =
              alarmService.convertTimeOfDayToDateTime(alarm.time);
          final tz.TZDateTime tzDateTime =
              tz.TZDateTime.from(alarmTime, tz.getLocation(country));

          const AndroidNotificationDetails androidPlatformChannelSpecifics =
              AndroidNotificationDetails(
            'Alarm_channel',
            'alarm',
            actions: [
              AndroidNotificationAction(
                'cancel_id',
                'cancel',
                cancelNotification: true,
              )
            ],
            channelDescription: 'Notification channel',
            icon: '@mipmap/ic_launcher',
            timeoutAfter: 500,
            sound: RawResourceAndroidNotificationSound('alarm_sound'),
            importance: Importance.max,
            priority: Priority.high,
          );

          const NotificationDetails platformChannelSpecifics =
              NotificationDetails(android: androidPlatformChannelSpecifics);

          await _flutterLocalNotificationsPlugin.zonedSchedule(
            1,
            'title',
            'body',
            tzDateTime,
            platformChannelSpecifics,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            payload: alarm.id.toString(),
          );
        }
        // ignore: empty_catches
      } catch (e) {}
    } else {}
  }

  static Future cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAlarm(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> restoreAlarms() async {
    final alarmBox = await Hive.openBox<AlarmModel>('alarms');
    final List<AlarmModel> alarms = alarmBox.values.toList();
    for (final alarm in alarms) {
      await addAlarm(alarm);
    }
  }
}
