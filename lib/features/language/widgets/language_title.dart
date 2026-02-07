import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

class LanguageTitle extends StatelessWidget {
  const LanguageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Text(
      'choose_language'.tr(context),
      style: AppTextStyles.h1Static.copyWith(
        color: Colors.white,
        fontSize: r.fontSize(28),
      ),
      textAlign: TextAlign.center,
    );
  }
}
