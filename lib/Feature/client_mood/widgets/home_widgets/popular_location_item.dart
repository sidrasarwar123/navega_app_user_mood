import 'package:flutter/material.dart';
import 'package:navega_app/Feature/client_mood/models/home_model.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/textstyle.dart';



class PopularLocationItem extends StatelessWidget {
  final PopularLocation location;
  final VoidCallback? onTap;

  const PopularLocationItem({
    super.key,
    required this.location,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Column(
        children: [
          Container(
            height: 76,
            width: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.divider),
            ),
            padding: const EdgeInsets.all(3),
            child: ClipOval(
              child: Image.asset(
                location.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.fieldFill,
                  child: const Icon(
                    Icons.location_city,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            location.name,
            style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
