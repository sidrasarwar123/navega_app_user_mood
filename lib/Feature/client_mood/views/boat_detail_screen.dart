import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:navega_app/Feature/client_mood/models/boat_detail_model.dart';
import 'package:navega_app/Feature/client_mood/widgets/boat_detail_widget/boat_bottom_bar.dart';
import 'package:navega_app/Feature/client_mood/widgets/boat_detail_widget/boat_image_header.dart';
import 'package:navega_app/Feature/client_mood/widgets/boat_detail_widget/boat_owner_row.dart';
import 'package:navega_app/Feature/client_mood/widgets/boat_detail_widget/boat_specs_grid.dart';
import 'package:navega_app/Feature/client_mood/widgets/boat_detail_widget/daily_hourly_toggle.dart';
import 'package:navega_app/Feature/client_mood/widgets/boat_detail_widget/expandable_info_row.dart';
import 'package:navega_app/Feature/client_mood/widgets/boat_detail_widget/marina_map_preview.dart';
import 'package:navega_app/Feature/client_mood/widgets/boat_detail_widget/simple_info_row.dart';
import 'package:navega_app/Feature/shared/shared_widget/similar_boat_card.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';
import 'package:navega_app/core/routes/app_routes.dart';

import 'package:navega_app/core/widgets/toggle/Read_only_box_info.dart';

class BoatDetailScreen extends StatefulWidget {
  const BoatDetailScreen({super.key});

  @override
  State<BoatDetailScreen> createState() => _BoatDetailScreenState();
}

class _BoatDetailScreenState extends State<BoatDetailScreen> {
  final BoatDetailModel boat = BoatDetailModel(
    id: '1',
    name: 'Sunsekeer Manhatan 130',
    location: 'Los roques, Federal Dependencies of Venezuela, VE',
    imageUrl: 'assets/boat 1.png',
    owner: OwnerInfo(
      name: 'Pot of Ricardo',
      imageUrl: 'assets/userimage.png',
      joinedDate: 'Joined in Mar, 2025',
    ),
    boatType: 'Consola Center',
    make: 'Datsun GO+',
    model: 'Maruti Suzuki Eeco',
    year: 1990,
    hasPets: true,
    capacity: 13,
    pricePerDay: 20000,
    pricePerHour: 900,
    aboutBoat: 'muy grande',
    minMaxDaysLabel: '1 day Maximum trip',
    marina: MarinaLocation(
      description:
          'Ricardo Castrillon - The boat is in Los roques, Federal Dependencies of Venezuela, VE',
      latitude: 11.8481,
      longitude: -66.6417,
      mapImageUrl:
          'assets/location.png',
    ),
    boatRules: 'No smoking on board. No pets other than the ones agreed. '
        'Return the boat clean and fueled. Life jackets must be worn at all times.',
    cancellationPolicy: 'Flexible: Full refund 24 hours prior to the trip start time.',
    similarBoats: [
      SimilarBoat(
        id: '2',
        name: 'Sunsekeer Manhatan 130',
        imageUrl: 'assets/boat 1.png',
        boatType: 'Consola Central',
        petsInfo: 'Yes pets',
        pricePerDay: 2000,
        pricePerHour: 100,
      ),
     
    ],
  );

  bool isFavorite = false;
  bool isDailySelected = true;
  bool isBoatRulesExpanded = false;
  bool isCancellationExpanded = false;

  double get currentPrice =>
      isDailySelected ? boat.pricePerDay : (boat.pricePerHour ?? boat.pricePerDay);

  String get priceUnitLabel => isDailySelected ? '/ day' : '/ hour';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoatHeaderImage(
                  imageUrl: boat.imageUrl,
                  isFavorite: isFavorite,
                  onBack: () => Navigator.of(context).maybePop(),
                  onFavoriteTap: () => setState(() => isFavorite = !isFavorite),
                  onShareTap: () {},
                ),
                Padding(
                  padding: AppSpacing.screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(boat.name, style: AppTextStyles.heading),
                      const SizedBox(height: 4),
                      Text(boat.location, style: AppTextStyles.bodySmall),
                      const SizedBox(height: 16),
                      const Divider(color: AppColors.divider),
                      const SizedBox(height: 12),

                      BoatOwnerRow(
                        owner: boat.owner,
                        onContactTap: () {},
                      ),
                      const SizedBox(height: 24),

                      BoatSpecsGrid(boat: boat),
                      const SizedBox(height: 24),

                      DailyHourlyToggle(
                        isDaily: isDailySelected,
                        onChanged: (val) => setState(() => isDailySelected = val),
                      ),
                      const SizedBox(height: 24),

                      Text('About the boat', style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 8),
                      ReadOnlyInfoBox(text: boat.aboutBoat),
                      const SizedBox(height: 20),

                      Text('Min / Max days', style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 8),
                      ReadOnlyInfoBox(text: boat.minMaxDaysLabel),
                      const SizedBox(height: 20),

                      Text('Marina location', style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 8),
                      MarinaMapPreview(marina: boat.marina),
                      const SizedBox(height: 8),

                      ExpandableInfoRow(
                        title: 'Boat rules',
                        actionLabel: 'Read',
                        expanded: isBoatRulesExpanded,
                        content: boat.boatRules,
                        onTap: () => setState(() => isBoatRulesExpanded = !isBoatRulesExpanded),
                      ),
                      ExpandableInfoRow(
                        title: 'Cancellation policy',
                        actionLabel: 'Flexible',
                        expanded: isCancellationExpanded,
                        content: boat.cancellationPolicy,
                        onTap: () => setState(() => isCancellationExpanded = !isCancellationExpanded),
                      ),
                      SimpleInfoRow(title: 'Availability', onTap: () {}),
                      SimpleInfoRow(title: 'Contact Owner', actionLabel: 'Message', onTap: () {}),

                      const SizedBox(height: 28),
                      Text('Similar Boats', style: AppTextStyles.titleLarge),
                      const SizedBox(height: 12),
                      ...boat.similarBoats.map(
                        (s) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: SimilarBoatCard(boat: s, onTap: () {
                            Get.toNamed(Routes.reviewPay);
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BoatBottomBar(
              price: currentPrice,
              priceUnitLabel: priceUnitLabel,
              onBookNow: () {
                Get.toNamed(Routes.travelDates);
              },
            ),
          ),
        ],
      ),
    );
  }
}