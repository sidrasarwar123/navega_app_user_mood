import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';

import 'package:navega_app/core/constants/textstyle.dart';

class PickerField extends StatelessWidget {
  final String hint;
  final String? value;
  final VoidCallback onTap;
  final bool showArrow;

  const PickerField({
    super.key,
    required this.hint,
    required this.value,
    required this.onTap,
    this.showArrow = true,
  });

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
            Expanded(
              child: Text(
                value ?? hint,
                overflow: TextOverflow.ellipsis,
                style: value != null ? AppTextStyles.label : AppTextStyles.fieldHint,
              ),
            ),
            if (showArrow)
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