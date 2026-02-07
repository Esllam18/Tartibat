import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int itemCount;
  final VoidCallback? onClearAll;

  const CartAppBar({
    super.key,
    required this.itemCount,
    this.onClearAll,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      title: Text(
        '${'cart'.tr(context)} ($itemCount)',
        style: AppTextStyles.h3(context),
      ),
      centerTitle: true,
      actions: [
        if (onClearAll != null)
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.error),
            onPressed: onClearAll,
          ),
      ],
    );
  }
}
