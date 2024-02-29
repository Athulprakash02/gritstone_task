part of 'alarm_bloc.dart';

@immutable
sealed class AlarmEvent {}

class EditTimeEvent extends AlarmEvent{
  final TimeOfDay selectedTime;

  EditTimeEvent({required this.selectedTime});
}

class SaveAlarmEvent extends AlarmEvent {
  // final TimeOfDay selectedTime;
  final AlarmModel alarmDetails;

  SaveAlarmEvent({required this.alarmDetails});
}

class FetchWeatherEvent extends AlarmEvent {
 


  
}
