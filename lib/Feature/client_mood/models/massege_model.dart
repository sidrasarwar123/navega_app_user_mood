/// Simple UI model for a single chat bubble.
/// Replace with your real message model once backend/API is connected.
class MessageModel {
  final String id;
  final String text;
  final bool isMe;

  /// Optional emoji reaction shown as a small badge on the bubble's corner.
  final String? reaction;

  /// Whether to show the sender's avatar next to this bubble
  /// (usually only on the first message of a group).
  final bool showAvatar;

  const MessageModel({
    required this.id,
    required this.text,
    required this.isMe,
    this.reaction,
    this.showAvatar = true,
  });
}