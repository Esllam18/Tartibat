import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

class HelpSupportBottomSheet extends StatelessWidget {
  const HelpSupportBottomSheet({super.key});

  // Contact information
  static const String phoneNumber = '+201234567890';
  static const String email = 'support@tartibat.com';
  static const String websiteUrl = 'https://tartibat.com';

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(r.spacing(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: r.spacing(20)),
              Text(
                'help_support'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(24),
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: r.spacing(8)),
              Text(
                'we_are_here_to_help'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(14),
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: r.spacing(24)),
              _buildSupportOption(
                context: context,
                r: r,
                icon: Icons.phone,
                title: 'call_us'.tr(context),
                subtitle: phoneNumber,
                colors: [const Color(0xFF22c55e), const Color(0xFF16a34a)],
                onTap: () => _handleCall(context, phoneNumber),
              ),
              SizedBox(height: r.spacing(12)),
              _buildSupportOption(
                context: context,
                r: r,
                icon: Icons.email,
                title: 'email_us'.tr(context),
                subtitle: email,
                colors: [const Color(0xFF3b82f6), const Color(0xFF2563eb)],
                onTap: () => _handleEmail(context, email),
              ),
              SizedBox(height: r.spacing(12)),
              _buildSupportOption(
                context: context,
                r: r,
                icon: Icons.chat_bubble,
                title: 'whatsapp'.tr(context),
                subtitle: 'chat_on_whatsapp'.tr(context),
                colors: [const Color(0xFF25D366), const Color(0xFF128C7E)],
                onTap: () => _handleWhatsApp(context, phoneNumber),
              ),
              SizedBox(height: r.spacing(12)),
              _buildSupportOption(
                context: context,
                r: r,
                icon: Icons.language,
                title: 'visit_website'.tr(context),
                subtitle: websiteUrl,
                colors: [AppColors.primary, const Color(0xFF8B6F47)],
                onTap: () => _handleWebsite(context, websiteUrl),
              ),
              SizedBox(height: r.spacing(12)),
              _buildSupportOption(
                context: context,
                r: r,
                icon: Icons.content_copy,
                title: 'copy_phone_number'.tr(context),
                subtitle: 'tap_to_copy'.tr(context),
                colors: [const Color(0xFF9333ea), const Color(0xFF7e22ce)],
                onTap: () => _copyToClipboard(
                    context, phoneNumber, 'phone_copied'.tr(context)),
              ),
              SizedBox(height: r.spacing(12)),
              _buildSupportOption(
                context: context,
                r: r,
                icon: Icons.mail_outline,
                title: 'copy_email'.tr(context),
                subtitle: 'tap_to_copy'.tr(context),
                colors: [const Color(0xFFf97316), const Color(0xFFea580c)],
                onTap: () => _copyToClipboard(
                    context, email, 'email_copied'.tr(context)),
              ),
              SizedBox(height: r.spacing(20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportOption({
    required BuildContext context,
    required Responsive r,
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> colors,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: colors[0].withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(r.spacing(16)),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(r.spacing(12)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                SizedBox(width: r.spacing(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(15),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: r.spacing(2)),
                      Text(
                        subtitle,
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(12),
                          color: Colors.white.withOpacity(0.9),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.8),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleCall(BuildContext context, String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      if (context.mounted) Navigator.pop(context);
    } else {
      if (context.mounted) {
        _showErrorSnackBar(context, 'cannot_make_call'.tr(context));
      }
    }
  }

  Future<void> _handleEmail(BuildContext context, String email) async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=${'support_request'.tr(context)}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      if (context.mounted) Navigator.pop(context);
    } else {
      if (context.mounted) {
        _showErrorSnackBar(context, 'cannot_open_email'.tr(context));
      }
    }
  }

  Future<void> _handleWhatsApp(BuildContext context, String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    final message =
        Uri.encodeComponent('مرحباً، أحتاج إلى مساعدة - Hello, I need help');
    final Uri url = Uri.parse('https://wa.me/$cleanPhone?text=$message');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      if (context.mounted) Navigator.pop(context);
    } else {
      if (context.mounted) {
        _showErrorSnackBar(context, 'cannot_open_whatsapp'.tr(context));
      }
    }
  }

  Future<void> _handleWebsite(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (context.mounted) Navigator.pop(context);
    } else {
      if (context.mounted) {
        _showErrorSnackBar(context, 'cannot_open_website'.tr(context));
      }
    }
  }

  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      final r = context.responsive;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
              SizedBox(width: r.spacing(12)),
              Text(
                message,
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    final r = context.responsive;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            SizedBox(width: r.spacing(12)),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
