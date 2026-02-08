import 'package:flutter/material.dart';

class RoleOption {
  final String id, titleKey, descKey;
  final IconData icon;
  const RoleOption(
      {required this.id,
      required this.titleKey,
      required this.descKey,
      required this.icon});
}

const roleOptions = <RoleOption>[
  RoleOption(
      id: 'customer',
      titleKey: 'customer',
      descKey: 'customer_description',
      icon: Icons.person_rounded),
  RoleOption(
      id: 'trader',
      titleKey: 'trader',
      descKey: 'trader_description',
      icon: Icons.storefront_rounded),
];
