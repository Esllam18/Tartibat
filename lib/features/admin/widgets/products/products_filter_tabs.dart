import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';

class ProductsFilterTabs extends StatelessWidget {
  final TabController controller;

  const ProductsFilterTabs({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: TabBar(
        controller: controller,
        indicatorColor: AppColors.primary,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        tabs: [
          Tab(text: 'pending'.tr(context)),
          Tab(text: 'approved'.tr(context)),
          Tab(text: 'rejected'.tr(context)),
        ],
      ),
    );
  }
}
