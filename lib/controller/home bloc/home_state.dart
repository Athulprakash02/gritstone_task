part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final List<AlarmModel> alarmList;

  const HomeState({required this.alarmList});
}

final class HomeInitial extends HomeState {
  const HomeInitial({required super.alarmList});
}

class HomeLoadedState extends HomeState {
  const HomeLoadedState({required super.alarmList});
  
}


