import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';

class CardBrandRow extends StatelessWidget {
  const CardBrandRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _BrandChip(label: 'VISA', color: Color(0xFF1A1F71)),
        SizedBox(width: 8),
        _BrandChip(label: 'MC', color: Color(0xFFEB001B)),
        SizedBox(width: 8),
        _BrandChip(label: 'AMEX', color: Color(0xFF2E77BC)),
        SizedBox(width: 8),
        _BrandChip(label: 'DISC', color: Color(0xFFF76B1C)),
      ],
    );
  }
}

class _BrandChip extends StatelessWidget {
  const _BrandChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}