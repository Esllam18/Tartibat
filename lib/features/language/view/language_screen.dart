import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/cache/language_cache_helper.dart';
import '../../../core/localization/locale_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../onboarding/view/onboarding_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(r.spacing(24)),
            child: Column(
              children: [
                SizedBox(height: r.spacing(40)),
                Icon(
                  Icons.language_rounded,
                  size: r.spacing(80),
                  color: Colors.white,
                ),
                SizedBox(height: r.spacing(24)),
                Text(
                  'Choose Your Language',
                  style: GoogleFonts.poppins(
                    fontSize: r.fontSize(28),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: r.spacing(8)),
                Text(
                  'اختر لغتك المفضلة',
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(24),
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
                const Spacer(),
                _buildLanguageCard(
                  language: 'ar',
                  title: 'العربية',
                  subtitle: 'Arabic',
                  flag: '🇮🇶',
                  r: r,
                ),
                SizedBox(height: r.spacing(16)),
                _buildLanguageCard(
                  language: 'en',
                  title: 'English',
                  subtitle: 'الإنجليزية',
                  flag: '🇬🇧',
                  r: r,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: r.spacing(56),
                  child: ElevatedButton(
                    onPressed: _selectedLanguage == null ? null : _onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      disabledBackgroundColor: Colors.white24,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue / متابعة',
                      style: GoogleFonts.poppins(
                        fontSize: r.fontSize(16),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: r.spacing(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard({
    required String language,
    required String title,
    required String subtitle,
    required String flag,
    required Responsive r,
  }) {
    final isSelected = _selectedLanguage == language;

    return GestureDetector(
      onTap: () => setState(() => _selectedLanguage = language),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(r.spacing(20)),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white24,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: r.spacing(60),
              height: r.spacing(60),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.white24,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  flag,
                  style: TextStyle(fontSize: r.fontSize(32)),
                ),
              ),
            ),
            SizedBox(width: r.spacing(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(22),
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.primary : Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: r.fontSize(14),
                      color:
                          isSelected ? AppColors.textSecondary : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: EdgeInsets.all(r.spacing(8)),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: r.spacing(20),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _onContinue() async {
    if (_selectedLanguage == null) return;

    await LanguageCacheHelper().cacheLanguageCode(_selectedLanguage!);
    // ignore: use_build_context_synchronously
    context.read<LocaleCubit>().changeLanguage(_selectedLanguage!);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
    );
  }
}
