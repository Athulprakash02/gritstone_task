import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_task/controller/home%20bloc/home_bloc.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:hive/hive.dart';

import '../notification servicces/notificaion_services.dart';

List<AlarmModel> savedAlarms = [];

class AlarmService {
  Future<TimeOfDay> setTime(BuildContext context, TimeOfDay initialTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      return picked;
    }
    return TimeOfDay.now();
  }

  saveAlarm(AlarmModel alarmDetails) async {
    final alarmBox = Hive.box<AlarmModel>('alarms');
    alarmBox.add(alarmDetails);
    DateTime time = convertTimeOfDayToDateTime(alarmDetails.time);
    final alarmSettings = AlarmSettings(
      id: alarmDetails.id ??= 1,
      dateTime: time,
      assetAudioPath: 'assets/alarm.mp3',
      loopAudio: false,
      vibrate: true,
      volume: 0.2,
      fadeDuration: 3.0,
      notificationTitle: alarmDetails.label,
      notificationBody: 'Alarm will stop automatically!',
      enableNotificationOnKill: true,
    );
    await AlarmManager.addAlarm(alarmDetails);
    await Alarm.set(alarmSettings: alarmSettings);
    
    // getAlarms();
  }

  getAlarms() {
    final alarmsDb = Hive.box<AlarmModel>('alarms');
    savedAlarms.clear();
    savedAlarms.addAll(alarmsDb.values);
  }

  deleteAlarm(int id, BuildContext context) {
    final alarmDb = Hive.box<AlarmModel>('alarms');
    BlocProvider.of<HomeBloc>(context).add(DeleteAlarmEvent(alarmId: id));
    alarmDb.deleteAt(id);
  }

  updateAlarm(int index, AlarmModel alarmDetails) {
    final alarmDb = Hive.box<AlarmModel>('alarms');
    alarmDb.putAt(index, alarmDetails);
    getAlarms();
  }

  DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }
}
