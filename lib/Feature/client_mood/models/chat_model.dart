/// Simple UI model for a single row in the chats list.
/// Replace with your real data model once the backend/API is connected.
class ChatModel {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final String? avatarUrl;
  final bool hasUnread;
  final bool isReactionPreview;

  const ChatModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.avatarUrl,
    this.hasUnread = false,
    this.isReactionPreview = false,
  });
}