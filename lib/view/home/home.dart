import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_task/controller/alarm%20bloc/alarm_bloc.dart';
import 'package:gritstone_task/controller/home%20bloc/home_bloc.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/controller/services/alarm%20service/alarm_service.dart';
import 'package:gritstone_task/view/alarm/alarm.dart';
import 'package:gritstone_task/view/edit%20alarm/edit_alarm_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AlarmService alarmService = AlarmService();

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<HomeBloc>(context).add(HomeInitialEvent());
    alarmService.getAlarms();
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Alarm'),
            centerTitle: true,
          ),
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: ListView.builder(
                itemCount: state.alarmList.length,
                itemBuilder: (context, index) {
                  AlarmModel alarm = state.alarmList[index];
                  return ListTile(
                    title: Text(alarm.time.format(context)),
                    subtitle: Text(alarm.label),
                    trailing: Wrap(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AlarmEditScreen(alarm: alarm,index: index,),
                              ));
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.blue),
                        IconButton(
                          onPressed: () {
                            deleteAlert(context, index);
                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  );
                }),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<AlarmBloc>(context).add(FetchWeatherEvent());
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AlarmSettingsScreen(),
              ));
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  deleteAlert(BuildContext context, key) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text('Delete data Permanently?'),
        actions: [
          TextButton(
              onPressed: () {
                alarmService.deleteAlarm(key, context);
                

                Navigator.of(context).pop(ctx);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(ctx);
            },
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }
}
