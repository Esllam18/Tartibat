import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String nameKey;
  final IconData icon;
  final Color color;

  const CategoryModel({
    required this.id,
    required this.nameKey,
    required this.icon,
    required this.color,
  });
}

const mainCategories = [
  CategoryModel(
    id: 'all',
    nameKey: 'category_all',
    icon: Icons.apps_rounded,
    color: Color(0xFF6366F1),
  ),
  CategoryModel(
    id: 'living_room',
    nameKey: 'category_living_room',
    icon: Icons.weekend_rounded,
    color: Color(0xFFEC4899),
  ),
  CategoryModel(
    id: 'bedroom',
    nameKey: 'category_bedroom',
    icon: Icons.bed_rounded,
    color: Color(0xFF8B5CF6),
  ),
  CategoryModel(
    id: 'dining',
    nameKey: 'category_dining',
    icon: Icons.table_restaurant_rounded,
    color: Color(0xFF10B981),
  ),
  CategoryModel(
    id: 'office',
    nameKey: 'category_office',
    icon: Icons.desk_rounded,
    color: Color(0xFFF59E0B),
  ),
  CategoryModel(
    id: 'outdoor',
    nameKey: 'category_outdoor',
    icon: Icons.yard_outlined,
    color: Color(0xFF14B8A6),
  ),
  CategoryModel(
    id: 'decor',
    nameKey: 'category_decor',
    icon: Icons.auto_awesome_outlined,
    color: Color(0xFFF97316),
  ),
  CategoryModel(
    id: 'storage',
    nameKey: 'category_storage',
    icon: Icons.inventory_2_rounded,
    color: Color(0xFF06B6D4),
  ),
];
