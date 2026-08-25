import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:navega_app/Feature/client_mood/widgets/button/custom_button.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';

import 'package:navega_app/core/constants/textstyle.dart';
import 'package:navega_app/core/routes/app_routes.dart';

import 'package:navega_app/core/widgets/fields/custom_textfield.dart';
import 'package:navega_app/core/widgets/fields/dropdown_field.dart';
import 'package:navega_app/core/widgets/fields/picker_field.dart';


class AboutLicenseScreen extends StatefulWidget {
  const AboutLicenseScreen({super.key});

  @override
  State<AboutLicenseScreen> createState() => _AboutLicenseScreenState();
}

class _AboutLicenseScreenState extends State<AboutLicenseScreen> {
  // ---- local UI state (no controller / no GetX) ----
  final _licenseController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();

  String? _selectedMonth;
  String? _selectedDate;
  String? _selectedYear;
  String? _selectedCountry;

  final String _pricePerDay = '\$20000';
  final int _tripDays = 1;

   String? _month;
  String? _date;
  String? _year;

  bool _agreedToTerms = false;
  bool _isLoading = false;

  static const _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  static final _dates = List.generate(31, (i) => '${i + 1}');
  static final _years = List.generate(
    80,
    (i) => '${DateTime.now().year - i}',
  );
  
  static const List<String> _countries = [
    'Pakistan', 'United States', 'United Kingdom', 'United Arab Emirates',
    'Venezuela', 'Spain', 'France', 'Italy', 'Germany', 'Canada',
    'Australia', 'India', 'Saudi Arabia', 'Turkey', 'Portugal',
  ];

  @override
  void dispose() {
    _licenseController.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _openListPicker({
    required String title,
    required List<String> options,
    required ValueChanged<String> onSelected,
    bool searchable = false,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        List<String> filtered = options;
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(title, style: AppTextStyles.sectionTitle),
                    ),
                    if (searchable) ...[
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextField(
                          hintText: 'Search country',
                          onChanged: (query) {
                            setSheetState(() {
                              filtered = options
                                  .where((c) => c
                                      .toLowerCase()
                                      .contains(query.toLowerCase()))
                                  .toList();
                            });
                          },
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final item = filtered[index];
                          return ListTile(
                            title: Text(item, style: AppTextStyles.label),
                            onTap: () {
                              onSelected(item);
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildBackButton(),
                    const SizedBox(height: 20),

                    Text('1. About Your License', style: AppTextStyles.heading),
                    const SizedBox(height: 8),
                    Text(
                      "It's just a step away, inform your boat owner of your ID.",
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    Text('License Number', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 8),
                    CustomTextField(hintText: "License number",
                    controller:_licenseController, 
                    
                    ),
                    // CustomTextField(
                    //   controller: _licenseController,
                    //   hint: 'License number',
                    // ),
                    const SizedBox(height: 18),

                    Text('Name', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 8),
                    CustomTextField(hintText: "Name",
                    controller: _nameController,
                    ),
                    // CustomTextField(
                    //   controller: _nameController,
                    //   hint: 'Name',
                    // ),
                    const SizedBox(height: 18),

                    Text('Last Name', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 8),
                   CustomTextField(hintText: "Last Name",
                    controller: _lastNameController,
                    ),
                    SizedBox(height: 20,),
                     const Text('Birthday', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownSelectField(
                            hintText: 'Month',
                            items: _months,
                            value: _month,
                            onChanged: (v) => setState(() => _month = v),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownSelectField(
                            hintText: 'Date',
                            items: _dates,
                            value: _date,
                            onChanged: (v) => setState(() => _date = v),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownSelectField(
                            hintText: 'Year',
                            items: _years,
                            value: _year,
                            onChanged: (v) => setState(() => _year = v),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    Text('Country', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 8),
                    PickerField(
                      hint: 'Choose Country',
                      value: _selectedCountry,
                      showArrow: false,
                      onTap: () => _openListPicker(
                        title: 'Choose Country',
                        options: _countries,
                        searchable: true,
                        onSelected: (v) =>
                            setState(() => _selectedCountry = v),
                      ),
                    ),
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

  Widget _buildBackButton() {
    return InkWell(
      onTap: () => Navigator.of(context).maybePop(),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.fieldBorder),
        ),
        child: const Icon(Icons.arrow_back, size: 18, color: AppColors.textDark),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: 14,
      ),
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
          CustomButton(
            text: 'Following',
            icon: Icons.arrow_forward,
            width: 150,
            onPressed: () {
             Get.toNamed(Routes.aboutTrip);
            },
          ),
        ],
      ),
    );
  }
}