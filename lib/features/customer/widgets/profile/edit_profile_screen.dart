import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tartibat/core/constants/app_colors.dart';
import 'package:tartibat/core/localization/app_localizations.dart';
import 'package:tartibat/core/utils/responsive.dart';
import 'package:tartibat/features/customer/data/bloc/profile_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/profile_state.dart';
import 'package:tartibat/features/customer/data/models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final user = context.read<ProfileCubit>().currentUser;
    _nameController = TextEditingController(text: user?.name ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
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
          'edit_profile'.tr(context),
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(18),
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is! ProfileLoaded) return const SizedBox();

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(r.spacing(20)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: r.spacing(20)),
                    _buildAvatar(context, r, state.user),
                    SizedBox(height: r.spacing(32)),
                    _buildTextField(
                      controller: _nameController,
                      label: 'full_name'.tr(context),
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please_enter_name'.tr(context);
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

  Widget _buildAvatar(BuildContext context, Responsive r, UserModel user) {
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
            child: Text(
              user.initials,
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(36),
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
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
      final currentUser = context.read<ProfileCubit>().currentUser;
      if (currentUser != null) {
        final updatedUser = currentUser.copyWith(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
        );
        context.read<ProfileCubit>().updateProfile(updatedUser);
        Navigator.pop(context);
      }
    }
  }
}
