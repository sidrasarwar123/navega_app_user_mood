import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/textstyle.dart';


/// "Daily / Hourly" switch used to change the pricing mode.
class DailyHourlyToggle extends StatelessWidget {
  final bool isDaily;
  final ValueChanged<bool> onChanged;

  const DailyHourlyToggle({
    super.key,
    required this.isDaily,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Daily', style: AppTextStyles.label),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Switch(
            value: !isDaily,
            activeColor: AppColors.primaryBlue,
            onChanged: (val) => onChanged(!val),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Hourly',
            style: AppTextStyles.label.copyWith(color: AppColors.textGrey),
          ),
        ),
      ],
    );
  }
}