import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';

import 'package:navega_app/core/constants/textstyle.dart';

class ReservationFeeSummary extends StatelessWidget {
  const ReservationFeeSummary({
    super.key,
    required this.reservationFee,
    required this.extraDays,
    required this.serviceFee,
    required this.securityDeposit,
    required this.total,
    required this.cancellationPolicy,
  });

  final int reservationFee;
  final int extraDays;
  final int serviceFee;
  final int securityDeposit;
  final int total;
  final String cancellationPolicy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Reservation Fess', style: AppTextStyles.sectionTitle),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.fieldFill,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  cancellationPolicy,
                  style: AppTextStyles.link,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _FeeRow(
            label: '\$$reservationFee + $extraDays day',
            value: '\$$reservationFee',
          ),
          const SizedBox(height: 10),
          _FeeRow(label: 'Service Fees', value: '\$$serviceFee'),
          const SizedBox(height: 10),
          _FeeRow(label: 'Security Deposit', value: '\$$securityDeposit'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, color: AppColors.divider),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppTextStyles.sectionTitle),
              Text('\$$total', style: AppTextStyles.priceLarge),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeeRow extends StatelessWidget {
  const _FeeRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodySmall),
        Text(
          value,
          style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}