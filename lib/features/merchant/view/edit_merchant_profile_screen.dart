import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../bloc/merchant_profile_cubit.dart';
import '../bloc/merchant_profile_state.dart';

class EditMerchantProfileScreen extends StatefulWidget {
  const EditMerchantProfileScreen({super.key});

  @override
  State<EditMerchantProfileScreen> createState() =>
      _EditMerchantProfileScreenState();
}

class _EditMerchantProfileScreenState extends State<EditMerchantProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _storeNameController;
  late TextEditingController _storeNameArController;
  late TextEditingController _ownerNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final profile = context.read<MerchantProfileCubit>().currentProfile;
    _storeNameController =
        TextEditingController(text: profile?.storeName ?? '');
    _storeNameArController =
        TextEditingController(text: profile?.storeNameAr ?? '');
    _ownerNameController =
        TextEditingController(text: profile?.ownerName ?? '');
    _emailController = TextEditingController(text: profile?.email ?? '');
    _phoneController = TextEditingController(text: profile?.phone ?? '');
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _storeNameArController.dispose();
    _ownerNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(r.spacing(8)),
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back,
                color: AppColors.textPrimary, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'edit_store_profile'.tr(context),
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(18),
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MerchantProfileCubit, MerchantProfileState>(
        builder: (context, state) {
          if (state is! MerchantProfileLoaded) return const SizedBox();

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(r.spacing(20)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: r.spacing(20)),
                    _buildStoreIcon(context, r),
                    SizedBox(height: r.spacing(32)),
                    _buildTextField(
                      controller: _storeNameController,
                      label: 'store_name_english'.tr(context),
                      icon: Icons.store_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please_enter_store_name'.tr(context);
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: r.spacing(16)),
                    _buildTextField(
                      controller: _storeNameArController,
                      label: 'store_name_arabic'.tr(context),
                      icon: Icons.store,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please_enter_store_name_ar'.tr(context);
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: r.spacing(16)),
                    _buildTextField(
                      controller: _ownerNameController,
                      label: 'owner_name'.tr(context),
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please_enter_owner_name'.tr(context);
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: r.spacing(16)),
                    _buildTextField(
                      controller: _emailController,
                      label: 'email'.tr(context),
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please_enter_email'.tr(context);
                        }
                        if (!value.contains('@')) {
                          return 'invalid_email'.tr(context);
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: r.spacing(16)),
                    _buildTextField(
                      controller: _phoneController,
                      label: 'phone_number'.tr(context),
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please_enter_phone'.tr(context);
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: r.spacing(32)),
                    SizedBox(
                      width: double.infinity,
                      height: r.responsive(mobile: 56, tablet: 60, desktop: 64),
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'save_changes'.tr(context),
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
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStoreIcon(BuildContext context, Responsive r) {
    return Stack(
      children: [
        Container(
          width: r.responsive(mobile: 100, tablet: 120, desktop: 140),
          height: r.responsive(mobile: 100, tablet: 120, desktop: 140),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.store,
              size: r.responsive(mobile: 50, tablet: 60, desktop: 70),
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(r.spacing(8)),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Icon(
              Icons.camera_alt,
              color: AppColors.primary,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    final r = context.responsive;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.cairo(
        fontSize: r.fontSize(14),
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.cairo(
          fontSize: r.fontSize(14),
          color: AppColors.textSecondary,
        ),
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final currentProfile =
          context.read<MerchantProfileCubit>().currentProfile;
      if (currentProfile != null) {
        final updatedProfile = currentProfile.copyWith(
          storeName: _storeNameController.text,
          storeNameAr: _storeNameArController.text,
          ownerName: _ownerNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
        );
        context.read<MerchantProfileCubit>().updateProfile(updatedProfile);
        Navigator.pop(context);
      }
    }
  }
}
