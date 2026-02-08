import 'package:flutter/material.dart';
import 'role_card.dart';

class RoleSelectionCards extends StatelessWidget {
  final String? selectedRole;
  final ValueChanged<String> onRoleSelect;
  const RoleSelectionCards(
      {super.key, required this.selectedRole, required this.onRoleSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          RoleCard(
            role: 'customer',
            icon: Icons.shopping_bag_rounded,
            titleKey: 'customer',
            descriptionKey: 'customer_description',
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 54, 61, 101),
                Color.fromARGB(255, 87, 88, 103)
              ],
            ),
            isSelected: selectedRole == 'customer',
            onTap: () => onRoleSelect('customer'),
          ),
          const SizedBox(height: 16),
          RoleCard(
            role: 'trader',
            icon: Icons.store_rounded,
            titleKey: 'trader',
            descriptionKey: 'trader_description',
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 42, 39, 38),
                Color.fromARGB(255, 121, 110, 96)
              ],
            ),
            isSelected: selectedRole == 'trader',
            onTap: () => onRoleSelect('trader'),
          ),
        ],
      ),
    );
  }
}
