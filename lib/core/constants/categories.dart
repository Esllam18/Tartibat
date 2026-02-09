class AppCategories {
  // Predefined categories with translations
  static const List<Map<String, String>> categories = [
    {'en': 'Living Room', 'ar': 'غرفة المعيشة'},
    {'en': 'Bedroom', 'ar': 'غرفة النوم'},
    {'en': 'Dining Room', 'ar': 'غرفة الطعام'},
    {'en': 'Kitchen', 'ar': 'المطبخ'},
    {'en': 'Office', 'ar': 'المكتب'},
    {'en': 'Bathroom', 'ar': 'الحمام'},
    {'en': 'Storage', 'ar': 'التخزين'},
    {'en': 'Outdoor', 'ar': 'أثاث خارجي'},
    {'en': 'Kids Room', 'ar': 'غرفة الأطفال'},
    {'en': 'Lighting', 'ar': 'الإضاءة'},
    {'en': 'Decoration', 'ar': 'الديكور'},
    {'en': 'Other', 'ar': 'أخرى'},
  ];

  // Get category name in current language
  static String getCategoryName(String category, bool isArabic) {
    // Try to find in predefined categories
    for (var cat in categories) {
      if (cat['en'] == category || cat['ar'] == category) {
        return isArabic ? cat['ar']! : cat['en']!;
      }
    }
    // Return as-is if custom category
    return category;
  }

  // Get English name from Arabic
  static String getEnglishName(String category) {
    for (var cat in categories) {
      if (cat['ar'] == category) {
        return cat['en']!;
      }
    }
    return category;
  }

  // Get Arabic name from English
  static String getArabicName(String category) {
    for (var cat in categories) {
      if (cat['en'] == category) {
        return cat['ar']!;
      }
    }
    return category;
  }

  // Get list of categories in current language
  static List<String> getCategoriesInLanguage(bool isArabic) {
    return categories.map((cat) => isArabic ? cat['ar']! : cat['en']!).toList();
  }
}
