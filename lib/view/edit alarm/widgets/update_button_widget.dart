
import 'package:flutter/material.dart';
import 'package:gritstone_task/controller/services/alarm%20service/alarm_service.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/view/home/home.dart';

class UpdateButtonWidget extends StatelessWidget {
  const UpdateButtonWidget({
    super.key,
    required this.labelController,
    required this.time,
    required this.alarmService,
    required this.index,
  });

  final TextEditingController labelController;
  final TimeOfDay time;
  final AlarmService alarmService;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
    );
  }
}