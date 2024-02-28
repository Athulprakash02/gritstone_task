import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_task/controller/alarm%20bloc/alarm_bloc.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/services/alarm%20service/alarm_service.dart';
import 'package:gritstone_task/view/alarm/alarm.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AlarmService alarmService = AlarmService();

  @override
  Widget build(BuildContext context) {
    

     alarmService.getAlarms();
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<AlarmBloc, AlarmState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Alarm'),
            centerTitle: true,
          ),
          body:  SizedBox(
                width: size.width,
                height: size.height,
                child: ListView.builder(
                    itemCount: state.alarmList.length,
                    itemBuilder: (context, index) {
                      AlarmModel alarm = state.alarmList[index];
                      return ListTile(
                        title: Text(alarm.time.format(context)),
                        subtitle: Text( alarm.label),
                        trailing: Wrap(
                          children: [
                            IconButton(
                                onPressed: () {
                                 
                                },
                                icon: const Icon(Icons.edit),
                                color: Colors.blue),
                            IconButton(
                              onPressed: () {
                                // deleteAlert(context, index);
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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AlarmSettings(),
              ));
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
