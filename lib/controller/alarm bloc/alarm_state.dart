part of 'alarm_bloc.dart';

@immutable
 class AlarmState {
  final TimeOfDay selectedTime;
  // final List<AlarmModel> alarmList;
final Map<String,dynamic> weatherReport;
  const AlarmState(this.weatherReport, {required this.selectedTime, });
}

final class AlarmInitial extends AlarmState {
  const AlarmInitial(super.weatherReport, {required super.selectedTime, });
}

class TimeSelectedState extends AlarmState {
  const TimeSelectedState(super.weatherReport, {required super.selectedTime, });
}

