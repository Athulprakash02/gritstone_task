import 'package:flutter/material.dart';
import 'package:gritstone_task/view/alarm/alarm.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => ListTile(
            title: Text('data'),
          ),
        ),
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
  }
}
