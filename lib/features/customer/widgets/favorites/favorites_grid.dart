import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import 'favorite_card.dart';

class FavoritesGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function(int) onRemove;

  const FavoritesGrid({
    super.key,
    required this.items,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return GridView.builder(
      padding: EdgeInsets.all(r.paddingHorizontal),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: r.gridColumns,
        crossAxisSpacing: r.spacing(14),
        mainAxisSpacing: r.spacing(14),
        childAspectRatio:
            r.responsive(mobile: 0.72, tablet: 0.75, desktop: 0.8),
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return FavoriteCard(
          product: items[index],
          onRemove: () => onRemove(index),
        );
      },
    );
  }
}
