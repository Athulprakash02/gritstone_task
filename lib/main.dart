import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gritstone_task/controller/alarm%20bloc/alarm_bloc.dart';
import 'package:gritstone_task/controller/home%20bloc/home_bloc.dart';
import 'package:gritstone_task/model/alarm%20model/alarm_model.dart';
import 'package:gritstone_task/view/home/home.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:alarm/alarm.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmModelAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  tzdata.initializeTimeZones();
  await Permission.location.request();
    await Permission.notification.request();
  await Hive.openBox<AlarmModel>('alarms');
  await Alarm.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AlarmBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
          child: Container(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 130, 194, 188)),
                  textStyle: MaterialStatePropertyAll(
                      TextStyle(color: Colors.white)))),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.teal,
            titleTextStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            centerTitle: true,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
