import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';
import 'package:navega_app/core/routes/app_routes.dart';
import 'package:navega_app/core/widgets/button/primary_button.dart';
import 'package:navega_app/core/widgets/fields/data_field.dart';
import 'package:navega_app/core/widgets/fields/time_dropdown_field.dart';


class TravelDates extends StatefulWidget {
  const TravelDates({super.key});

  @override
  State<TravelDates> createState() => _TravelDatesState();
}

class _TravelDatesState extends State<TravelDates> {
  // ---- local UI state (no controller / no GetX) ----
  DateTime? _startDate;
  DateTime? _endDate;
  String? _startTime;
  String? _endTime;

  static const int maxTripDays = 1;

  final List<String> _timeSlots = const [
    '8:00 AM',
    '8:30 AM',
    '9:00 AM',
    '9:30 AM',
    '10:00 AM',
    '10:30 AM',
  ];

  final double _pricePerDay = 2000;
  final double _serviceFee = 300;
  final double _securityDeposit = 300;

  int get _tripDays {
    if (_startDate == null || _endDate == null) return 1;
    final diff = _endDate!.difference(_startDate!).inDays;
    if (diff < 1) return 1;
    return diff > maxTripDays ? maxTripDays : diff;
  }

  double get _subTotal => _pricePerDay * _tripDays;

  double get _total => _subTotal + _serviceFee + _securityDeposit;

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        _endDate = picked.add(const Duration(days: maxTripDays));
      });
    }
  }

  Future<void> _pickEndDate() async {
    final base = _startDate ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? base,
      firstDate: base,
      lastDate: base.add(const Duration(days: maxTripDays)),
    );
    if (picked != null) {
      setState(() => _endDate = picked);
    }
  }

  void _deleteAll() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _startTime = null;
      _endTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildTopBar(),
              const SizedBox(height: 4),
              Text('Book Now', style: AppTextStyles.heading),
              const SizedBox(height: AppSpacing.sectionSpacing),

              Text('Travel Dates', style: AppTextStyles.sectionTitle),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DateField(
                      hint: 'Start Date',
                      date: _startDate,
                      onTap: _pickStartDate,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DateField(
                      hint: 'End Date',
                      date: _endDate,
                      onTap: _pickEndDate,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sectionSpacing),

              Text('Travel Time', style: AppTextStyles.sectionTitle),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TimeDropdownField(
                      hint: 'Start Time',
                      selectedTime: _startTime,
                      timeSlots: _timeSlots,
                      onSelected: (time) => setState(() => _startTime = time),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TimeDropdownField(
                      hint: 'End Time',
                      selectedTime: _endTime,
                      timeSlots: _timeSlots,
                      onSelected: (time) => setState(() => _endTime = time),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'You can selected maximum 1 day trip',
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: AppSpacing.sectionSpacing),

              _buildPriceCard(),

              const Spacer(),
           
           PrimaryButton(label: "Book Now", onPressed:  (){
           Get.toNamed(Routes.reviewPay);
            }
           ),
          
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'You will not charged yet',
                  style: AppTextStyles.bodySmall,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).maybePop(),
          child: Container(
            height: 36,
            width: 36,
            decoration: const BoxDecoration(
              color: AppColors.fieldFill,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, size: 18, color: AppColors.textDark),
          ),
        ),
        TextButton(
          onPressed: _deleteAll,
          child: Text('Delete all', style: AppTextStyles.link),
        ),
      ],
    );
  }

  Widget _buildPriceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: Column(
        children: [
          _priceRow(
            '\$${_pricePerDay.toStringAsFixed(0)} + $_tripDays day',
            '\$${_subTotal.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 10),
          _priceRow('Service Fees', '\$${_serviceFee.toStringAsFixed(0)}'),
          const SizedBox(height: 10),
          _priceRow(
            'Security Deposit',
            '\$${_securityDeposit.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 14),
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppTextStyles.sectionTitle),
              Text(
                '\$${_total.toStringAsFixed(0)}',
                style: AppTextStyles.priceLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.fieldHint.copyWith(color: AppColors.black)),
        Text(value, style: AppTextStyles.label),
      ],
    );
  }
}