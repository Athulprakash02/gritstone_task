import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_task/controller/alarm%20bloc/alarm_bloc.dart';
import 'package:gritstone_task/controller/home%20bloc/home_bloc.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/services/alarm%20service/alarm_service.dart';
import 'package:gritstone_task/view/alarm/alarm.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AlarmService alarmService = AlarmService();

  @override
  Widget build(BuildContext context) {
    // alarmService.getAlarms();
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm'),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SizedBox(
            width: size.width,
            height: size.height,
            child: ListView.builder(
                itemCount: state.alarmList.length,
                itemBuilder: (context, index) {
                  AlarmModel alarm = state.alarmList[index];
                  return ListTile(
                    title: Text(alarm.label),
                  );
                }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AlarmSettings(),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
