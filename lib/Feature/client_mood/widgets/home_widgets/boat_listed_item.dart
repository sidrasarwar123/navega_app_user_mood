import 'package:flutter/material.dart';
import 'package:navega_app/Feature/client_mood/models/home_model.dart';


import 'package:navega_app/core/widgets/button/primary_button.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/textstyle.dart';

class BoatListItem extends StatelessWidget {
  final BoatListing boat;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onBookNow;

  const BoatListItem({
    super.key,
    required this.boat,
    this.onTap,
    this.onFavoriteToggle,
    this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 92,
                        width: 100,
                        child: Image.asset(
                          boat.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: AppColors.fieldFill,
                            child: const Icon(
                              Icons.directions_boat_filled,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: InkWell(
                        onTap: onFavoriteToggle,
                        customBorder: const CircleBorder(),
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                          child: Icon(
                            boat.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 13,
                            color: boat.isFavorite
                                ? AppColors.danger
                                : AppColors.textDark,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, size: 13, color: Color(0xFFFFB020)),
                          const SizedBox(width: 4),
                          Text(boat.rating.toStringAsFixed(1), style: AppTextStyles.bodySmall),
                          const SizedBox(width: 6),
                          const Text('\u2022', style: AppTextStyles.bodySmall),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              boat.tag,
                              style: AppTextStyles.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                           '${boat.currency}${boat.price.toStringAsFixed(0)}',
                            style: AppTextStyles.label.copyWith(
                              fontSize: 16,
                              color: AppColors.primaryBlueDark,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text('/ day', style: AppTextStyles.bodySmall),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        boat.title,
                        style: AppTextStyles.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // if (boat.pricePerHour != null) ...[
                      //   const SizedBox(height: 2),
                      //   Text(
                      //     '${boat.currency}${boat.pricePerHour!.toStringAsFixed(0)} per hour',
                      //     style: AppTextStyles.bodySmall,
                      //   ),
                      // ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 38,
              child: PrimaryButton(
                label: 'Book Now',
                trailingIcon: Icons.arrow_forward,
                onPressed: onBookNow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
