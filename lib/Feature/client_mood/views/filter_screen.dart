import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';

import 'package:navega_app/core/constants/textstyle.dart';
import 'package:navega_app/core/widgets/button/primary_button.dart';
import 'package:navega_app/core/widgets/button/labeled_toggle.dart';

import 'package:navega_app/core/widgets/toggle/labeled_checkbox.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Selected single date (no range)
  DateTime? _selectedDate;

  // Toggles
  bool _immediateReservation = false;
  bool _yesPets = false;

  // Price range
  double _minPrice = 10;
  double _maxPrice = 250;
  static const double _priceFloor = 10;
  static const double _priceCeiling = 500;

  // Make type
  String _selectedMake = '';
  final List<String> _makeOptions = [
    'Yamaha',
    'Bayliner',
    'Sea Ray',
    'Beneteau',
    'Jeanneau',
  ];

  // Types of boats
  final List<String> _boatTypes = [
    'Consola Central',
    'Convertible',
    'Coup',
    'Crossover',
    'Center Console',
    'Pontoon',
  ];
  final Set<String> _selectedBoatTypes = {'Consola Central'};
  bool _showAllBoatTypes = false;

  // Best features
  final List<String> _bestFeatures = [
    '2 Horas',
    '4 Horas',
    '6 Horas',
    '8 Horas',
    '10 Horas',
    '12 Horas',
  ];
  final Set<String> _selectedFeatures = {'2 Horas'};
  bool _showAllFeatures = false;

  // Boat rules
  final List<String> _boatRules = [
    'Los niños siempre deben estar supervisados por un adulto.',
    'Mantener orden y limpieza en todas las áreas del barco.',
    'No arrojar papeles ni objetos en las pocetas.',
    'No fumar.',
    'No se permiten mascotas sin autorización previa.',
  ];
  final Set<String> _selectedRules = {
    'Los niños siempre deben estar supervisados por un adulto.'
  };
  bool _showAllRules = false;

  static const int _collapsedItemCount = 4;

  List<String> get _visibleBoatTypes => _showAllBoatTypes
      ? _boatTypes
      : _boatTypes.take(_collapsedItemCount).toList();

  List<String> get _visibleFeatures => _showAllFeatures
      ? _bestFeatures
      : _bestFeatures.take(_collapsedItemCount).toList();

  List<String> get _visibleRules =>
      _showAllRules ? _boatRules : _boatRules.take(_collapsedItemCount).toList();

  void _resetFilters() {
    setState(() {
      _selectedDate = null;
      _immediateReservation = false;
      _yesPets = false;
      _minPrice = _priceFloor;
      _maxPrice = 250;
      _selectedMake = '';
      _selectedBoatTypes.clear();
      _selectedFeatures.clear();
      _selectedRules.clear();
      _showAllBoatTypes = false;
      _showAllFeatures = false;
      _showAllRules = false;
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: _selectedDate ?? DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _showMakePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final make in _makeOptions)
                ListTile(
                  title: Text(make, style: AppTextStyles.label),
                  onTap: () {
                    setState(() => _selectedMake = make);
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const Divider(height: 1, color: AppColors.divider),
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.screenPadding.copyWith(
                  top: AppSpacing.sectionSpacing,
                  bottom: AppSpacing.sectionSpacing,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSelectDatesField(),
                    SizedBox(height: AppSpacing.sectionSpacing),

                    LabeledToggle(
                      label: 'Immediate Reservation',
                      value: _immediateReservation,
                      onChanged: (v) =>
                          setState(() => _immediateReservation = v),
                    ),
                    const SizedBox(height: 18),
                    LabeledToggle(
                      label: 'Yes pets',
                      value: _yesPets,
                      onChanged: (v) => setState(() => _yesPets = v),
                    ),
                    SizedBox(height: AppSpacing.sectionSpacing),

                    Text('Price Range', style: AppTextStyles.label),
                    _buildPriceRangeSlider(),
                    SizedBox(height: AppSpacing.sectionSpacing),

                    Text('Make Type', style: AppTextStyles.label),
                    const SizedBox(height: 10),
                    _buildMakeTypeField(),
                    SizedBox(height: AppSpacing.sectionSpacing),

                    Text('Types of boats', style: AppTextStyles.label),
                    const SizedBox(height: 6),
                    Column(
                      children: [
                        for (int i = 0; i < _visibleBoatTypes.length; i++)
                          LabeledCheckbox(
                            label: _visibleBoatTypes[i],
                            value: _selectedBoatTypes
                                .contains(_visibleBoatTypes[i]),
                            onChanged: (_) => setState(() {
                              final type = _visibleBoatTypes[i];
                              _selectedBoatTypes.contains(type)
                                  ? _selectedBoatTypes.remove(type)
                                  : _selectedBoatTypes.add(type);
                            }),
                            showDot: i == 0,
                          ),
                      ],
                    ),
                    _buildShowMoreLink(
                      isExpanded: _showAllBoatTypes,
                      onTap: () =>
                          setState(() => _showAllBoatTypes = !_showAllBoatTypes),
                    ),
                    SizedBox(height: AppSpacing.sectionSpacing),

                    Text('Best Features', style: AppTextStyles.label),
                    const SizedBox(height: 6),
                    Column(
                      children: [
                        for (final feature in _visibleFeatures)
                          LabeledCheckbox(
                            label: feature,
                            value: _selectedFeatures.contains(feature),
                            onChanged: (_) => setState(() {
                              _selectedFeatures.contains(feature)
                                  ? _selectedFeatures.remove(feature)
                                  : _selectedFeatures.add(feature);
                            }),
                          ),
                      ],
                    ),
                    _buildShowMoreLink(
                      isExpanded: _showAllFeatures,
                      onTap: () =>
                          setState(() => _showAllFeatures = !_showAllFeatures),
                    ),
                    SizedBox(height: AppSpacing.sectionSpacing),

                    Text('Boat Rules', style: AppTextStyles.label),
                    const SizedBox(height: 6),
                    Column(
                      children: [
                        for (final rule in _visibleRules)
                          LabeledCheckbox(
                            label: rule,
                            value: _selectedRules.contains(rule),
                            onChanged: (_) => setState(() {
                              _selectedRules.contains(rule)
                                  ? _selectedRules.remove(rule)
                                  : _selectedRules.add(rule);
                            }),
                          ),
                      ],
                    ),
                    _buildShowMoreLink(
                      isExpanded: _showAllRules,
                      onTap: () =>
                          setState(() => _showAllRules = !_showAllRules),
                    ),
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

  Widget _buildHeader() {
    return Padding(
      padding: AppSpacing.screenPadding.copyWith(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: AppColors.textDark),
          ),
          TextButton(
            onPressed: _resetFilters,
            child: Text('Delete all', style: AppTextStyles.link),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectDatesField() {
    final text = _selectedDate == null
        ? 'Select Date'
        : _formatDate(_selectedDate!);

    return InkWell(
      onTap: _pickDate,
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius * 3),
      child: Container(
        height: AppSpacing.fieldHeight + 8,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius * 3),
          border: Border.all(color: AppColors.fieldBorder),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_rounded,
                size: 18, color: AppColors.textDark),
            const SizedBox(width: 10),
            Expanded(child: Text(text, style: AppTextStyles.label)),
            const Icon(Icons.arrow_forward_rounded,
                size: 18, color: AppColors.textDark),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRangeSlider() {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.primaryBlue,
            inactiveTrackColor: AppColors.fieldBorder,
            thumbColor: AppColors.primaryBlue,
            overlayColor: AppColors.primaryBlue.withOpacity(0.15),
            rangeThumbShape:
                const RoundRangeSliderThumbShape(enabledThumbRadius: 9),
            trackHeight: 3,
          ),
          child: RangeSlider(
            min: _priceFloor,
            max: _priceCeiling,
            values: RangeValues(_minPrice, _maxPrice),
            onChanged: (values) => setState(() {
              _minPrice = values.start;
              _maxPrice = values.end;
            }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _priceChip('\$${_minPrice.round()}'),
            _priceChip('\$${_maxPrice.round()}'),
          ],
        ),
      ],
    );
  }

  Widget _priceChip(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        value,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMakeTypeField() {
    return InkWell(
      onTap: _showMakePicker,
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: Container(
        height: AppSpacing.fieldHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.fieldFill,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: AppColors.fieldBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedMake.isEmpty ? 'Choose the make' : _selectedMake,
              style: _selectedMake.isEmpty
                  ? AppTextStyles.fieldHint
                  : AppTextStyles.label,
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }

  Widget _buildShowMoreLink({
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isExpanded ? 'Show less' : 'Show more',
                style: AppTextStyles.link),
            const SizedBox(width: 4),
            Icon(
              isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: AppSpacing.screenPadding.copyWith(top: 12, bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
       child: PrimaryButton(
          label: 'See Results',
          trailingIcon: Icons.arrow_forward,
          onPressed: () {
            // Handle filter application logic here
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}';
}