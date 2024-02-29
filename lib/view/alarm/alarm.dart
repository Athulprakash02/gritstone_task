import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_task/controller/alarm%20bloc/alarm_bloc.dart';
import 'package:gritstone_task/controller/services/weather%20service/weather_service.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/controller/services/alarm%20service/alarm_service.dart';
import 'package:gritstone_task/view/home/home.dart';

class AlarmSettingsScreen extends StatelessWidget {
  AlarmSettingsScreen({Key? key}) : super(key: key);
  TimeOfDay time = TimeOfDay.now();
  final TextEditingController labelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AlarmService alarmService = AlarmService();

    // final WeatherService weatherService = WeatherService();
    // weatherService.fetchWeatherData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<AlarmBloc, AlarmState>(
              builder: (context, state) {
                if (state is WeatherFetchState) {
                  return ListTile(
                    title: Text(
                      state.weatherReport["location"]['name'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      state.weatherReport["current"]["condition"]["text"],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    trailing: Text(
                      '${state.weatherReport['current']["temp_c"].toInt()}°C',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return ListTile(
                    title: Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 14,
                        
                      ),
                    ),
                    
                  );
                }
              },
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
                      time =
                          await alarmService.setTime(context, TimeOfDay.now());
                      BlocProvider.of<AlarmBloc>(context)
                          .add(EditTimeEvent(selectedTime: time));
                      BlocProvider.of<AlarmBloc>(context)
                          .add(FetchWeatherEvent());
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
                AlarmModel alarmDetails = AlarmModel(
                    label: labelController.text.trim() ?? 'alarm', time: time);
                alarmService.saveAlarm(alarmDetails);

                // BlocProvider.of<AlarmBloc>(context).add(SaveAlarmEvent(
                //     alarmDetails: alarmDetails));
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                    (route) => false);
              },
              child: Text('Save Alarm'),
            ),
          ],
        ),
      ),
    );
  }
}
