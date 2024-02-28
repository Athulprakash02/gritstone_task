import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final typeId = 128; // You can choose any unique positive integer

  @override
  TimeOfDay read(BinaryReader reader) {
    final hour = reader.readByte();
    final minute = reader.readByte();
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  void write(BinaryWriter writer, TimeOfDay time) {
    writer.writeByte(time.hour);
    writer.writeByte(time.minute);
  }
}
