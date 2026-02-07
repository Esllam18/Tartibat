import 'package:flutter/material.dart';
import '../logic/language_apply.dart';
import '../widgets/language_background.dart';
import '../widgets/language_continue_button.dart';
import '../widgets/language_header.dart';
import '../widgets/language_option_tile.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? selected;

  String get _continueLabel => selected == 'ar' ? 'متابعة' : 'Continue';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LanguageBackground(
        child: SafeArea(
          child: Column(children: [
            const LanguageHeader(),
            const Spacer(),
            LanguageOptionTile(
                code: 'ar',
                selected: selected == 'ar',
                onTap: () => setState(() => selected = 'ar')),
            const SizedBox(height: 14),
            LanguageOptionTile(
                code: 'en',
                selected: selected == 'en',
                onTap: () => setState(() => selected = 'en')),
            const Spacer(),
            LanguageContinueButton(
              enabled: selected != null,
              label: _continueLabel,
              onPressed: () => LanguageApply.apply(context, selected!),
            ),
            const SizedBox(height: 18),
          ]),
        ),
      ),
    );
  }
}
