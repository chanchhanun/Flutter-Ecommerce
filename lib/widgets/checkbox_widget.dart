import 'package:flutter/material.dart';

class CheckboxWidget extends StatelessWidget {
  final bool isChecked;
  final String title;

  final void Function(bool?) onChanged;
  const CheckboxWidget({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isChecked ? Colors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          margin: EdgeInsets.symmetric(vertical: 12),
          child: Checkbox(
            side: BorderSide(color: Colors.transparent),
            activeColor: isChecked ? Colors.green : Colors.transparent,
            value: isChecked,
            onChanged: onChanged,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: isChecked ? Colors.green : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
