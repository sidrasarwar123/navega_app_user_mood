import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';


/// "Publish Now" call-to-action banner shown between the recommended
/// boats and most-viewed sections, inviting the user to list their boat.
class PublishPromoBanner extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onPublishTap;

  const PublishPromoBanner({
    super.key,
    this.imagePath = 'assets/images/publish_promo.png',
    this.onPublishTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 130,
            child: Image.asset(
              "assets/Image (4).png",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.person_outline_rounded,
                size: 64,
                color: AppColors.textGrey,
              ),
            ),
          ),
       
         
          const SizedBox(height: 16),
          SizedBox(
            height: AppSpacing.buttonHeight,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onPublishTap,
              icon: const Icon(Icons.upload_rounded, size: 18),
              label: const Text('Publish Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                ),
                textStyle: AppTextStyles.button,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
