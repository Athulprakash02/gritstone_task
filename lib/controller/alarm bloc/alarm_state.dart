part of 'alarm_bloc.dart';

 class AlarmState {
  // final TimeOfDay selectedTime;
  final List<AlarmModel> alarmList;

  AlarmState({required this.alarmList, });
}

final class AlarmInitial extends AlarmState {
  AlarmInitial({required super.alarmList, });
}

class TimeSelectedState extends AlarmState {
  final TimeOfDay selectedTime;

  TimeSelectedState({required super.alarmList, required this.selectedTime});
  
}
