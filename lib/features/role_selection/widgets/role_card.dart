import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'role_card_content.dart';

class RoleCard extends StatelessWidget {
  final String role;
  final IconData icon;
  final String titleKey, descriptionKey;
  final Gradient gradient;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard(
      {super.key,
      required this.role,
      required this.icon,
      required this.titleKey,
      required this.descriptionKey,
      required this.gradient,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isSelected ? gradient : null,
          color: isSelected ? null : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: isSelected ? Colors.white : Colors.white30,
              width: isSelected ? 3 : 2),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.4),
                      blurRadius: 25,
                      spreadRadius: 3)
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(isSelected ? 0.25 : 0.1),
                  borderRadius: BorderRadius.circular(16)),
              child: Icon(icon, size: 36, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: RoleCardContent(
                    titleKey: titleKey, descriptionKey: descriptionKey)),
            if (isSelected)
              Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.check_rounded,
                      color: AppColors.primary, size: 20)),
          ],
        ),
      ),
    );
  }
}
