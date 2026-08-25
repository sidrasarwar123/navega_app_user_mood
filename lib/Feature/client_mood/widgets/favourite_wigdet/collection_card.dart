import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';

import 'package:navega_app/core/constants/textstyle.dart';

class FavoriteCollectionCard extends StatelessWidget {
  final String imageUrl;
  final String label;
  final VoidCallback? onTap;

  const FavoriteCollectionCard({
    super.key,
    required this.imageUrl,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius + 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Image + heart badge ----
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius + 8),
                child: AspectRatio(
                  aspectRatio: 1.35,
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.fieldFill,
                      child: const Icon(
                        Icons.directions_boat,
                        size: 34,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   bottom: -8,
              //   right: 10,
              //   child: Container(
              //     padding: const EdgeInsets.all(6),
              //     decoration: BoxDecoration(
              //       color: AppColors.white,
              //       shape: BoxShape.circle,
              //       boxShadow: [
              //         BoxShadow(
              //           color: AppColors.black.withOpacity(0.12),
              //           blurRadius: 6,
              //           offset: const Offset(0, 2),
              //         ),
              //       ],
              //     ),
              //     child: const Icon(
              //       Icons.favorite,
              //       size: 14,
              //       color: AppColors.danger,
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 14),

          // ---- Label ----
          Text(
            label,
            style: AppTextStyles.label,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}