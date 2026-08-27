import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navega_app/Feature/client_mood/widgets/bottom_bar/botton_nav_bar.dart';
import 'package:navega_app/Feature/client_mood/widgets/favourite_wigdet/collection_card.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';

import 'package:navega_app/core/constants/textstyle.dart';
import 'package:navega_app/core/routes/app_routes.dart';
import 'package:navega_app/core/widgets/button/chat_bubble_button.dart';

class FavoriteListScreen extends StatefulWidget {
  const FavoriteListScreen({super.key});

  @override
  State<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  // Favourites tab is already active on this screen.
  int _navIndex = 2;

  // Dummy data — replace with real data from a controller/service later.
  static const List<Map<String, String>> _collections = [
    {
      'image':
          'assets/boat.png',
      'label': 'Samra Yousuf (2)',
    },
    {
      'image':
          'assets/boat.png',
      'label': 'Samra Yousuf (2)',
    },
    {
      'image':
          'assets/boat.png',
      'label': 'Samra Yousuf (2)',
    },
    {
      'image':
          'assets/boat.png',
      'label': 'Samra Yousuf (2)',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
     body: SafeArea(
  bottom: false,
  child: Stack(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              20,
              AppSpacing.screenHorizontal,
              20,
            ),
            child: Text(
              "Favourite List",
              style: AppTextStyles.priceLarge,
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                20,
                AppSpacing.screenHorizontal,
                20,
              ),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 28,
                childAspectRatio: 0.95,
              ),
              itemCount: _collections.length,
              itemBuilder: (context, index) {
                final item = _collections[index];

                return FavoriteCollectionCard(
                  imageUrl: item['image']!,
                  label: item['label']!,
                  onTap: () {
                    // TODO
                  },
                );
              },
            ),
          ),
        ],
      ),

     
      Positioned(
        right: AppSpacing.screenHorizontal,
        bottom: 10,
        child: ChatBubbleButton(
          onTap: () {},
        ),
      ),
    ],
  ),
),
     
       bottomNavigationBar: HomeBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Get.offNamed(Routes.home);
          }
        },
        onCenterButtonTap: () {
          // TODO: hook up the "+" center action
        },
      ),
    );
  }

 
}
