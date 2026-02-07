import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';
import 'category_picker.dart';

class ProductFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController name,
      price,
      category,
      stock,
      location,
      description;
  const ProductFields(
      {super.key,
      required this.formKey,
      required this.name,
      required this.price,
      required this.category,
      required this.stock,
      required this.location,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          boxShadow: const [
            BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 15,
                offset: Offset(0, 4))
          ]),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.inventory_2_outlined,
                      color: AppColors.primary, size: 22)),
              const SizedBox(width: 12),
              Text('product_info'.tr(context), style: AppTextStyles.h4(context))
            ]),
            const SizedBox(height: 16),
            _Field(
                label: 'product_name'.tr(context),
                icon: Icons.text_fields,
                controller: name),
            const SizedBox(height: 12),
            _Field(
                label: 'price'.tr(context),
                icon: Icons.payments_outlined,
                controller: price,
                type: TextInputType.number),
            const SizedBox(height: 12),
            CategoryPicker(controller: category),
            const SizedBox(height: 12),
            _Field(
                label: 'stock'.tr(context),
                icon: Icons.numbers_outlined,
                controller: stock,
                type: TextInputType.number),
            const SizedBox(height: 12),
            _Field(
                label: 'made_in_or_location'.tr(context),
                icon: Icons.location_on_outlined,
                controller: location,
                required: false),
            const SizedBox(height: 12),
            TextField(
                controller: description,
                maxLines: 3,
                decoration: InputDecoration(
                    hintText: 'description'.tr(context),
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none))),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? type;
  final bool required;
  const _Field(
      {required this.label,
      required this.icon,
      required this.controller,
      this.type,
      this.required = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: required
          ? (v) => (v == null || v.trim().isEmpty)
              ? 'required_field'.tr(context)
              : null
          : null,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.primary),
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none)),
    );
  }
}
