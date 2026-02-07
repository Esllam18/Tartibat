import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';

class ProfileMenuItemClean extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItemClean({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.only(bottom: r.spacing(12)),
      child: Material(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(r.spacing(16)),
            child: Row(
              children: [
                Icon(icon,
                    color: Colors.black,
                    size: r.responsive(mobile: 24, tablet: 26, desktop: 28)),
                SizedBox(width: r.spacing(16)),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: r.fontSize(16),
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: r.fontSize(14), color: Colors.black38),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
