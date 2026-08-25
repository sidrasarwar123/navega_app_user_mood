import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';

import 'package:navega_app/core/constants/textstyle.dart';

/// Compact boat summary shown at the top of the "Review and Pay" screen.
class BoatSummaryCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final String subInfo;
  final String pricePerDay;

  const BoatSummaryCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.subInfo,
    required this.pricePerDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            child: Image.asset(
              imageUrl,
              width: 100,
              height: 130,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 72,
                height: 72,
                color: AppColors.fieldBorder,
                child: const Icon(Icons.directions_boat, color: AppColors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.label.copyWith(fontSize: 15),
                ),
              
                Text(
                  location,
                  style: AppTextStyles.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // const SizedBox(height: 2),
                Text(subInfo, style: AppTextStyles.bodySmall),
                // const SizedBox(height: 2),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: pricePerDay,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      TextSpan(
                        text: ' /day',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}