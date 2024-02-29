
import 'package:flutter/material.dart';

class LabelTextFeildWidget extends StatelessWidget {
  const LabelTextFeildWidget({
    super.key,
    required this.labelController,
  });

  final TextEditingController labelController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: labelController,
      decoration: InputDecoration(
        labelText: 'Label',
        hintText: 'Wake up',
        border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}