import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
// apna colors file import karen (jahan AppColors defined hai)

/// Small floating circular chat button.
class ChatBubbleButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ChatBubbleButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        height: 46,
        width: 46,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryBlue,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlueDark.withValues(alpha: 0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.chat_bubble_outline_rounded,
          color: AppColors.white,
          size: 20,
        ),
      ),
    );
  }
}