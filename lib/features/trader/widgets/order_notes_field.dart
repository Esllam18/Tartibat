import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class OrderNotesField extends StatelessWidget {
  final TextEditingController controller;
  const OrderNotesField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          boxShadow: const [
            BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 15,
                offset: Offset(0, 4))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.note_outlined,
                    color: AppColors.primary, size: 22)),
            const SizedBox(width: 12),
            Text('notes'.tr(context), style: AppTextStyles.h4(context))
          ]),
          const SizedBox(height: 14),
          TextField(
              controller: controller,
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: 'add_notes_here'.tr(context),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none))),
        ],
      ),
    );
  }
}
