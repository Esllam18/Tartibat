import 'package:flutter/material.dart';
import 'package:tartibat/core/localization/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import 'cart_item_card.dart';

class CartList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function(int) onRemove;
  final Function(int, int) onQuantityChanged;

  const CartList({
    super.key,
    required this.items,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return ListView.builder(
      padding: EdgeInsets.all(r.paddingHorizontal),
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key('${items[index]['name']}_$index'),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => onRemove(index),
          background: Container(
            margin: EdgeInsets.only(bottom: r.spacing(16)),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.error, Color(0xFFE57373)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: r.spacing(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: r.responsive(mobile: 28, tablet: 32, desktop: 36),
                ),
                SizedBox(width: r.spacing(8)),
                Text(
                  'delete'.tr(context),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          child: CartItemCard(
            item: items[index],
            onQuantityChanged: (newQuantity) =>
                onQuantityChanged(index, newQuantity),
          ),
        );
      },
    );
  }
}
