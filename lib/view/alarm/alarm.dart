import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_task/controller/alarm%20bloc/alarm_bloc.dart';
import 'package:gritstone_task/services/alarm%20service/alarm_service.dart';

class AlarmSettings extends StatelessWidget {
  AlarmSettings({Key? key}) : super(key: key);
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final AlarmService alarmService = AlarmService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
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
                      String hour = state.selectedTime.format(context);
                      return Text(
                        hour,
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
                      time = await alarmService.setAlarm(context);
                      BlocProvider.of<AlarmBloc>(context)
                          .add(EditTimeEvent(selectedTime: time));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print(time);
              },
              child: Text('Save Alarm'),
            ),
          ],
        ),
      ),
    );
  }
}
