import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:navega_app/Feature/client_mood/widgets/favourite_wigdet/favourite_boat_card.dart';
import 'package:navega_app/Feature/client_mood/widgets/bottom_bar/botton_nav_bar.dart';
import 'package:navega_app/Feature/client_mood/widgets/favourite_wigdet/favorite_collection_dialog.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';

import 'package:navega_app/core/constants/textstyle.dart';
import 'package:navega_app/core/routes/app_routes.dart';
import 'package:navega_app/core/widgets/button/chat_bubble_button.dart';


/// Favourite screen — pure frontend UI, static dummy data.
/// Wire this up to a controller (GetX) later if needed.
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  // Dummy data — replace with real data from a controller/service later.
  static const List<Map<String, String>> _favourites = [
    {
        'image': 'assets/boat 2.png',
      'category': 'Crossover · 6 mascotas',
      'price': '200 US\$',
      'unit': '/dia',
      'hourly': '5X per hour',
      'daily': '5Y per day',
      'name': 'Bacca di Magna 2021',
    },
    {
        'image': 'assets/boat.png',
      'category': 'Canoola Central · Yes pets',
      'price': '2000 US\$',
      'unit': '/day',
      'hourly': '5X per hour',
      'daily': '5Y per day',
      'name': 'Sunseeker Manhattan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
     body: SafeArea(
  child: Stack(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: _buildBackButton(),
          ),

          const SizedBox(height: 8),

          _buildHeader(),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: AppSpacing.screenHorizontal,
                right: AppSpacing.screenHorizontal,
                top: 8,
                bottom: 16,
              ),
              itemCount: _favourites.length,
              itemBuilder: (context, index) {
                final item = _favourites[index];

                return FavouriteBoatCard(
                  imageUrl: item['image']!,
                  categoryTag: item['category']!,
                  price: item['price']!,
                  priceUnit: item['unit']!,
                  hourlyRate: item['hourly']!,
                  dailyRate: item['daily']!,
                  onFavouriteTap: () {
                    // TODO: hook up remove-from-favourites logic
                  },
                  onBookNow: () {
                    // TODO: navigate to booking screen
                  },
                );
              },
            ),
          ),
        ],
      ),

      // ✅ Chat button RIGHT side
      Positioned(
        right: AppSpacing.screenHorizontal,
        bottom: 20,
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
          if (index == 1) {
            Get.toNamed(Routes.chat);
            return;
          }
          if (index == 0) {
            Get.offNamed(Routes.home);
          }
        },
        onCenterButtonTap: showFavoriteCollectionDialog,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        8,
        AppSpacing.screenHorizontal,
        12,
      ),
      child: Row(
        children: [
         
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Samra Yousuf', style: AppTextStyles.titleLarge),
              Text('${_favourites.length} Item', style: AppTextStyles.subtitle),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildBackButton() {
    return InkWell(
     onTap: () => Get.back(),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.fieldBorder),
        ),
        child: const Icon(Icons.arrow_back, size: 18, color: AppColors.textDark),
      ),
    );
  }


//

}
