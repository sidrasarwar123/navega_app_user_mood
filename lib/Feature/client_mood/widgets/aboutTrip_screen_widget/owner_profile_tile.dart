import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';

import 'package:navega_app/core/constants/textstyle.dart';

/// Boat owner mini-profile row (avatar, name, "Joined in ...").
class OwnerProfileTile extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String joinedLabel;

  const OwnerProfileTile({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.joinedLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.fieldFill,
          backgroundImage: AssetImage(avatarUrl),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: AppTextStyles.label.copyWith(fontSize: 15)),
            const SizedBox(height: 2),
            Text(joinedLabel, style: AppTextStyles.bodySmall),
          ],
        ),
      ],
    );
  }
}