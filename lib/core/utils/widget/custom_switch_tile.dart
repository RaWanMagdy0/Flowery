import '../../styles/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;
  final TextStyle? titleStyle;

  const SwitchTile({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.white,
    this.activeTrackColor = Colors.pink,
    this.inactiveThumbColor = Colors.white,
    this.inactiveTrackColor = Colors.grey,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          // Switch widget
          Transform.scale(
            scale: 0.8.w,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: activeColor,
              activeTrackColor: activeTrackColor,
              inactiveThumbColor: inactiveThumbColor,
              inactiveTrackColor: inactiveTrackColor,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Notification',
            style: AppFonts.font13BlackWeight400,
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}
