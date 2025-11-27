import 'package:flutter/material.dart';

class CategoryIconOption {
  final String label;
  final IconData icon;

  CategoryIconOption(this.label, this.icon);
}

final List<CategoryIconOption> predefinedCategoryIcons = [
  CategoryIconOption("Breakfast", Icons.free_breakfast),
  CategoryIconOption("Lunch", Icons.lunch_dining),
  CategoryIconOption("Dinner", Icons.dinner_dining),
  CategoryIconOption("Dessert", Icons.cake),
  CategoryIconOption("Snacks", Icons.fastfood),
  CategoryIconOption("Drinks", Icons.local_drink),
  CategoryIconOption("Healthy", Icons.eco),
  CategoryIconOption("Vegan", Icons.spa),
  CategoryIconOption("Kids", Icons.child_friendly),
  CategoryIconOption("Popular", Icons.star),
];
