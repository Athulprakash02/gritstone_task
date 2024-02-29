import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_task/controller/alarm%20bloc/alarm_bloc.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/controller/services/alarm%20service/alarm_service.dart';
import 'package:gritstone_task/view/edit%20alarm/widgets/label_text_feild_widget.dart';
import 'package:gritstone_task/view/home/home.dart';

class AlarmEditScreen extends StatelessWidget {
  final AlarmModel alarm;
  final int index;

  // ignore: use_super_parameters
  const AlarmEditScreen({Key? key, required this.alarm, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController labelController =
        TextEditingController(text: alarm.label);
    TimeOfDay time = alarm.time;
    final AlarmService alarmService = AlarmService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Alarm'),
      ),
      body: Padding(
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
                      return Text(
                        time.format(context),
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
                      time = await alarmService.setTime(context, alarm.time);
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<AlarmBloc>(context)
                          .add(EditTimeEvent(selectedTime: time));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            LabelTextFeildWidget(labelController: labelController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedAlarm =
                    AlarmModel(label: labelController.text.trim(), time: time);
                alarmService.updateAlarm(index, updatedAlarm);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
