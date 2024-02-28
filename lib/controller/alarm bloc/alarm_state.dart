part of 'alarm_bloc.dart';

@immutable
sealed class AlarmState {}

final class AlarmInitial extends AlarmState {}

class TimeSelectedState extends AlarmState {
  final TimeOfDay selectedTime;

  TimeSelectedState({required this.selectedTime});

  
}
