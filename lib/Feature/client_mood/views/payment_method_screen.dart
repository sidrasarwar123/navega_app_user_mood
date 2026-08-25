import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/route_manager.dart';
import 'package:navega_app/Feature/client_mood/views/card_payment_screen.dart';
import 'package:navega_app/Feature/client_mood/views/paypal_payment_screen.dart';
import 'package:navega_app/Feature/client_mood/widgets/payment_widget/Payment_mothed_tile.dart';
import 'package:navega_app/Feature/client_mood/widgets/payment_widget/Reservation_fee_summary.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';

import 'package:navega_app/core/widgets/button/primary_button.dart';


enum PaymentMethod { debitCredit, paypal, megasoft }

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  // ---- Local UI-only state (no controller/binding) ----
  PaymentMethod _selectedMethod = PaymentMethod.debitCredit;

  // ---- Static/dummy fee data (matches design) ----
  final int reservationFee = 2000;
  final int extraDays = 1;
  final int serviceFee = 300;
  final int securityDeposit = 300;
  final int total = 23000;
  final String cancellationPolicy = 'Flexible';

 void _proceedToPay() {
  if (_selectedMethod == PaymentMethod.paypal) {
    Get.to(() => const PaypalPaymentScreen());
  } else {
    Get.to(
      () => CardPaymentScreen(
        isMegasoft: _selectedMethod == PaymentMethod.megasoft,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                    InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: const Icon(Icons.arrow_back,
                          color: AppColors.textDark),
                    ),
                    const SizedBox(height: 20),
                    Text('4. Payment', style: AppTextStyles.heading),
                    const SizedBox(height: 6),
                    Text(
                      'Choose your preferred payment method.',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    // ---- Payment method options ----
                    PaymentMethodTile(
                      icon: Icons.credit_card,
                      title: 'Debit / Credit Card',
                      isSelected: _selectedMethod == PaymentMethod.debitCredit,
                      onTap: () => setState(
                          () => _selectedMethod = PaymentMethod.debitCredit),
                    ),
                    PaymentMethodTile(
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'Paypal',
                      iconBackgroundColor: const Color(0xFFE7F0FD),
                      iconColor: const Color(0xFF1E3A8A),
                      isSelected: _selectedMethod == PaymentMethod.paypal,
                      onTap: () =>
                          setState(() => _selectedMethod = PaymentMethod.paypal),
                    ),
                    PaymentMethodTile(
                      icon: Icons.shield_outlined,
                      title: 'Megasoft',
                      iconBackgroundColor: const Color(0xFFE7F0FD),
                      iconColor: const Color(0xFF1E3A8A),
                      isSelected: _selectedMethod == PaymentMethod.megasoft,
                      onTap: () => setState(
                          () => _selectedMethod = PaymentMethod.megasoft),
                    ),

                    const SizedBox(height: AppSpacing.sectionSpacing),

                    // ---- Fee breakdown ----
                    ReservationFeeSummary(
                      reservationFee: reservationFee,
                      extraDays: extraDays,
                      serviceFee: serviceFee,
                      securityDeposit: securityDeposit,
                      total: total,
                      cancellationPolicy: cancellationPolicy,
                    ),

                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cancellation policy', style: AppTextStyles.label),
                        const Icon(Icons.chevron_right,
                            color: AppColors.textGrey, size: 20),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // ---- Bottom fixed CTA ----
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(AppSpacing.screenHorizontal,
                  12, AppSpacing.screenHorizontal, 16),
              decoration: const BoxDecoration(
                color: AppColors.background,
                border: Border(top: BorderSide(color: AppColors.divider)),
              ),
              child: PrimaryButton(
                label: 'Proceed to Pay',
                // icon: Icons.arrow_forward,
                onPressed: _proceedToPay,
               
              ),
            ),
          ],
        ),
      ),
    );
  }
}