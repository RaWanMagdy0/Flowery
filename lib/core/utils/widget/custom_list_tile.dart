import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onTap;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.trailingIcon,
    this.onTap,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: onTap, // إذا تم تحديد onTap
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon),
                SizedBox(width: 8),
              ],
              Expanded(
                child: Row(
                  children: [
                    Text(
                      title,
                      style: titleStyle ??
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    if (subtitle != null)
                      Text(subtitle!,
                          style: subtitleStyle ??
                              TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
              if (subtitle == null && trailingIcon != null)
                Icon(
                  trailingIcon,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
