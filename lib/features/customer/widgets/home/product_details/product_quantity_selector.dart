import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../core/localization/app_localizations.dart';

class ProductQuantitySelector extends StatelessWidget {
  final int quantity;
  final Function(int) onQuantityChanged;

  const ProductQuantitySelector({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.all(r.spacing(18)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'quantity'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(17),
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                _buildButton(context, r, Icons.remove, () {
                  if (quantity > 1) onQuantityChanged(quantity - 1);
                }),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: r.spacing(20)),
                  child: Text(
                    '$quantity',
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(20),
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                _buildButton(context, r, Icons.add,
                    () => onQuantityChanged(quantity + 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, Responsive r, IconData icon,
      VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: AppColors.primary),
      iconSize: r.responsive(mobile: 24, tablet: 28, desktop: 32),
      onPressed: onPressed,
    );
  }
}
