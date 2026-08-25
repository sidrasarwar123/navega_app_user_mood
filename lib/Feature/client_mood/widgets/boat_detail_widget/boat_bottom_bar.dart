import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';


/// Fixed bottom bar showing the current price and a Book Now button.
class BoatBottomBar extends StatelessWidget {
  final double price;
  final String priceUnitLabel;
  final VoidCallback onBookNow;

  const BoatBottomBar({
    super.key,
    required this.price,
    required this.priceUnitLabel,
    required this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.screenHorizontal,
        right: AppSpacing.screenHorizontal,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$${price.toStringAsFixed(0)}',
                style: AppTextStyles.priceLarge.copyWith(fontSize: 20),
              ),
              Text(priceUnitLabel, style: AppTextStyles.priceUnit),
              Text('Travel Date', style: AppTextStyles.priceUnit.copyWith(color: AppColors.primaryBlueDark)),
            ],
          ),
          const Spacer(),
          SizedBox(
            height: AppSpacing.buttonHeight,
            width: 160,
            child: ElevatedButton(
              onPressed: onBookNow,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                ),
              ),
              child: Text('Book Now', style: AppTextStyles.button),
            ),
          ),
        ],
      ),
    );
  }
}