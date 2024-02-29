
import 'package:flutter/material.dart';
import 'package:gritstone_task/controller/services/alarm%20service/alarm_service.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/view/home/home.dart';

class SaveAlarmButton extends StatelessWidget {
  const SaveAlarmButton({
    super.key,
    required this.labelController,
    required this.time,
    required this.alarmService,
  });

  final TextEditingController labelController;
  final TimeOfDay time;
  final AlarmService alarmService;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AlarmModel alarmDetails = AlarmModel(
            label: labelController.text.trim(), time: time);
        alarmService.saveAlarm(alarmDetails);
            
        // BlocProvider.of<AlarmBloc>(context).add(SaveAlarmEvent(
        //     alarmDetails: alarmDetails));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false);
      },
      child: const Text('Save Alarm'),
    );
  }
}
