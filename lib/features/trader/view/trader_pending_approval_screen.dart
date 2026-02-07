import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/cache/auth_cache_helper.dart';
import '../../splash/view/splash_screen.dart';

class TraderPendingApprovalScreen extends StatelessWidget {
  const TraderPendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(r.spacing(32)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(r.spacing(30)),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.hourglass_empty,
                      size: r.spacing(80),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: r.spacing(32)),
                  Text(
                    'pending_approval'.tr(context),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(28),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: r.spacing(16)),
                  Text(
                    'approval_message'.tr(context),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(16),
                      color: Colors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: r.spacing(48)),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await AuthCacheHelper().clearAuthData();
                        Navigator.pushAndRemoveUntil(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SplashScreen()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: r.spacing(16)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text('logout'.tr(context),
                          style: TextStyle(fontSize: r.fontSize(16))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
