import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'alarm_model.g.dart';

@HiveType(typeId: 1)
class AlarmModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String label;

  @HiveField(2)
  final TimeOfDay time;

  AlarmModel({required this.label, required this.time});


  
}