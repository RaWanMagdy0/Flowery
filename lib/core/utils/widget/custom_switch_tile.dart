import 'package:flutter/material.dart';

class SwitchTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;
  final TextStyle? titleStyle;

  const SwitchTile({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.white,
    this.activeTrackColor = Colors.pink,
    this.inactiveThumbColor = Colors.white,
    this.inactiveTrackColor = Colors.grey,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Switch widget
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: activeColor,
            activeTrackColor: activeTrackColor,
            inactiveThumbColor: inactiveThumbColor,
            inactiveTrackColor: inactiveTrackColor,
          ),
          const SizedBox(width: 8),
          Text(
            'Notification',
            style: titleStyle ??
                TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}