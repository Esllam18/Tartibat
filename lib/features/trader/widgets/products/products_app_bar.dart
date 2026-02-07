import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class ProductsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAdd;

  const ProductsAppBar({super.key, required this.onAdd});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'my_products'.tr(context),
        style: TextStyle(
          color: Colors.black,
          fontSize: r.fontSize(20),
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add_circle, color: Colors.black, size: 28),
          onPressed: onAdd,
        ),
      ],
    );
  }
}
