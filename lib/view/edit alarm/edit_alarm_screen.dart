import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_task/controller/alarm%20bloc/alarm_bloc.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/controller/services/alarm%20service/alarm_service.dart';
import 'package:gritstone_task/view/home/home.dart';

class AlarmEditScreen extends StatelessWidget {
  final AlarmModel alarm;
  final int index;

  const AlarmEditScreen({Key? key, required this.alarm, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController labelController =
        TextEditingController(text: alarm.label);
    TimeOfDay time = alarm.time;
    final AlarmService alarmService = AlarmService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Alarm'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Text(
                'Placename',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Cloudy, 34°C / 34°C',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                '30°C',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 1),
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
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      time = await alarmService.setTime(context, alarm.time);
                      BlocProvider.of<AlarmBloc>(context)
                          .add(EditTimeEvent(selectedTime: time));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: labelController,
              decoration: InputDecoration(
                labelText: 'Label',
                hintText: 'Wake up',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedAlarm = AlarmModel(
                   
                    label: labelController.text.trim() ?? 'alarm',
                    time: time);
                alarmService.updateAlarm(index, updatedAlarm);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
