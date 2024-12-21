import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/colors/app_colors.dart';

class CustomGenderRow extends StatelessWidget {
  const CustomGenderRow(
      {super.key, required this.gender, required this.onChanged});
  final String gender;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            "Gender",
            style: TextStyle(fontSize: 16, color: AppColors.kGray),
          ),
          50.horizontalSpace,
          Row(
            children: [
              Radio(
                  value: "female",
                  groupValue: gender,
                  activeColor: Colors.pink,
                  onChanged: (value) {
                    if (value != null) {
                      onChanged(value);
                    }
                  }),
              Text("Female"),
              16.horizontalSpace,
              Radio(
                  value: "male",
                  groupValue: gender,
                  activeColor: Colors.pink,
                  onChanged: (value) {
                    if (value != null) {
                      onChanged(value);
                    }
                  }),
              Text("Male"),
            ],
          ),
        ],
      ),
    );
  }
}
