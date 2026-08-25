import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';


/// Reusable bordered text field (License Number, Name, Last Name, etc.)
class DescriptionField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  /// Set both > 1 to use this as a multiline textarea (e.g. trip message).
  final int minLines;
  final int maxLines;

  const DescriptionField({
    super.key,
    this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.minLines = 1,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMultiline = maxLines > 1;
    return SizedBox(
      height: isMultiline ? null : AppSpacing.fieldHeight,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        minLines: minLines,
        maxLines: maxLines,
        style: AppTextStyles.label,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.fieldHint,
          filled: true,
          fillColor: AppColors.fieldFill,
          contentPadding: isMultiline
              ? const EdgeInsets.all(14)
              : const EdgeInsets.symmetric(horizontal: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            borderSide: const BorderSide(color: AppColors.fieldBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            borderSide: const BorderSide(color: AppColors.fieldBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            borderSide: const BorderSide(color: AppColors.focusedBorder),
          ),
        ),
      ),
    );
  }
}