// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_task/controller/alarm%20bloc/alarm_bloc.dart';
import 'package:gritstone_task/controller/services/alarm%20service/alarm_service.dart';
import 'package:gritstone_task/view/alarm/widgets/label_feild_widget.dart';
import 'package:gritstone_task/view/alarm/widgets/save_alarm_button_widget.dart';

class AlarmSettingsScreen extends StatelessWidget {
  // ignore: use_super_parameters
  AlarmSettingsScreen({Key? key}) : super(key: key);
  TimeOfDay time = TimeOfDay.now();
  final TextEditingController labelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AlarmService alarmService = AlarmService();

    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<AlarmBloc, AlarmState>(
                builder: (context, state) {
                  if (state.weatherReport.isEmpty) {
                    return const ListTile(
                      title: Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    );
                  } else {
                    return ListTile(
                      title: Text(
                        state.weatherReport["location"]['name'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        state.weatherReport["current"]["condition"]["text"],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      trailing: Text(
                        '${state.weatherReport['current']["temp_c"].toInt()}°C',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                 
                },
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<AlarmBloc, AlarmState>(
                      builder: (context, state) {
                        String hour = state.selectedTime.format(context);
                        return Text(
                          hour,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        time =
                            await alarmService.setTime(context, TimeOfDay.now());
                        BlocProvider.of<AlarmBloc>(context)
                            .add(EditTimeEvent(selectedTime: time));
                        // BlocProvider.of<AlarmBloc>(context)
                        //     .add(FetchWeatherEvent());
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              LabelFeild(labelController: labelController),
              const SizedBox(height: 20),
              SaveAlarmButton(labelController: labelController, time: time, alarmService: alarmService),
            ],
          ),
        ),
      ),
    );
  }
}
