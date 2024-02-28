import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/services/alarm%20service/alarm_service.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'alarm_event.dart';
part 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmBloc() : super(AlarmInitial(alarmList: savedAlarms)) {
    on<EditTimeEvent>((event, emit) {
      print('object');
      print(event.selectedTime);
      return emit(TimeSelectedState(
          selectedTime: event.selectedTime, alarmList: savedAlarms));
    });

    on<SaveAlarmEvent>(
      (event, emit) {
        // final alarmDb = Hive.box<AlarmModel>('alarms');
        // alarmDb.add(event.alarmDetails);
        // print(alarmDb.length);
        savedAlarms.add(event.alarmDetails);
        return emit(AlarmState(alarmList: savedAlarms));
      },
    );

    on<getAlarmEvent>((event, emit) {
      final alarmDb = Hive.box<AlarmModel>('alarms');
      // savedAlarms.clear();
      savedAlarms.addAll(alarmDb.values);
      return emit(AlarmState(alarmList: savedAlarms));
    });
  }
}
