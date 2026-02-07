import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/locale_cubit.dart';
import 'profile_menu_item.dart';

class ProfileMenuSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  const ProfileMenuSection({
    super.key,
    required this.title,
    required this.items,
  });

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'edit_profile':
        _showEditProfileDialog(context);
        break;
      case 'my_orders':
        _showComingSoon(context, 'my_orders'.tr(context));
        break;
      case 'addresses':
        _showComingSoon(context, 'addresses'.tr(context));
        break;
      case 'language':
        _showLanguageDialog(context);
        break;
      case 'notifications':
        _showNotificationsSettings(context);
        break;
      case 'privacy':
        _showComingSoon(context, 'privacy'.tr(context));
        break;
      case 'help_center':
        _showHelpCenter(context);
        break;
      case 'about_app':
        _showAboutDialog(context);
        break;
      case 'share_app':
        _shareApp(context);
        break;
    }
  }

  void _showEditProfileDialog(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.edit, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Text('edit_profile'.tr(context)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'full_name'.tr(context),
                prefixIcon:
                    const Icon(Icons.person_outline, color: AppColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'phone'.tr(context),
                prefixIcon:
                    const Icon(Icons.phone_outlined, color: AppColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr(context),
                style: const TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('profile_updated'.tr(context)),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('save'.tr(context)),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final currentLocale = context.read<LocaleCubit>().state.locale;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.language, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Text('language'.tr(context)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(context, dialogContext, '🇸🇦',
                'arabic'.tr(context), 'ar', currentLocale.languageCode == 'ar'),
            const SizedBox(height: 12),
            _buildLanguageOption(
                context,
                dialogContext,
                '🇬🇧',
                'english'.tr(context),
                'en',
                currentLocale.languageCode == 'en'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
      BuildContext parentContext,
      BuildContext dialogContext,
      String flag,
      String language,
      String code,
      bool isSelected) {
    return InkWell(
      onTap: () async {
        Navigator.pop(dialogContext);

        showDialog(
          context: parentContext,
          barrierDismissible: false,
          builder: (context) => Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: AppColors.primary),
                  const SizedBox(height: 16),
                  Text('changing_language'.tr(context)),
                ],
              ),
            ),
          ),
        );

        await parentContext.read<LocaleCubit>().changeLanguage(code);
        await Future.delayed(const Duration(milliseconds: 800));

        if (parentContext.mounted) {
          Navigator.pop(parentContext);
          ScaffoldMessenger.of(parentContext).showSnackBar(
            SnackBar(
              content: Text('language_changed'.tr(parentContext)),
              backgroundColor: AppColors.success,
            ),
          );
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 16),
            Expanded(
                child: Text(language,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600))),
            if (isSelected)
              const Icon(Icons.check_circle,
                  color: AppColors.primary, size: 24),
          ],
        ),
      ),
    );
  }

  void _showNotificationsSettings(BuildContext context) {
    bool offersNotifications = true;
    bool ordersNotifications = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.notifications_outlined,
                    color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Text('notifications'.tr(context)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: Text('offers_notifications'.tr(context)),
                subtitle: Text('notification_offers_desc'.tr(context),
                    style: AppTextStyles.caption(context)),
                value: offersNotifications,
                activeColor: AppColors.primary,
                onChanged: (val) => setState(() => offersNotifications = val),
              ),
              const Divider(),
              SwitchListTile(
                title: Text('orders_notifications'.tr(context)),
                subtitle: Text('notification_orders_desc'.tr(context),
                    style: AppTextStyles.caption(context)),
                value: ordersNotifications,
                activeColor: AppColors.primary,
                onChanged: (val) => setState(() => ordersNotifications = val),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('settings_saved'.tr(context)),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('save'.tr(context)),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpCenter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.help_outline, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Text('help_center'.tr(context)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHelpOption(context, Icons.phone, 'contact_phone'.tr(context),
                '+20 123 456 7890'),
            const SizedBox(height: 12),
            _buildHelpOption(context, Icons.email, 'contact_email'.tr(context),
                'support@tarteebat.com'),
            const SizedBox(height: 12),
            _buildHelpOption(context, Icons.schedule,
                'working_hours'.tr(context), 'working_hours_time'.tr(context)),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('close'.tr(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpOption(
      BuildContext context, IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.caption(context)),
                const SizedBox(height: 2),
                Text(value,
                    style: AppTextStyles.bodyMedium(context)
                        .copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.chair, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Text('about_app'.tr(context)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('about_app_name'.tr(context),
                style: AppTextStyles.h3(context)
                    .copyWith(color: AppColors.primary)),
            const SizedBox(height: 8),
            Text('about_version'.tr(context),
                style: AppTextStyles.bodySmall(context)),
            const SizedBox(height: 16),
            Text('about_description'.tr(context),
                style: AppTextStyles.bodyMedium(context)),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Text('about_copyright'.tr(context),
                style: AppTextStyles.caption(context)),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('close'.tr(context)),
          ),
        ],
      ),
    );
  }

  void _shareApp(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.share, color: Colors.white),
            const SizedBox(width: 12),
            Text('share_message'.tr(context)),
          ],
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - ${'coming_soon'.tr(context)}'),
        backgroundColor: AppColors.warning,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.all(r.spacing(AppDimensions.paddingMedium)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: AppTextStyles.h4(context)
                  .copyWith(color: AppColors.textSecondary)),
          SizedBox(height: r.spacing(12)),
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Column(
              children: [
                ProfileMenuItem(
                  icon: item['icon'] as IconData,
                  title: (item['titleKey'] as String).tr(context),
                  onTap: () =>
                      _handleMenuAction(context, item['action'] as String),
                ),
                if (index < items.length - 1)
                  Divider(height: r.spacing(16), thickness: 0.5),
              ],
            );
          }),
        ],
      ),
    );
  }
}
