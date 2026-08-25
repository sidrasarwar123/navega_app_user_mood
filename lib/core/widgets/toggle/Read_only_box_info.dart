import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';

/// Simple bordered box used to display read-only text content,
/// e.g. "About the boat", "Min / Max days".
class ReadOnlyInfoBox extends StatelessWidget {
  final String text;

  const ReadOnlyInfoBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: Text(
        text,
        style: AppTextStyles.fieldHint.copyWith(color: AppColors.textDark),
      ),
    );
  }
}