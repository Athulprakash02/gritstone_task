import 'package:bloc/bloc.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/controller/services/alarm%20service/alarm_service.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial(alarmList: savedAlarms)) {
    on<HomeInitialEvent>((event, emit) {
      final alarmDb = Hive.box<AlarmModel>('alarms');
      // savedAlarms.clear();
      savedAlarms.addAll(alarmDb.values);
      return emit(HomeLoadedState(alarmList: savedAlarms));
    });
    on<DeleteAlarmEvent>((event, emit) {
      savedAlarms.removeAt(event.alarmId);
      return emit(HomeLoadedState(alarmList: savedAlarms));
    });
  }
}
