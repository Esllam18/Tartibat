import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class OrdersAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OrdersAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'my_orders'.tr(context),
        style: TextStyle(
          color: Colors.black,
          fontSize: r.fontSize(20),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
