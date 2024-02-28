import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final int typeId = 2; 
  @override
  TimeOfDay read(BinaryReader reader) {
    int minutesSinceMidnight = reader.readInt();
    return TimeOfDay(hour: minutesSinceMidnight ~/ 60, minute: minutesSinceMidnight % 60);
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    writer.writeInt(obj.hour * 60 + obj.minute);
  }
}