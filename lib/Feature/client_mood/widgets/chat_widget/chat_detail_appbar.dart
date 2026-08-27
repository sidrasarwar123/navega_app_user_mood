import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/textstyle.dart';

class ChatDetailAppBar extends StatelessWidget {
  final String name;
  final String status;
  final String? avatarPath;
  final VoidCallback? onBack;
  final VoidCallback? onCall;
  final VoidCallback? onVideoCall;
  final VoidCallback? onInfo;

  const ChatDetailAppBar({
    super.key,
    required this.name,
    required this.status,
    this.avatarPath,
    this.onBack,
    this.onCall,
    this.onVideoCall,
    this.onInfo,
  });

  bool get _isNetwork =>
      avatarPath != null &&
      (avatarPath!.startsWith('http://') || avatarPath!.startsWith('https://'));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          InkWell(
            customBorder: const CircleBorder(),
            onTap: onBack,
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.arrow_back, color: AppColors.textDark, size: 22),
            ),
          ),
          const SizedBox(width: 4),
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.fieldFill,
            backgroundImage: avatarPath == null
                ? null
                : (_isNetwork
                    ? NetworkImage(avatarPath!)
                    : AssetImage(avatarPath!) as ImageProvider),
            child: avatarPath == null
                ? const Icon(Icons.person, color: AppColors.textGrey, size: 18)
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: AppTextStyles.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  status,
                  style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          _iconButton(Icons.call_outlined, onCall),
          const SizedBox(width: 8),
          _iconButton(Icons.videocam_outlined, onVideoCall),
          const SizedBox(width: 8),
          _iconButton(Icons.info_outline, onInfo),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback? onTap) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 20, color: AppColors.primaryBlueDark),
      ),
    );
  }
}