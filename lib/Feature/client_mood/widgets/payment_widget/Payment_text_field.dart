import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';

import 'package:navega_app/core/constants/textstyle.dart';

class PaymentTextField extends StatelessWidget {
  const PaymentTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.trailingBadge,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.maxLength,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final String? trailingBadge;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: 8),
        SizedBox(
          height: AppSpacing.fieldHeight,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
            maxLength: maxLength,
            style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              counterText: '',
              hintText: hintText,
              hintStyle: AppTextStyles.fieldHint,
              filled: true,
              fillColor: AppColors.fieldFill,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              suffixIcon: trailingBadge == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Center(
                        widthFactor: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            trailingBadge!,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
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
                borderSide:
                    const BorderSide(color: AppColors.focusedBorder, width: 1.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}