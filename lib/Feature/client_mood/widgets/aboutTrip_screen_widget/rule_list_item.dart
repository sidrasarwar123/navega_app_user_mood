import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/textstyle.dart';

/// Single boat-rule row with a green check mark (used in "Read the Boat
/// Rules" step).
class RuleListItem extends StatelessWidget {
  final String text;

  const RuleListItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.check, size: 16, color: AppColors.successGreen),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: AppTextStyles.fieldHint.copyWith(color: AppColors.textDark)),
        ),
      ],
    );
  }
}