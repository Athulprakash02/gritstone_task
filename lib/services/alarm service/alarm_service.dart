import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_task/controller/alarm%20bloc/alarm_bloc.dart';

class AlarmService {
  Future<TimeOfDay> setAlarm(BuildContext context)  async{
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
}
