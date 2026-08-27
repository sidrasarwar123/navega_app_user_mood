import 'package:flutter/material.dart';
import 'package:navega_app/Feature/client_mood/models/chat_model.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';


class ChatListTile extends StatelessWidget {
  final ChatModel chat;
  final bool isSelected;
  final VoidCallback? onTap;

  const ChatListTile({
    super.key,
    required this.chat,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius + 4),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.splashGradientBottom.withValues(alpha: 0.35)
              : AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius + 4),
          border: Border.all(
            color: isSelected ? AppColors.splashGradientBottom : AppColors.divider,
          ),
        ),
        child: Row(
          children: [
            _Avatar(imageUrl: chat.avatarUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: AppTextStyles.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      // if (chat.hasUnread)
                       
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          style: AppTextStyles.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              chat.time,
              style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? imageUrl;

  const _Avatar({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: AppColors.fieldFill,
      backgroundImage: imageUrl != null ? AssetImage(imageUrl!) : null,
      child: imageUrl == null
          ? const Icon(Icons.person, color: AppColors.textGrey, size: 22)
          : null,
    );
  }
}