import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:navega_app/Feature/client_mood/widgets/button/custom_button.dart';
import 'package:navega_app/Feature/client_mood/widgets/pay_reviw_widgets/boat_summary_card.dart';
import 'package:navega_app/Feature/client_mood/widgets/pay_reviw_widgets/price_breakdown_card.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';
import 'package:navega_app/core/routes/app_routes.dart';
import 'package:navega_app/core/widgets/button/circle_icon_button.dart';


class ReviewPayScreen extends StatefulWidget {
  const ReviewPayScreen({super.key});

  @override
  State<ReviewPayScreen> createState() => _ReviewPayScreenState();
}

class _ReviewPayScreenState extends State<ReviewPayScreen> {
 
  bool _policyExpanded = false;


  final String _boatImage =
      'assets/boat.png';
  final String _boatName = "Sunseeker Manhattan 130'";
  final String _boatLocation =
      'Los roques, Federal Dependencies of Venezuela, VE';
  final String _boatSubInfo = '20 Console Central · Yes ports';
  final String _pricePerDay = '\$20000';

  final String _startDate = '20 May, 2025';
  final String _startTime = '2:00 PM';
  final String _endDate = '21 May, 2025';
  final String _endTime = '1:00 PM';

  final double _dayPrice = 2000;
  final int _tripDays = 1;
  final double _serviceFee = 300;
  final double _securityDeposit = 300;

  double get _total => _dayPrice + _serviceFee + _securityDeposit;

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
                    const SizedBox(height: 8),
                    _buildTopBar(),
                    const SizedBox(height: 4),
                    Text('Review and Pay', style: AppTextStyles.heading),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    BoatSummaryCard(
                      imageUrl: _boatImage,
                      name: _boatName,
                      location: _boatLocation,
                      subInfo: _boatSubInfo,
                      pricePerDay: _pricePerDay,
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    _buildJourneyRow(),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    Text('Reservation Fees', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 10),
                    PriceBreakdownCard(
                      rows: [
                        PriceRowData(
                          '\$${_dayPrice.toStringAsFixed(0)} + $_tripDays day',
                          '\$${(_dayPrice * _tripDays).toStringAsFixed(0)}',
                        ),
                        PriceRowData(
                          'Service Fees',
                          '\$${_serviceFee.toStringAsFixed(0)}',
                        ),
                        PriceRowData(
                          'Security Deposit',
                          '\$${_securityDeposit.toStringAsFixed(0)}',
                        ),
                      ],
                      totalValue: '\$${_total.toStringAsFixed(0)}',
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    _buildCancellationPolicy(),
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

  Widget _buildTopBar() {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.of(context).maybePop(),
          child: Container(
            height: 36,
            width: 36,
            decoration: const BoxDecoration(
              color: AppColors.fieldFill,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, size: 18, color: AppColors.textDark),
          ),
        ),
      ],
    );
  }

  Widget _buildJourneyRow() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _journeyColumn(
                label: 'Start of the journey',
                date: _startDate,
                time: _startTime,
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 22),
            //   child: Icon(Icons.arrow_forward, size: 18, color: AppColors.primaryBlueDark),
            // ),
            Expanded(
              child: _journeyColumn(
                label: 'End of the journey',
                date: _endDate,
                time: _endTime,
              ),
            ),
          ],
        ),
      
      ],
    );
  }

  Widget _journeyColumn({
    required String label,
    required String date,
    required String time,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label.copyWith(color: AppColors.black)),
        const SizedBox(height: 8),
        Text(date, style: AppTextStyles.label.copyWith(color: AppColors.primaryBlueDark)),
        const SizedBox(height: 2),
        Text(time, style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryBlueDark)),
      ],
    );
  }

  Widget _buildCancellationPolicy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _policyExpanded = !_policyExpanded),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cancellation policy', style: AppTextStyles.sectionTitle),
              Row(
                children: [
                  Text('Flexible', style: AppTextStyles.link),
                  Icon(
                    _policyExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.primaryBlueDark,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_policyExpanded) ...[
          const SizedBox(height: 10),
          Text(
            'Full refund if you cancel at least 7 days before the trip starts. '
            'After that, cancellation fees may apply.',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: 14),
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
          CircleIconButton(
            icon: Icons.arrow_forward,
            onTap: () {},
          ),


          CustomButton(
            text: 'Book Now',
            width: 150,
            onPressed: () {
             Get.toNamed(Routes.aboutlicense);
            },
          ),
        ],
      ),
    );
  }
}