import 'package:flutter/material.dart';
import 'package:navega_app/Feature/client_mood/models/boat_detail_model.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';

import 'package:navega_app/core/widgets/button/circle_icon_button.dart';

class SimilarBoatCard extends StatelessWidget {
  final SimilarBoat boat;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;

  const SimilarBoatCard({
    super.key,
    required this.boat,
    required this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Image.asset(
                  boat.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.fieldFill,
                    child: const Icon(
                      Icons.directions_boat,
                      size: 40,
                      color: AppColors.textGrey,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: CircleIconButton(
                  icon: Icons.favorite_border,
                  onTap: onFavoriteTap ?? () {},
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${boat.boatType} · ${boat.petsInfo}', style: AppTextStyles.bodySmall),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('\$${boat.pricePerDay.toStringAsFixed(0)} US\$', style: AppTextStyles.priceLarge),
                    const SizedBox(width: 4),
                    Text('/ day', style: AppTextStyles.priceUnit),
                  ],
                ),
                Text(boat.name, style: AppTextStyles.label.copyWith(fontSize: 13)),
                const SizedBox(height: 10),
                if (boat.pricePerHour != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${boat.pricePerHour!.toStringAsFixed(0)} per hour', style: AppTextStyles.bodySmall),
                      Text('\$${boat.pricePerDay.toStringAsFixed(0)} per day', style: AppTextStyles.bodySmall),
                    ],
                  ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.buttonHeight - 6,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                      ),
                    ),
                    child: Text('Book Now →', style: AppTextStyles.button.copyWith(fontSize: 14)),
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