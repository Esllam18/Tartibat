import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';

class LanguageCard extends StatelessWidget {
  final String flag;
  final String language;
  final String languageCode;
  final VoidCallback onTap;

  const LanguageCard({
    super.key,
    required this.flag,
    required this.language,
    required this.languageCode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.all(r.spacing(24)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.15),
              Colors.white.withOpacity(0.05),
            ],
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: r.spacing(24),
              backgroundColor: Colors.white.withOpacity(0.2),
              child: Text(
                flag,
                style: TextStyle(fontSize: r.fontSize(24)),
              ),
            ),
            SizedBox(width: r.spacing(20)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language,
                    style: TextStyle(
                      fontSize: r.fontSize(20),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    languageCode.toUpperCase(),
                    style: TextStyle(
                      fontSize: r.fontSize(14),
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: r.spacing(18),
            ),
          ],
        ),
      ),
    );
  }
}
