part of 'alarm_bloc.dart';

@immutable
 class AlarmState {
  final TimeOfDay selectedTime;
  // final List<AlarmModel> alarmList;

  AlarmState({required this.selectedTime, });
}

final class AlarmInitial extends AlarmState {
  AlarmInitial({required super.selectedTime, });
}

class TimeSelectedState extends AlarmState {
  TimeSelectedState({required super.selectedTime, });
}
