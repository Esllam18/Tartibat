import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../data/models/category_model.dart';

class HomeCategories extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const HomeCategories({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return SizedBox(
      height: r.responsive(mobile: 100, tablet: 110, desktop: 120),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: r.spacing(16)),
        physics: const BouncingScrollPhysics(),
        itemCount: mainCategories.length,
        itemBuilder: (context, index) {
          final category = mainCategories[index];
          final isSelected = selectedCategory == category.id;

          return GestureDetector(
            onTap: () => onCategorySelected(category.id),
            child: Container(
              width: r.responsive(mobile: 75, tablet: 85, desktop: 95),
              margin: EdgeInsets.only(right: r.spacing(10)),
              padding: EdgeInsets.symmetric(
                horizontal: r.spacing(8),
                vertical: r.spacing(12),
              ),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          category.color,
                          category.color.withOpacity(0.7)
                        ],
                      )
                    : null,
                color: isSelected ? null : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? category.color : Colors.grey.shade200,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? category.color.withOpacity(0.25)
                        : Colors.black.withOpacity(0.04),
                    blurRadius: isSelected ? 10 : 6,
                    offset: Offset(0, isSelected ? 4 : 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    category.icon,
                    size: r.responsive(mobile: 26, tablet: 30, desktop: 34),
                    color: isSelected ? Colors.white : category.color,
                  ),
                  SizedBox(height: r.spacing(6)),
                  Text(
                    category.nameKey.tr(context),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(11),
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : Colors.grey.shade800,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
