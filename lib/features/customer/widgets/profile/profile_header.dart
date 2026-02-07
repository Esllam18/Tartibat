import 'package:flutter/material.dart';
import 'package:tartibat/core/localization/app_localizations.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/cache/auth_cache_helper.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String _userName = '';
  String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final name = await AuthCacheHelper().getUserName();
    final email = await AuthCacheHelper().getUserEmail();
    setState(() {
      _userName = name;
      _userEmail = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppDimensions.radiusXLarge),
          bottomRight: Radius.circular(AppDimensions.radiusXLarge),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            r.paddingHorizontal,
            r.spacing(20),
            r.paddingHorizontal,
            r.spacing(30),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'profile'.tr(context),
                    style:
                        AppTextStyles.h2(context).copyWith(color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.settings_outlined,
                      color: Colors.white,
                      size: r.responsive(mobile: 26, tablet: 28, desktop: 30),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('settings'.tr(context)),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: r.spacing(30)),
              Stack(
                children: [
                  Container(
                    width: r.responsive(mobile: 100, tablet: 120, desktop: 140),
                    height:
                        r.responsive(mobile: 100, tablet: 120, desktop: 140),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: r.responsive(mobile: 50, tablet: 60, desktop: 70),
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('change_photo'.tr(context)),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(r.spacing(8)),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.white, Color(0xFFF5F5F5)],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColors.primary,
                          size:
                              r.responsive(mobile: 18, tablet: 20, desktop: 22),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: r.spacing(16)),
              Text(
                _userName,
                style: AppTextStyles.h3(context).copyWith(
                  color: Colors.white,
                  fontSize: r.fontSize(20),
                ),
              ),
              SizedBox(height: r.spacing(6)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: r.spacing(12),
                  vertical: r.spacing(6),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusCircular),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                      size: r.responsive(mobile: 16, tablet: 18, desktop: 20),
                    ),
                    SizedBox(width: r.spacing(8)),
                    Text(
                      _userEmail,
                      style: AppTextStyles.bodySmall(context)
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
