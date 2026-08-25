// boat_specs_grid.dart

import 'package:flutter/material.dart';

import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';
import '../../models/boat_detail_model.dart';

class BoatSpecsGrid extends StatelessWidget {
  final BoatDetailModel boat;

  const BoatSpecsGrid({super.key, required this.boat});

  @override
  Widget build(BuildContext context) {
    final items = [
      _SpecData(icon: Icons.directions_boat_filled, label: 'Boat Type', value: boat.boatType),
      _SpecData(icon: Icons.settings, label: 'Make', value: boat.make),
      _SpecData(icon: Icons.auto_awesome, label: 'Model', value: boat.model),
      _SpecData(icon: Icons.calendar_today, label: 'Year', value: boat.year.toString()),
      _SpecData(icon: Icons.pets, label: 'Pets', value: boat.hasPets ? 'Yes pets' : 'No pets'),
      _SpecData(icon: Icons.groups, label: 'Ability', value: '${boat.capacity} Pers'),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) => _BoatSpecItem(data: items[index]),
    );
  }
}

class _SpecData {
  final IconData icon;
  final String label;
  final String value;

  const _SpecData({required this.icon, required this.label, required this.value});
}

class _BoatSpecItem extends StatelessWidget {
  final _SpecData data;

  const _BoatSpecItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
            child: Icon(data.icon, size: 20, color: AppColors.textDark),
          ),
          const SizedBox(height: 6),
          Text(
            data.label,
            style: AppTextStyles.label.copyWith(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            data.value,
            style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}