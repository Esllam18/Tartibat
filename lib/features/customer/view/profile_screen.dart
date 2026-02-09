import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tartibat/core/localization/locale_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/checkout_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/profile_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/profile_state.dart';
import 'package:tartibat/features/customer/view/order_history_screen.dart';
import 'package:tartibat/features/customer/widgets/profile/edit_profile_screen.dart';
import 'package:tartibat/features/customer/widgets/profile/profile_addresses_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/profile_menu_item.dart';
import '../widgets/profile/language_selection_dialog.dart';
import '../widgets/profile/help_support_bottom_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoggedOut) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  SizedBox(width: r.spacing(12)),
                  Text('logged_out_successfully'.tr(context)),
                ],
              ),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        } else if (state is ProfileUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  SizedBox(width: r.spacing(12)),
                  Text('profile_updated_successfully'.tr(context)),
                ],
              ),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              if (state is ProfileLoaded) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: r.spacing(20)),
                      ProfileHeader(user: state.user),
                      SizedBox(height: r.spacing(24)),
                      _buildMenuSection(context, r),
                      SizedBox(height: r.spacing(24)),
                      _buildAppInfo(context, r),
                      SizedBox(height: r.spacing(80)),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, Responsive r) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: r.spacing(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.person_outline,
            title: 'edit_profile'.tr(context),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<ProfileCubit>(),
                    child: const EditProfileScreen(),
                  ),
                ),
              );
            },
          ),
          const Divider(height: 1, indent: 70),
          ProfileMenuItem(
            icon: Icons.shopping_bag_outlined,
            title: 'my_orders'.tr(context),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrdersScreen()),
              );
            },
          ),
          const Divider(height: 1, indent: 70),
          ProfileMenuItem(
            icon: Icons.location_on_outlined,
            title: 'saved_addresses'.tr(context),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<CheckoutCubit>(),
                    child: const ProfileAddressesScreen(),
                  ),
                ),
              );
            },
          ),
          const Divider(height: 1, indent: 70),
          ProfileMenuItem(
            icon: Icons.language,
            title: 'language'.tr(context),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.read<LocaleCubit>(),
                  child: const LanguageSelectionDialog(),
                ),
              );
            },
          ),
          const Divider(height: 1, indent: 70),
          ProfileMenuItem(
            icon: Icons.help_outline,
            title: 'help_support'.tr(context),
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (_) => const HelpSupportBottomSheet(),
              );
            },
          ),
          const Divider(height: 1, indent: 70),
          ProfileMenuItem(
            icon: Icons.logout,
            title: 'logout'.tr(context),
            iconColor: AppColors.error,
            textColor: AppColors.error,
            onTap: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfo(BuildContext context, Responsive r) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: r.spacing(16)),
      padding: EdgeInsets.all(r.spacing(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'ترتيبات - Tartibat',
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(16),
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: r.spacing(4)),
          Text(
            'Version 1.0.0',
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(12),
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final r = context.responsive;

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: EdgeInsets.all(r.spacing(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(r.spacing(20)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.error.withOpacity(0.2),
                      AppColors.error.withOpacity(0.1)
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout,
                  color: AppColors.error,
                  size: r.responsive(mobile: 40, tablet: 48, desktop: 56),
                ),
              ),
              SizedBox(height: r.spacing(20)),
              Text(
                'logout'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(22),
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: r.spacing(12)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: r.spacing(12)),
                child: Text(
                  'logout_confirmation'.tr(context),
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(15),
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: r.spacing(28)),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: r.spacing(14)),
                        side: BorderSide(color: Colors.grey.shade300, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'cancel'.tr(context),
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(16),
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: r.spacing(12)),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ProfileCubit>().logout();
                        Navigator.pop(dialogContext);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        padding: EdgeInsets.symmetric(vertical: r.spacing(14)),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'logout'.tr(context),
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(16),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
