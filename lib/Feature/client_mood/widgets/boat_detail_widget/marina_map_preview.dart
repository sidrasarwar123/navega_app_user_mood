import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';

import '../../models/boat_detail_model.dart';

/// Small static-map style preview with the marina description
/// overlaid on top left.
class MarinaMapPreview extends StatelessWidget {
  final MarinaLocation marina;

  const MarinaMapPreview({super.key, required this.marina});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: Stack(
        children: [
        SizedBox(
            height: 140,
            width: double.infinity,
            child: Image.asset(
              marina.mapImageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.fieldFill,
                child: const Icon(Icons.map, size: 40, color: AppColors.textGrey),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            right: 40,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                marina.description,
                style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}