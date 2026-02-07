import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';
import 'language_card.dart';

class LanguageCards extends StatelessWidget {
  final Function(BuildContext, String) onLanguageSelect;

  const LanguageCards({
    super.key,
    required this.onLanguageSelect,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Column(
      children: [
        LanguageCard(
          flag: '🇸🇦',
          language: 'العربية',
          languageCode: 'ar',
          onTap: () => onLanguageSelect(context, 'ar'),
        ),
        SizedBox(height: r.spacing(20)),
        LanguageCard(
          flag: '🇬🇧',
          language: 'English',
          languageCode: 'en',
          onTap: () => onLanguageSelect(context, 'en'),
        ),
      ],
    );
  }
}
