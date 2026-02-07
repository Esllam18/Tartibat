import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class CartEmptyClean extends StatelessWidget {
  const CartEmptyClean({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(r.spacing(32)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: r.responsive(mobile: 120, tablet: 150, desktop: 180),
              height: r.responsive(mobile: 120, tablet: 150, desktop: 180),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: r.responsive(mobile: 60, tablet: 75, desktop: 90),
                color: Colors.black38,
              ),
            ),
            SizedBox(height: r.spacing(24)),
            Text(
              'empty_cart'.tr(context),
              style: TextStyle(
                fontSize: r.fontSize(22),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: r.spacing(12)),
            Text(
              'empty_cart_message'.tr(context),
              style: TextStyle(fontSize: r.fontSize(14), color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
