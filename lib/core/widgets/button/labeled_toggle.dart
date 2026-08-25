import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/textstyle.dart';

/// A row with a label on the left and a switch/toggle on the right.
/// Used for filters like "Immediate Reservation", "Yes pets", etc.
class LabeledToggle extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const LabeledToggle({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.label),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.white,
          activeTrackColor: AppColors.primaryBlue,
          inactiveThumbColor: AppColors.white,
          inactiveTrackColor: AppColors.fieldBorder,
        ),
      ],
    );
  }
}