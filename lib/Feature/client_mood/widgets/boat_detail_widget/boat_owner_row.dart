import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';


import '../../models/boat_detail_model.dart';

/// Owner avatar, name, joined date and a Contact button.
class BoatOwnerRow extends StatelessWidget {
  final OwnerInfo owner;
  final VoidCallback onContactTap;

  const BoatOwnerRow({
    super.key,
    required this.owner,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.fieldFill,
          backgroundImage: AssetImage(owner.imageUrl),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                owner.name,
                style: AppTextStyles.titleLarge.copyWith(fontSize: 15),
              ),
              const SizedBox(height: 2),
              Text(owner.joinedDate, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: onContactTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
              ),
            ),
            child: Text(
              'Contact',
              style: AppTextStyles.button.copyWith(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}