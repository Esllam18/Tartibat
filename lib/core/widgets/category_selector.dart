import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/categories.dart';
import '../localization/app_localizations.dart';

class CategorySelector extends StatefulWidget {
  final String? initialCategory;
  final Function(String) onCategorySelected;

  const CategorySelector({
    super.key,
    this.initialCategory,
    required this.onCategorySelected,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  String? _selectedCategory;
  bool _showCustomInput = false;
  final TextEditingController _customController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      _selectedCategory = widget.initialCategory;
      // Check if it's a custom category (not in predefined list)
      final isArabic = false; // You'll get this from context
      final predefinedCategories =
          AppCategories.getCategoriesInLanguage(isArabic);
      if (!predefinedCategories.contains(widget.initialCategory)) {
        _showCustomInput = true;
        _customController.text = widget.initialCategory!;
      }
    }
  }

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final categories = AppCategories.getCategoriesInLanguage(isArabic);
    final otherText = isArabic ? 'أخرى' : 'Other';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Dropdown
        DropdownButtonFormField<String>(
          value: _showCustomInput ? otherText : _selectedCategory,
          decoration: InputDecoration(
            labelText: 'category'.tr(context),
            labelStyle: GoogleFonts.cairo(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            prefixIcon:
                const Icon(Icons.category_outlined, color: AppColors.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          items: categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Row(
                children: [
                  Icon(
                    _getCategoryIcon(category, isArabic),
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    category,
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      fontWeight: category == otherText
                          ? FontWeight.w800
                          : FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              if (newValue == otherText) {
                _showCustomInput = true;
                _selectedCategory = null;
              } else {
                _showCustomInput = false;
                _selectedCategory = newValue;
                // Store in English for consistency
                final englishName = AppCategories.getEnglishName(newValue!);
                widget.onCategorySelected(englishName);
              }
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'please_select_category'.tr(context);
            }
            if (value == otherText && _customController.text.isEmpty) {
              return 'please_enter_custom_category'.tr(context);
            }
            return null;
          },
          style: GoogleFonts.cairo(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
          dropdownColor: Colors.white,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
        ),

        // Custom Category Input (shown when "Other" is selected)
        if (_showCustomInput) ...[
          const SizedBox(height: 16),
          TextFormField(
            controller: _customController,
            onChanged: (value) {
              widget.onCategorySelected(value);
            },
            decoration: InputDecoration(
              labelText: 'custom_category_name'.tr(context),
              labelStyle: GoogleFonts.cairo(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              prefixIcon: const Icon(Icons.edit, color: AppColors.primary),
              hintText: 'enter_category_name'.tr(context),
              hintStyle: GoogleFonts.cairo(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 2),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            style: GoogleFonts.cairo(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
            validator: (value) {
              if (_showCustomInput && (value == null || value.isEmpty)) {
                return 'please_enter_custom_category'.tr(context);
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: Row(
              children: [
                const Icon(Icons.info_outline,
                    size: 14, color: AppColors.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'custom_category_helper'.tr(context),
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  IconData _getCategoryIcon(String category, bool isArabic) {
    final englishName = AppCategories.getEnglishName(category);

    switch (englishName) {
      case 'Living Room':
        return Icons.weekend;
      case 'Bedroom':
        return Icons.bed;
      case 'Dining Room':
        return Icons.dining;
      case 'Kitchen':
        return Icons.kitchen;
      case 'Office':
        return Icons.work;
      case 'Bathroom':
        return Icons.bathroom;
      case 'Storage':
        return Icons.inventory_2;
      case 'Outdoor':
        return Icons.yard;
      case 'Kids Room':
        return Icons.child_care;
      case 'Lighting':
        return Icons.lightbulb;
      case 'Decoration':
        return Icons.palette;
      case 'Other':
        return Icons.more_horiz;
      default:
        return Icons.category;
    }
  }
}
