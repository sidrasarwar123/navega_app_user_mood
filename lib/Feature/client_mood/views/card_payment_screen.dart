import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:navega_app/Feature/client_mood/widgets/payment_widget/Card_brand_row.dart';
import 'package:navega_app/Feature/client_mood/widgets/payment_widget/Payment_text_field.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';
import 'package:navega_app/core/routes/app_routes.dart';
import 'package:navega_app/core/widgets/button/primary_button.dart';
class CardPaymentScreen extends StatefulWidget {
  const CardPaymentScreen({super.key, this.isMegasoft = false});

  final bool isMegasoft;

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _zipOrIdController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _zipOrIdController.dispose();
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
              InkWell(
                onTap: () => Navigator.of(context).maybePop(),
                child:
                    const Icon(Icons.arrow_back, color: AppColors.textDark),
              ),
              const SizedBox(height: 20),
              Text(
                widget.isMegasoft ? 'Megasoft' : 'Debit / Credit Card',
                style: AppTextStyles.heading,
              ),
              const SizedBox(height: AppSpacing.sectionSpacing),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PaymentTextField(
                        label: 'Card number',
                        controller: _cardNumberController,
                        hintText: '4242  4243  4455  7665554',
                        trailingBadge: 'Autofill box',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 8),
                      const CardBrandRow(),
                      const SizedBox(height: 18),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: PaymentTextField(
                              label: 'Expiration',
                              controller: _expiryController,
                              hintText: 'MM/YY',
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: PaymentTextField(
                              label: 'CVV',
                              controller: _cvvController,
                              hintText: '---',
                              obscureText: true,
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: PaymentTextField(
                              label:
                                  widget.isMegasoft ? 'National ID' : 'Zip code',
                              controller: _zipOrIdController,
                              hintText: widget.isMegasoft
                                  ? 'National ID'
                                  : 'Zip code',
                              keyboardType: widget.isMegasoft
                                  ? TextInputType.text
                                  : TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

     
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
                        label: 'Pay Now',
                        // icon: Icons.arrow_forward,
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