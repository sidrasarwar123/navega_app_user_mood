import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:navega_app/Feature/client_mood/models/home_model.dart';

import 'package:navega_app/Feature/client_mood/widgets/home_widgets/boat_cards.dart';
import 'package:navega_app/Feature/client_mood/widgets/home_widgets/boat_listed_item.dart';
import 'package:navega_app/Feature/client_mood/widgets/bottom_bar/botton_nav_bar.dart';
import 'package:navega_app/Feature/client_mood/widgets/home_widgets/popular_location_item.dart';
import 'package:navega_app/Feature/client_mood/widgets/home_widgets/publish_promo_banner.dart';
import 'package:navega_app/Feature/client_mood/widgets/favourite_wigdet/favorite_collection_dialog.dart';
import 'package:navega_app/core/constants/app_assets.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';

import 'package:navega_app/core/routes/app_routes.dart';


class HomeScreen extends StatefulWidget {
  final String userName;
  final String? avatarAssetPath;

  const HomeScreen({
    super.key,
    this.userName = 'Samra',
    this.avatarAssetPath,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  int _navIndex = 0;

  final List<PopularLocation> _locations = const [
    PopularLocation(name: 'Los Angeles', imagePath: "assets/location 1.png"),
    PopularLocation(name: 'Austin', imagePath: 'assets/location 2.png'),
    PopularLocation(name: 'Miami', imagePath: 'assets/location 1.png'),
    PopularLocation(name: 'Seattle', imagePath: 'assets/location 2.png'),
  ];

  final List<BoatListing> _recommendedBoats = [
  BoatListing(
    title: 'Sunseeker Manhattan 130\'',
    imagePath: 'assets/boat 1.png',
    rating: 4.9,
    tag: 'Consola Central • Yes pets',
    price: 2000,
  ),
  BoatListing(
    title: 'Azimut Grande',
    imagePath: 'assets/boat 2.png',
    rating: 4.7,
    tag: 'Flybridge • No pets',
    price: 1650,
  ),
  ];

final List<BoatListing> _mostViewedBoats = [
  BoatListing(
    title: 'Bocca di Magra 2021',
    imagePath: 'assets/boat 4.png',
    rating: 4.6,
    tag: 'Crossover • 6 seats',
    price: 1200,
  ),
  BoatListing(
    title: 'Sunseeker Manhattan 130\'',
    imagePath: 'assets/boat 5.png',
    rating: 4.9,
    tag: 'Consola Central • Yes pets',
    price: 2000,
  ),
  BoatListing(
    title: 'Wavemarine Campania – 148 Co...',
    imagePath: 'assets/boat 4.png',
    rating: 4.5,
    tag: 'Neptunus • 8 seats',
    price: 1000,
  ),
  BoatListing(
    title: 'Sea Ray',
    imagePath: 'assets/boat 3.png',
    rating: 4.4,
    tag: 'Consola Central • 6 seats',
    price: 1000,
  ),
];
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeaderSection(
                    userName: widget.userName,
                    avatarAssetPath: AppImage.profile,
                    onSettingsTap: () {},
                  ),
                  Padding(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _SearchBar(controller: _searchController),
                        const SizedBox(height: 24),
                        const Text('Popular Locations', style: AppTextStyles.heading),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),

                  // Popular locations — horizontal scroll
                  SizedBox(
                    height: 108,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenHorizontal,
                      ),
                      itemCount: _locations.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 18),
                      itemBuilder: (context, index) => PopularLocationItem(
                        location: _locations[index],
                        onTap: () {},
                      ),
                    ),
                  ),

                  Padding(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 24),
                        Text('Recommended Boats', style: AppTextStyles.heading),
                        SizedBox(height: 14),
                      ],
                    ),
                  ),

                  // Recommended boats — horizontal scroll with Book Now
                  SizedBox(
                    height: 330,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenHorizontal,
                      ),
                      itemCount: _recommendedBoats.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final boat = _recommendedBoats[index];
                        return BoatCard(
                          boat: boat,
                          onTap: () {
                            Get.toNamed(Routes.boatDetails);
                          },
                          onBookNow: () {
                            Get.toNamed(Routes.reviewPay);
                          },
                          onFavoriteToggle: () {
                            setState(() => boat.isFavorite = !boat.isFavorite);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Publish Now promo banner
                  PublishPromoBanner(onPublishTap: () {}),
                  const SizedBox(height: 28),

                  // Most Viewed — vertical list
                  Padding(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Most Viewed', style: AppTextStyles.heading),
                        const SizedBox(height: 14),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _mostViewedBoats.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            final boat = _mostViewedBoats[index];
                            return BoatListItem(
                              boat: boat,
                              onTap: () {
                                Get.toNamed(Routes.boatDetails);
                              },
                              onBookNow: () {
                                   Get.toNamed(Routes.reviewPay);
                              },
                              onFavoriteToggle: () {
                                setState(() => boat.isFavorite = !boat.isFavorite);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),

            // Floating chat bubble button, above the bottom nav bar.
            Positioned(
              right: AppSpacing.screenHorizontal,
              bottom: 96,
              child: _ChatBubbleButton(onTap: () {}),
            ),
          ],
        ),
      ),
    bottomNavigationBar: HomeBottomNavBar(
  currentIndex: _navIndex,
      onTap: (index) {
        if (index == 2) {
          Get.toNamed(Routes.favorites);
          return;
        }
        setState(() => _navIndex = index);
      },
  onCenterButtonTap: showFavoriteCollectionDialog,
),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final String userName;
  final String? avatarAssetPath;
  final VoidCallback? onSettingsTap;

  const _HeaderSection({
    required this.userName,
    this.avatarAssetPath,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFEAF4FE),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        18,
        AppSpacing.screenHorizontal,
        22,
      ),
      child: Row(
        children: [
        CircleAvatar(
  radius: 22,
  backgroundColor: AppColors.fieldFill,
  child: ClipOval(
    child: avatarAssetPath != null
        ? Image.asset(
            avatarAssetPath!,
            width: 44,
            height: 44,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.person,
                color: AppColors.textGrey,
              );
            },
          )
        : const Icon(
            Icons.person,
            color: AppColors.textGrey,
          ),
  ),
),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                const Text('\ud83d\udc4b', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hello', style: AppTextStyles.bodySmall),
                    Text(
                      userName,
                      style: AppTextStyles.label.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onSettingsTap,
            customBorder: const CircleBorder(),
            child: Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: const Icon(
                Icons.settings_outlined,
                color: AppColors.textDark,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Search field with a trailing filter/settings icon button.
class _SearchBar extends StatelessWidget {
  final TextEditingController controller;

  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: AppSpacing.fieldHeight,
            child: TextField(
              controller: controller,
              style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                hintText: 'Search Destination, City, Address',
                hintStyle: AppTextStyles.fieldHint,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textGrey,
                  size: 20,
                ),
                filled: true,
                fillColor: AppColors.fieldFill,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  borderSide: const BorderSide(color: AppColors.fieldBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  borderSide: const BorderSide(color: AppColors.fieldBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  borderSide: const BorderSide(color: AppColors.primaryBlue),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: AppSpacing.fieldHeight,
          width: AppSpacing.fieldHeight,
          decoration: BoxDecoration(
            color: AppColors.fieldFill,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(color: AppColors.fieldBorder),
          ),
         child: IconButton(
  onPressed: () {
    Get.toNamed(Routes.filter);
  },
  icon: const Icon(
    Icons.tune_rounded,
    color: AppColors.textDark,
    size: 20,
  ),
),
        ),
      ],
    );
  }
}

/// Small floating circular chat button.
class _ChatBubbleButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _ChatBubbleButton({this.onTap});

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



