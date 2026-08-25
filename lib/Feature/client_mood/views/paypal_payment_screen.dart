import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';

import 'package:navega_app/core/constants/textstyle.dart';
import 'package:navega_app/core/routes/app_routes.dart';
import 'package:navega_app/core/widgets/button/primary_button.dart';


class PaypalPaymentScreen extends StatefulWidget {
  const PaypalPaymentScreen({super.key});

  @override
  State<PaypalPaymentScreen> createState() => _PaypalPaymentScreenState();
}

class _PaypalPaymentScreenState extends State<PaypalPaymentScreen> {
  String _selectedCurrency = 'USD';

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
              InkWell(
                onTap: () => Navigator.of(context).maybePop(),
                child:
                    const Icon(Icons.arrow_back, color: AppColors.textDark),
              ),
              const SizedBox(height: 20),
              Text('Paypal', style: AppTextStyles.heading),
              const SizedBox(height: AppSpacing.sectionSpacing),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Currency', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    Container(
                      height: AppSpacing.fieldHeight,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.fieldFill,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.cardRadius),
                        border: Border.all(color: AppColors.fieldBorder),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCurrency,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: AppColors.textGrey),
                          style: AppTextStyles.label
                              .copyWith(fontWeight: FontWeight.w500),
                          items: const [
                            DropdownMenuItem(
                                value: 'USD', child: Text('\$ USD')),
                            DropdownMenuItem(
                                value: 'EUR', child: Text('€ EUR')),
                            DropdownMenuItem(
                                value: 'GBP', child: Text('£ GBP')),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedCurrency = value);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      "Sign in to PayPal. You'll be able to review your "
                      'order before it becomes final.',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),

              // ---- Cancel / Pay with PayPal ----
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        label: 'Cancel',
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PrimaryButton(
                        label: 'Pay with PayPal',
                       
                        onPressed: () {
               Get.toNamed(Routes.paymentsuccessfull);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}