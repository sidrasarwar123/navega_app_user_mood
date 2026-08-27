import 'package:flutter/material.dart';
import 'package:navega_app/Feature/client_mood/models/massege_model.dart';
import 'package:navega_app/Feature/client_mood/widgets/chat_widget/chat_detail_appbar.dart';
import 'package:navega_app/Feature/client_mood/widgets/chat_widget/massege_bubble.dart';

import 'package:navega_app/core/constants/app_color.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String status;
  final String? avatarPath;

  const ChatDetailScreen({
    super.key,
    required this.name,
    this.status = 'Active now',
    this.avatarPath,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // TODO: Replace with real messages coming from your controller / API.
  final List<MessageModel> _messages = const [
    MessageModel(
      id: '1',
      text:
          "Hahaha it's all good! I'm here another 10 days. Just house/dog sitting today through Saturday still.  Then here another week after that before I come home.",
      isMe: false,
    ),
    MessageModel(
      id: '2',
      text: "Nice! Let's try and grab lunch next week. What's in Colorado for you?",
      isMe: true,
    ),
    MessageModel(
      id: '3',
      text: 'Peter, you know my family lives here.',
      isMe: false,
      showAvatar: false,
    ),
    MessageModel(
      id: '4',
      text:
          "You're welcome to join me next time. It would be nice for you to see them. It's been years. But you need to behave...",
      isMe: false,
      showAvatar: false,
    ),
    MessageModel(
      id: '5',
      text: "Gosh, it's not like me to do anything crazy or stupid.",
      isMe: true,
    ),
    MessageModel(
      id: '6',
      text: 'Sure, Peter.',
      isMe: false,
    ),
    MessageModel(
      id: '7',
      text: 'Bird is the word',
      isMe: true,
      reaction: '😂',
    ),
    MessageModel(
      id: '8',
      text: 'Have you been drinking?',
      isMe: false,
      reaction: '😅',
    ),
    MessageModel(
      id: '9',
      text:
          'Peter, did you rob a bunch of people on the beach with your metal detector? Please say no...',
      isMe: false,
      showAvatar: false,
    ),
    MessageModel(
      id: '10',
      text: "Well, that's only half the story",
      isMe: true,
      reaction: '😜',
    ),
    MessageModel(
      id: '11',
      text:
          "Oh, I wouldn't worry about it, Peter. I've put Stewie in the oven a bunch of times. If you come to your senses within 15 minutes, everything's fine.",
      isMe: false,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    // TODO: push the new message into your controller / API
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            ChatDetailAppBar(
              name: widget.name,
              status: widget.status,
              avatarPath: widget.avatarPath,
              onBack: () => Navigator.of(context).maybePop(),
              onCall: () {},
              onVideoCall: () {},
              onInfo: () {},
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return MessageBubble(
                    message: message,
                    avatarPath: widget.avatarPath,
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.fieldBorder),
              ),
              child: TextField(
                controller: _messageController,
                minLines: 1,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  hintText: 'Message...',
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: _sendMessage,
            customBorder: const CircleBorder(),
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded, color: AppColors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}