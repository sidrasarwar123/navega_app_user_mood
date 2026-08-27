import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';

class DropdownSelectField extends StatelessWidget {
  final String hintText;
  final String? value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const DropdownSelectField({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
  });

  Future<void> _openPicker(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 1, color: AppColors.divider),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item, style: AppTextStyles.label),
                trailing: item == value
                    ? const Icon(Icons.check, color: AppColors.primaryBlue)
                    : null,
                onTap: () => Navigator.of(context).pop(item),
              );
            },
          ),
        );
      },
    );
    if (selected != null) onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      onTap: () => _openPicker(context),
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
            // Text ko Expanded mein wrap kiya taake yeh overflow na kare
            Expanded(
              child: Text(
                value ?? hintText,
                overflow: TextOverflow.ellipsis, // agar text lamba ho to "..." dikhega
                maxLines: 1,
                style: value == null
                    ? AppTextStyles.fieldHint
                    : AppTextStyles.label.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(width: 6), // icon aur text ke darmiyan thori spacing
            const Icon(
              Icons.chevron_right,
              size: 18,
              color: AppColors.textGrey,
            ),
          ],
        ),
      ),
    );
  }
}