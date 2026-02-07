import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import 'language_button.dart';

class LanguageButtons extends StatelessWidget {
  final Function(BuildContext, String) onLanguageSelect;

  const LanguageButtons({
    super.key,
    required this.onLanguageSelect,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Column(
      children: [
        LanguageButton(
          flag: '🇸🇦',
          language: 'arabic'.tr(context),
          languageCode: 'ar',
          onTap: () => onLanguageSelect(context, 'ar'),
        ),
        SizedBox(height: r.spacing(20)),
        LanguageButton(
          flag: '🇬🇧',
          language: 'english'.tr(context),
          languageCode: 'en',
          onTap: () => onLanguageSelect(context, 'en'),
        ),
      ],
    );
  }
}
