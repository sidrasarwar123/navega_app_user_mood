import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';

/// Small round white button used for back / favorite / share
/// actions on top of images across the app.
class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final double size;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconColor = AppColors.textDark,
    this.size = 38,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: size * 0.47, color: iconColor),
      ),
    );
  }
}