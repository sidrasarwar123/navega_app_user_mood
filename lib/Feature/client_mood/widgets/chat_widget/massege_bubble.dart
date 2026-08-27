import 'package:flutter/material.dart';
import 'package:navega_app/Feature/client_mood/models/massege_model.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/textstyle.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final String? avatarPath;

  const MessageBubble({
    super.key,
    required this.message,
    this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            _Avatar(imagePath: message.showAvatar ? avatarPath : null),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.68,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.primaryBlue : AppColors.fieldFill,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isMe ? 16 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 16),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: AppTextStyles.label.copyWith(
                      fontWeight: FontWeight.w400,
                      color: isMe ? AppColors.white : AppColors.textDark,
                    ),
                  ),
                ),
                if (message.reaction != null)
                  Positioned(
                    bottom: -6,
                    right: isMe ? null : 6,
                    left: isMe ? 6 : null,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        message.reaction!,
                        style: const TextStyle(fontSize: 14),
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
}

class _Avatar extends StatelessWidget {
  final String? imagePath;

  const _Avatar({this.imagePath});

  bool get _isNetwork =>
      imagePath != null &&
      (imagePath!.startsWith('http://') || imagePath!.startsWith('https://'));

  @override
  Widget build(BuildContext context) {
    if (imagePath == null || imagePath!.isEmpty) {
      // Keeps spacing consistent for grouped messages without repeating the avatar.
      return const SizedBox(width: 26);
    }

    return CircleAvatar(
      radius: 13,
      backgroundColor: AppColors.fieldFill,
      backgroundImage:
          _isNetwork ? NetworkImage(imagePath!) : AssetImage(imagePath!) as ImageProvider,
    );
  }
}