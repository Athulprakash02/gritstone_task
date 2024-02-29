
import 'package:flutter/material.dart';

class LabelFeild extends StatelessWidget {
  const LabelFeild({
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
