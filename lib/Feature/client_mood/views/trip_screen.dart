import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:navega_app/Feature/client_mood/widgets/aboutTrip_screen_widget/description_field.dart';
import 'package:navega_app/Feature/client_mood/widgets/aboutTrip_screen_widget/owner_profile_tile.dart';
import 'package:navega_app/Feature/client_mood/widgets/aboutTrip_screen_widget/rule_list_item.dart';
import 'package:navega_app/Feature/client_mood/widgets/button/custom_button.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';
import 'package:navega_app/core/routes/app_routes.dart';



class AboutTripScreen extends StatefulWidget {
  const AboutTripScreen({super.key});

  @override
  State<AboutTripScreen> createState() => _AboutTripScreenState();
}

class _AboutTripScreenState extends State<AboutTripScreen> {
  // ---- local UI state (no controller / no GetX) ----
  final _messageController = TextEditingController();

  // sample/static data — replace with real data passed into this screen
  final String _ownerAvatar =
      'assets/userimage.png';
  final String _ownerName = 'Pot of Ricardo';
  final String _ownerJoined = 'Joined in Mar, 2025';
  final String _boatOwnerFirstName = 'Thomas';

  final List<String> _rules = const [
    'Children should always be supervised by an adult.',
    'Do not jump into the water while the boat is moving.',
  ];

  final String _pricePerDay = '\$20000';
  final int _tripDays = 1;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
           
            Expanded(
              
                child: SingleChildScrollView(
                  padding: AppSpacing.screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      _buildBackButton(),
                      const SizedBox(height: 20),

                      Text('2. About Your Trip', style: AppTextStyles.heading),
                      const SizedBox(height: 8),
                      Text(
                        "Greet your boat owner and tell him why you're coming.",
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(height: 18),

                      OwnerProfileTile(
                        avatarUrl: _ownerAvatar,
                        name: _ownerName,
                        joinedLabel: _ownerJoined,
                      ),
                      const SizedBox(height: 14),

                      DescriptionField(
                        controller: _messageController,
                        hint: 'Navigating the city ? Are you going on a long '
                            'trip ? This helps the boat owner prepare the '
                            'boat for its trip',
                        minLines: 4,
                        maxLines: 6,
                      ),
                      const SizedBox(height: AppSpacing.sectionSpacing),

                      const Divider(color: AppColors.divider, height: 1),
                      const SizedBox(height: AppSpacing.sectionSpacing),

                      Text(
                        "3. Read the $_boatOwnerFirstName 's Boat Rules",
                        style: AppTextStyles.heading.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Please read the $_boatOwnerFirstName 's Boat Rules "
                        "before booking.",
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(height: 14),

                      Column(
                        children: [
                          for (int i = 0; i < _rules.length; i++) ...[
                            RuleListItem(text: _rules[i]),
                            if (i != _rules.length - 1)
                              const SizedBox(height: 10),
                          ],
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
             
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: () => Navigator.of(context).maybePop(),
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

  Widget _buildBottomBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: 14,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_pricePerDay, style: AppTextStyles.priceLarge),
              Text('for $_tripDays day', style: AppTextStyles.priceUnit),
            ],
          ),
          CustomButton(
            text: 'Following',
            icon: Icons.arrow_forward,
            width: 150,
            onPressed: () {
           Get.toNamed(Routes.paymentMethod);
            },
          ),
        ],
      ),
    );
  }
}