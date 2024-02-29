import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/services/alarm%20service/alarm_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmManager {
  static final AlarmService alarmService = AlarmService();
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Initialize the timezone database
    // tz.initializeTimeZones();
  }

  static Future<void> addAlarm(AlarmModel alarm) async {
    // Fetch device's location
    final status = await Permission.location.request();

  // Check if permission is granted
  if (status.isGranted) {
    // Proceed with fetching location
    final Position position = await Geolocator.getCurrentPosition();
    // ... rest of your code using the location
  } else {
    // Handle the case where permission is denied
    print('Location permission denied');
    // You can show a message to the user explaining why location is needed and prompt them to revisit permissions settings if necessary.
  }
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // final tz.Location location = tz.getLocation(
    //   position.latitude.toString(),
    //   // position.longitude.toString(),
    // );
    print(position.toString());
    // Convert alarm time to the timezone of the device's location
    final DateTime alarmTime =
        alarmService.convertTimeOfDayToDateTime(alarm.time);
    final tz.TZDateTime tzDateTime =
        tz.TZDateTime.from(alarmTime, tz.getLocation(position.toString()));

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

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      alarm.id!,
      alarm.label,
      'Come on!!',
      tzDateTime,
      platformChannelSpecifics,
      
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
