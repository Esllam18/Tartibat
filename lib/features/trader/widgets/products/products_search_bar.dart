import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class ProductsSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const ProductsSearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.all(r.spacing(16)),
      color: Colors.white,
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: 'search_products'.tr(context),
          prefixIcon: const Icon(Icons.search, color: Colors.black54),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: r.spacing(16),
            vertical: r.spacing(12),
          ),
        ),
      ),
    );
  }
}
