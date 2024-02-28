import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_task/controller/alarm%20bloc/alarm_bloc.dart';
import 'package:gritstone_task/controller/home%20bloc/home_bloc.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:hive/hive.dart';

List<AlarmModel> savedAlarms = [];

class AlarmService {
  Future<TimeOfDay> setTime(BuildContext context,TimeOfDay initialTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      print(picked.format(context));
      return picked;
    }
    return TimeOfDay.now();
  }

  saveAlarm(AlarmModel alarmDetails) {
    final alarmBox = Hive.box<AlarmModel>('alarms');
    alarmBox.add(alarmDetails);
    // getAlarms();
  }

  getAlarms() {
    print('vann');
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
}
