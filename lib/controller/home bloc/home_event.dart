part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class DeleteAlarmEvent extends HomeEvent {
  final int alarmId;

  DeleteAlarmEvent({required this.alarmId});
  
}