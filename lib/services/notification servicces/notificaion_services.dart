import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/services/alarm%20service/alarm_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class AlarmManager {
  static final AlarmService alarmService = AlarmService();
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: (details) => cancelAlarm,onDidReceiveBackgroundNotificationResponse: (details) => cancelAlarm,);

    // Initialize the timezone database
    tz.initializeTimeZones();
  }

  static Future<void> addAlarm(AlarmModel alarm) async {
    // Fetch location permission
    final PermissionStatus status = await Permission.location.request();

    // Check if permission is granted
    if (status.isGranted) {
      try {
        // Fetch device's location
        final Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        
        // Fetch placemarks
        final List<Placemark> placemarks =
            await placemarkFromCoordinates(position.latitude, position.longitude);

        // Check if placemarks is not empty
        if (placemarks.isNotEmpty) {
          // Extract country from the first placemark
          final String country = placemarks.first.country.toString();

          // Convert alarm time to the timezone of the device's location
          final DateTime alarmTime =
              alarmService.convertTimeOfDayToDateTime(alarm.time);
          final tz.TZDateTime tzDateTime =
              tz.TZDateTime.from(alarmTime, tz.getLocation(country));

          // Schedule the alarm notification
          final AndroidNotificationDetails androidPlatformChannelSpecifics =
              AndroidNotificationDetails(
            'Alarm_channel',
            'alarm',
            channelDescription: 'Notification channel',
            icon: '@mipmap/ic_launcher',
            sound: RawResourceAndroidNotificationSound('alarm_sound'),
            importance: Importance.max,
            priority: Priority.high,
          );

          final NotificationDetails platformChannelSpecifics =
              NotificationDetails(android: androidPlatformChannelSpecifics);

          await _flutterLocalNotificationsPlugin.zonedSchedule(
            2,
            'title',
            'body',
            tzDateTime,
            platformChannelSpecifics,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            payload: 'payload',
          );
        }
      } catch (e) {
        print('Error fetching location or placemark: $e');
      }
    } else {
      // Handle the case where permission is denied
      print('Location permission denied');
      // You can show a message to the user explaining why location is needed and prompt them to revisit permissions settings if necessary.
    }
  }

  static Future cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // close all the notifications available
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

  // Callback function invoked when a notification is selected by the user
  static Future<void> _onSelectNotification(String? payload) async {
    // Handle notification selection event here
  }

  // Callback function invoked when a notification is canceled by the user
  static Future<void> _onNotificationCanceled(int? id, bool? dismissed) async {
    if (dismissed ?? false) {
      await cancelAlarm(id!);
    }
  }

}
