import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navega_app/Feature/client_mood/models/chat_model.dart';
import 'package:navega_app/Feature/client_mood/widgets/bottom_bar/botton_nav_bar.dart';
import 'package:navega_app/Feature/client_mood/widgets/chat_widget/chat_list_tile.dart';
import 'package:navega_app/Feature/client_mood/widgets/chat_widget/chat_search_screen.dart';
import 'package:navega_app/Feature/client_mood/widgets/favourite_wigdet/favorite_collection_dialog.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';
import 'package:navega_app/core/routes/app_routes.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // TODO: Replace with real data coming from your controller / API / GetX.
  final List<ChatModel> _chats = const [
    ChatModel(
      id: '1',
      name: 'Brian Griffin',
      lastMessage: 'Yay, this will be the best time of...',
      time: '1w',
      avatarUrl: 'assets/userimage.png',  
    ),
    ChatModel(
      id: '2',
      name: 'Meg Griffin',
      lastMessage: 'You: Hey! Would Wynn like to co...',
      time: '8w',
      // hasUnread: true,
      avatarUrl: 'assets/userimage.png',  
    ),
    ChatModel(
      id: '3',
      name: 'Joe Swanson',
      lastMessage: 'Scott sent an attachment.',
      time: '6w',
      avatarUrl: 'assets/userimage.png',  
    ),
    ChatModel(
      id: '4',
      name: 'Lois Griffin',
      lastMessage: 'Reacted 👍 to your message',
      time: '5w',
       avatarUrl: 'assets/userimage.png', 
    ),
    ChatModel(
      id: '5',
      name: 'Brian Griffin',
      lastMessage: 'Yay, this will be the best time of...',
      time: '1w',
       avatarUrl: 'assets/userimage.png', 
    ),
    ChatModel(
      id: '6',
      name: 'Meg Griffin',
      lastMessage: 'You: Hey! Would Wynn like to co...',
      time: '8w',
       avatarUrl: 'assets/userimage.png', 
    ),
    
  ];

  List<ChatModel> get _filteredChats {
    if (_query.trim().isEmpty) return _chats;
    return _chats
        .where((c) => c.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildHeader(),
              const SizedBox(height: 16),
              ChatSearchField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _filteredChats.isEmpty
                    ? Center(
                        child: Text(
                          'No chats found',
                          style: AppTextStyles.bodySmall,
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 90),
                        itemCount: _filteredChats.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final chat = _filteredChats[index];
                          return ChatListTile(
                            chat: chat,
                            isSelected: chat.name == 'Lois Griffin',
                            onTap: () {
                               Get.toNamed(
      Routes.chatdetail,
      arguments: {
        'name': chat.name,
        'status': 'Active 9m ago',
        'avatarPath': chat.avatarUrl,
      },
    );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
        bottomNavigationBar: HomeBottomNavBar(
  currentIndex: 1, // Chats tab hamesha selected rahega jab hum is screen par hain
  onTap: (index) {
    if (index == 1) {
     Get.toNamed(Routes.chat);
      return;
    }
    if (index == 0) {
      Get.offNamed(Routes.home); // Home screen pe wapas jao
      return;
    }
    if (index == 2) {
      Get.toNamed(Routes.favorites);
      return;
    }
    // if (index == 3) {
    //   Get.toNamed(Routes.profile);
    //   return;
    // }
  },
  onCenterButtonTap: showFavoriteCollectionDialog,
),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Chats', style: AppTextStyles.heading),
        Row(
          children: [
            _headerIconButton(Icons.more_horiz, onTap: () {}),
            const SizedBox(width: 10),
            _headerIconButton(Icons.edit_outlined, onTap: () {}),
          ],
        ),
      ],
    );
  }

  Widget _headerIconButton(IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.fieldFill,
          border: Border.all(color: AppColors.divider),
        ),
        child: Icon(icon, size: 18, color: AppColors.textDark),
      ),
    );
  }
}