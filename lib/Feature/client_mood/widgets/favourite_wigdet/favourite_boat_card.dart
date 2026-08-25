import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';

import 'package:navega_app/core/constants/textstyle.dart';

class FavouriteBoatCard extends StatelessWidget {
  final String imageUrl;
  final String? imageAssetPath;
  final String categoryTag;
  final String price;
  final String priceUnit;
  final String hourlyRate;
  final String dailyRate;
  final bool isFavourite;
  final VoidCallback? onBookNow;
  final VoidCallback? onFavouriteTap;

  const FavouriteBoatCard({
    super.key,
    required this.imageUrl,
    this.imageAssetPath,
    required this.categoryTag,
    required this.price,
    required this.priceUnit,
    required this.hourlyRate,
    required this.dailyRate,
    this.isFavourite = true,
    this.onBookNow,
    this.onFavouriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sectionSpacing),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius + 8),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Image with favourite heart ----
          Stack(
            children: [
               AspectRatio(
                    aspectRatio: 16 / 11,
                    child: Image.asset(
                  imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.fieldFill,
                        child: const Icon(
                          Icons.directions_boat_filled,
                          color: AppColors.textGrey,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: onFavouriteTap,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: AppColors.danger,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ---- Content ----
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category tag row
                Row(
                  children: [
                    const Icon(
                      Icons.directions_boat_filled,
                      size: 14,
                      color: AppColors.primaryBlueDark,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      categoryTag,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Price row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: price,
                            style: AppTextStyles.priceLarge,
                          ),
                          TextSpan(
                            text: ' $priceUnit',
                            style: AppTextStyles.priceUnit,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(hourlyRate, style: AppTextStyles.priceUnit),
                        Text(dailyRate, style: AppTextStyles.priceUnit),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Book Now button
                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.buttonHeight,
                  child: ElevatedButton(
                    onPressed: onBookNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.buttonRadius + 20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Book Now', style: AppTextStyles.button),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageFallback() {
    return Container(
      color: AppColors.fieldFill,
      child: const Icon(
        Icons.directions_boat,
        size: 40,
        color: AppColors.textGrey,
      ),
    );
  }
}