import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class ProductsTabs extends StatelessWidget {
  final TabController controller;

  const ProductsTabs({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      color: Colors.white,
      child: TabBar(
        controller: controller,
        indicatorColor: Colors.black,
        indicatorWeight: 3,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black38,
        labelStyle: TextStyle(
          fontSize: r.fontSize(16),
          fontWeight: FontWeight.bold,
        ),
        tabs: [
          Tab(text: 'approved'.tr(context)),
          Tab(text: 'pending'.tr(context)),
        ],
      ),
    );
  }
}
