import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class RoleCardContent extends StatelessWidget {
  final String titleKey, descriptionKey;
  const RoleCardContent(
      {super.key, required this.titleKey, required this.descriptionKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleKey.tr(context),
          style: AppTextStyles.h3Static
              .copyWith(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(height: 4),
        Text(
          descriptionKey.tr(context),
          style: AppTextStyles.bodySmallStatic
              .copyWith(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }
}
