import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_task/controller/alarm%20bloc/alarm_bloc.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:hive/hive.dart';

List<AlarmModel> savedAlarms = [];

class AlarmService {
  Future<TimeOfDay> setTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      print(picked.format(context));
      return picked;
    }
    return TimeOfDay.now();
  }

  saveAlarm(AlarmModel alarmDetails) async{
    print('save alarm keri');
    final alarmBox = Hive.box<AlarmModel>('alarms');
   await alarmBox.add(alarmDetails);
    print(alarmBox.length);
    // getAlarms();
  }

  getAlarms() {
    print('vann');
    final alarmsDb = Hive.box<AlarmModel>('alarms');
    savedAlarms.clear();
    savedAlarms.addAll(alarmsDb.values);
  }
}
