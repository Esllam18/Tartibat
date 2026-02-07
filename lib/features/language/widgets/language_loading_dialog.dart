import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive.dart';

class LanguageLoadingDialog extends StatelessWidget {
  const LanguageLoadingDialog({super.key});
  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return PopScope(
      canPop: false,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(r.spacing(20)),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: r.spacing(14)),
            Text('loading'.tr(context)),
          ]),
        ),
      ),
    );
  }
}
