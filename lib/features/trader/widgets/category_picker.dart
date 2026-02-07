import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class CategoryPicker extends StatelessWidget {
  final TextEditingController controller;
  const CategoryPicker({super.key, required this.controller});

  static const _categories = [
    'all',
    'sofas',
    'chairs',
    'tables',
    'beds',
    'storage',
    'desks',
    'cabinets',
    'lighting',
    'carpets',
    'curtains',
    'shelves',
    'outdoor',
    'kids',
    'office',
    'kitchen',
    'bathroom',
    'decor',
    'antique'
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPicker(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          validator: (v) =>
              (v == null || v.isEmpty) ? 'required_field'.tr(context) : null,
          decoration: InputDecoration(
              labelText: 'category'.tr(context),
              prefixIcon:
                  const Icon(Icons.category_outlined, color: AppColors.primary),
              suffixIcon:
                  const Icon(Icons.arrow_drop_down, color: AppColors.primary),
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (c) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: AppColors.textSecondary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2))),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Text('select_category'.tr(context),
                    style: AppTextStyles.h3(context))),
            Expanded(
                child: ListView(children: [
              ..._categories.map((cat) => ListTile(
                  title: Text('categories_$cat'.tr(context)),
                  onTap: () {
                    controller.text = 'categories_$cat'.tr(context);
                    Navigator.pop(c);
                  })),
              const Divider(),
              ListTile(
                  leading:
                      const Icon(Icons.add_circle, color: AppColors.primary),
                  title: Text('add_new_category'.tr(context)),
                  onTap: () {
                    Navigator.pop(c);
                    _showAddDialog(context);
                  })
            ])),
          ],
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(children: [
          Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle),
              child: const Icon(Icons.add, color: AppColors.primary, size: 20)),
          const SizedBox(width: 12),
          Text('add_new_category'.tr(context))
        ]),
        content: TextField(
            controller: ctrl,
            autofocus: true,
            decoration: InputDecoration(
                hintText: 'category_name'.tr(context),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none))),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(c),
              child: Text('cancel'.tr(context))),
          ElevatedButton(
              onPressed: () {
                if (ctrl.text.trim().isEmpty) return;
                controller.text = ctrl.text;
                Navigator.pop(c);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('category_added'.tr(context)),
                    backgroundColor: AppColors.success));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: Text('add'.tr(context)))
        ],
      ),
    );
  }
}
