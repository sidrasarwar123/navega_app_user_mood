import 'package:flutter/material.dart';


import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/widgets/button/circle_icon_button.dart';

class BoatHeaderImage extends StatelessWidget {
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback onBack;
  final VoidCallback onFavoriteTap;
  final VoidCallback onShareTap;

  const BoatHeaderImage({
    super.key,
    required this.imageUrl,
    required this.isFavorite,
    required this.onBack,
    required this.onFavoriteTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(AppSpacing.cardRadius),
            ),
             child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.fieldFill,
                child: const Icon(
                  Icons.directions_boat,
                  size: 60,
                  color: AppColors.textGrey,
                ),
              ),
            ),
          ),
          Positioned(
            top: 48,
            left: AppSpacing.screenHorizontal,
            child: CircleIconButton(icon: Icons.arrow_back, onTap: onBack),
          ),
          Positioned(
            top: 48,
            right: AppSpacing.screenHorizontal,
            child: Row(
              children: [
                CircleIconButton(
                  icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                  iconColor: isFavorite ? AppColors.danger : AppColors.textDark,
                  onTap: onFavoriteTap,
                ),
                const SizedBox(width: 10),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}