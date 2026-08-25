import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';

class DateField extends StatelessWidget {
  final String hint;
  final DateTime? date;
  final VoidCallback onTap;

  const DateField({
    super.key,
    required this.hint,
    required this.date,
    required this.onTap,
  });

  String _format(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSpacing.fieldHeight,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.fieldFill,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: AppColors.fieldBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null ? _format(date!) : hint,
              style:
                  date != null ? AppTextStyles.label : AppTextStyles.fieldHint,
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: AppColors.textGrey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}