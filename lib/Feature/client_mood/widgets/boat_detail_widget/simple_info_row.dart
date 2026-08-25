import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/textstyle.dart';
class SimpleInfoRow extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback onTap;

  const SimpleInfoRow({
    super.key,
    required this.title,
    this.actionLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.sectionTitle),
            Row(
              children: [
                if (actionLabel != null) Text(actionLabel!, style: AppTextStyles.link),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right, size: 18, color: AppColors.primaryBlue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}