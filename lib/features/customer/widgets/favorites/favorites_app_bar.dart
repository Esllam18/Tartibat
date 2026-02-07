import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';

class FavoritesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int itemCount;
  final VoidCallback? onClearAll;

  const FavoritesAppBar({
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
        '${'favorites'.tr(context)} ($itemCount)',
        style: AppTextStyles.h3(context),
      ),
      centerTitle: true,
      actions: [
        if (onClearAll != null)
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.error),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Text('clear_favorites'.tr(context)),
                  content: Text('clear_favorites_confirm'.tr(context)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('cancel'.tr(context)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onClearAll!();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('confirm'.tr(context)),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
