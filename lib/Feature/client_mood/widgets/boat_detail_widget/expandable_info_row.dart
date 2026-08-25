import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/textstyle.dart';
class ExpandableInfoRow extends StatelessWidget {
  final String title;
  final String actionLabel;
  final bool expanded;
  final String content;
  final VoidCallback onTap;

  const ExpandableInfoRow({
    super.key,
    required this.title,
    required this.actionLabel,
    required this.expanded,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTextStyles.sectionTitle),
                Row(
                  children: [
                    Text(actionLabel, style: AppTextStyles.link),
                    const SizedBox(width: 4),
                    Icon(
                      expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      size: 18,
                      color: AppColors.primaryBlue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (expanded)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(content, style: AppTextStyles.bodySmall),
          ),
        const Divider(color: AppColors.divider, height: 1),
      ],
    );
  }
}