import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';

import 'package:navega_app/core/constants/textstyle.dart';

class TimeDropdownField extends StatefulWidget {
  final String hint;
  final String? selectedTime;
  final List<String> timeSlots;
  final ValueChanged<String> onSelected;

  const TimeDropdownField({
    super.key,
    required this.hint,
    required this.selectedTime,
    required this.timeSlots,
    required this.onSelected,
  });

  @override
  State<TimeDropdownField> createState() => _TimeDropdownFieldState();
}

class _TimeDropdownFieldState extends State<TimeDropdownField> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _buildOverlay();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _isOpen = false);
  }

  OverlayEntry _buildOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // tap outside to close
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeDropdown,
            ),
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 6),
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              child: Container(
                width: size.width,
                constraints: const BoxConstraints(maxHeight: 260),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  border: Border.all(color: AppColors.fieldBorder),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: widget.timeSlots.length,
                  itemBuilder: (context, index) {
                    final time = widget.timeSlots[index];
                    final isSelected =
                        time == (widget.selectedTime ?? widget.timeSlots.first);
                    return InkWell(
                      onTap: () {
                        widget.onSelected(time);
                        _closeDropdown();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        color: isSelected
                            ? AppColors.primaryBlueDark
                            : AppColors.white,
                        child: Text(
                          time,
                          style: AppTextStyles.fieldHint.copyWith(
                            color:
                                isSelected ? AppColors.white : AppColors.textDark,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          height: AppSpacing.fieldHeight,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.fieldFill,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(color: AppColors.fieldBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.selectedTime ?? widget.hint,
                style: widget.selectedTime != null
                    ? AppTextStyles.label
                    : AppTextStyles.fieldHint,
              ),
              Icon(
                _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: AppColors.textGrey,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}