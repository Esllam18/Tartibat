import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class ProfileHeaderClean extends StatelessWidget {
  const ProfileHeaderClean({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(r.spacing(24)),
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        children: [
          Container(
            width: r.responsive(mobile: 80, tablet: 100, desktop: 120),
            height: r.responsive(mobile: 80, tablet: 100, desktop: 120),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              size: r.responsive(mobile: 40, tablet: 50, desktop: 60),
              color: Colors.black,
            ),
          ),
          SizedBox(height: r.spacing(16)),
          Text(
            'user_name'.tr(context),
            style: TextStyle(
              fontSize: r.fontSize(20),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: r.spacing(4)),
          Text(
            'user_email'.tr(context),
            style: TextStyle(
              fontSize: r.fontSize(14),
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
