part of 'alarm_bloc.dart';

@immutable
sealed class AlarmEvent {}

class EditTimeEvent extends AlarmEvent{
  final TimeOfDay selectedTime;

  EditTimeEvent({required this.selectedTime});
}
