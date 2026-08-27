import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';

class ChatSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const ChatSearchField({
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.fieldHeight,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.primaryBlue, width: 1.4),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          hintText: 'Search Chat..',
          hintStyle: AppTextStyles.fieldHint,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.primaryBlueDark,
            size: 20,
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 40),
        ),
      ),
    );
  }
}