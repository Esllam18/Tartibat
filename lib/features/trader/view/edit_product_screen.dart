import 'package:flutter/material.dart';
import 'package:tartibat/features/trader/widgets/product_form.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class EditProductScreen extends StatelessWidget {
  final Map<dynamic, dynamic> product;
  const EditProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title:
            Text('edit_product'.tr(context), style: AppTextStyles.h3(context)),
        centerTitle: true,
      ),
      body: ProductForm(initialData: product, isEdit: true),
    );
  }
}
