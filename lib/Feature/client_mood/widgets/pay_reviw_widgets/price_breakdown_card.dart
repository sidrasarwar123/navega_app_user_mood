import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';

import 'package:navega_app/core/constants/textstyle.dart';

class PriceRowData {
  final String label;
  final String value;
  const PriceRowData(this.label, this.value);
}

class PriceBreakdownCard extends StatelessWidget {
  final List<PriceRowData> rows;
  final String totalLabel;
  final String totalValue;

  const PriceBreakdownCard({
    super.key,
    required this.rows,
    this.totalLabel = 'Total',
    required this.totalValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
      
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++) ...[
            _row(rows[i].label, rows[i].value),
            if (i != rows.length - 1) const SizedBox(height: 10),
          ],
          const SizedBox(height: 14),
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(totalLabel, style: AppTextStyles.sectionTitle),
              Text(totalValue, style: AppTextStyles.priceLarge),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.fieldHint.copyWith(color: AppColors.black)),
        Text(value, style: AppTextStyles.label),
      ],
    );
  }
}