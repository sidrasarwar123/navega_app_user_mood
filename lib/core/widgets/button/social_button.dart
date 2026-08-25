import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';


class SocialIconButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback? onTap;

  const SocialIconButton({
    super.key,
    required this.assetPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
          border: Border.all(color: AppColors.fieldBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Image.asset(assetPath, fit: BoxFit.contain),
      ),
    );
  }
}