import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'alarm_event.dart';
part 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmBloc() : super(AlarmInitial(selectedTime: TimeOfDay.now())) {
    on<EditTimeEvent>((event, emit) {
      print('object');
      print(event.selectedTime);
      return emit(TimeSelectedState(selectedTime: event.selectedTime));
    });
  }
}
