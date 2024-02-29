// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gritstone_task/controller/services/weather%20service/weather_service.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/controller/services/alarm%20service/alarm_service.dart';
// ignore: unnecessary_import
import 'package:meta/meta.dart';

part 'alarm_event.dart';
part 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmBloc()
      : super(AlarmInitial(weatherData,
          selectedTime: TimeOfDay.now(),
        )) {
    on<EditTimeEvent>((event, emit) {
      return emit(TimeSelectedState(state.weatherReport,
        selectedTime: event.selectedTime,
      ));
    });

    on<SaveAlarmEvent>(
      (event, emit) {
        // final alarmDb = Hive.box<AlarmModel>('alarms');
        // alarmDb.add(event.alarmDetails);
        // print(alarmDb.length);
        savedAlarms.add(event.alarmDetails);
      },
    );

    on<FetchWeatherEvent>((event, emit) async {
      final WeatherService weatherService = WeatherService();
      Map<String, dynamic> report = await weatherService.fetchWeatherData();
      return emit(AlarmState(report, selectedTime: state.selectedTime));
    });
  }
}
