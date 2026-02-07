import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/cache/language_cache_helper.dart';
import '../../../core/localization/locale_cubit.dart';
import '../../onboarding/view/onboarding_screen.dart';
import '../widgets/language_loading_dialog.dart';

class LanguageApply {
  static Future<void> apply(BuildContext context, String code) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LanguageLoadingDialog());
    await LanguageCacheHelper().cacheLanguageCode(code);
    // ignore: use_build_context_synchronously
    await context.read<LocaleCubit>().changeLanguage(code);
    if (!context.mounted) return;
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
  }
}
