import 'package:flutter/material.dart';

class RoleData {
  final String id;
  final String titleKey;
  final String descriptionKey;
  final IconData icon;
  final Gradient gradient;

  const RoleData({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.icon,
    required this.gradient,
  });
}

const roleOptions = [
  RoleData(
    id: 'customer',
    titleKey: 'customer',
    descriptionKey: 'customer_description',
    icon: Icons.shopping_bag_rounded,
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF4A5568),
        Color(0xFF2D3748),
      ],
    ),
  ),
  RoleData(
    id: 'trader',
    titleKey: 'trader',
    descriptionKey: 'trader_description',
    icon: Icons.store_rounded,
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF744210),
        Color(0xFF4A2511),
      ],
    ),
  ),
];
