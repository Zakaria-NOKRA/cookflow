import 'package:flutter/material.dart';

class CategoryIconOption {
  final String label;
  final IconData icon;

  CategoryIconOption({required this.label, required this.icon});
}

final List<CategoryIconOption> predefinedCategoryIcons = [
  CategoryIconOption(label: "Breakfast", icon: Icons.free_breakfast),
  CategoryIconOption(label: "Lunch", icon: Icons.lunch_dining),
  CategoryIconOption(label: "Dinner", icon: Icons.dinner_dining),
  CategoryIconOption(label: "Dessert", icon: Icons.cake),
  CategoryIconOption(label: "Snacks", icon: Icons.fastfood),
  CategoryIconOption(label: "Drinks", icon: Icons.local_drink),
  CategoryIconOption(label: "Healthy", icon: Icons.eco),
];
