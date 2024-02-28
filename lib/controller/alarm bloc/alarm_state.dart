part of 'alarm_bloc.dart';

@immutable
sealed class AlarmState {
  final TimeOfDay selectedTime;

  AlarmState({required this.selectedTime});
}

final class AlarmInitial extends AlarmState {
  AlarmInitial({required super.selectedTime});
}

class TimeSelectedState extends AlarmState {
  final TimeOfDay selectedTime;

  TimeSelectedState({required this.selectedTime}) : super(selectedTime: selectedTime);

  
}
