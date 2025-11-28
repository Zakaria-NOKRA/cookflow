import 'package:flutter/material.dart';

class CategoryIconOption {
  final String label;
  final IconData icon;
  final String group;

  CategoryIconOption({
    required this.label,
    required this.icon,
    required this.group,
  });
}

/// MEAL TYPE
final List<CategoryIconOption> mealTypeCategories = [
  CategoryIconOption(
    label: "Breakfast",
    icon: Icons.free_breakfast,
    group: "Meal",
  ),
  CategoryIconOption(label: "Brunch", icon: Icons.bakery_dining, group: "Meal"),
  CategoryIconOption(label: "Lunch", icon: Icons.lunch_dining, group: "Meal"),
  CategoryIconOption(label: "Dinner", icon: Icons.dinner_dining, group: "Meal"),
  CategoryIconOption(label: "Snacks", icon: Icons.fastfood, group: "Meal"),
];

/// DIETARY
final List<CategoryIconOption> dietaryCategories = [
  CategoryIconOption(label: "Healthy", icon: Icons.eco, group: "Diet"),
  CategoryIconOption(label: "Vegan", icon: Icons.spa, group: "Diet"),
  CategoryIconOption(label: "Gluten-Free", icon: Icons.cookie, group: "Diet"),
];

/// OCCASIONS
final List<CategoryIconOption> occasionCategories = [
  CategoryIconOption(
    label: "Kids",
    icon: Icons.child_friendly,
    group: "Occasion",
  ),
  CategoryIconOption(
    label: "Quick 30min",
    icon: Icons.timer,
    group: "Occasion",
  ),
  CategoryIconOption(
    label: "Party",
    icon: Icons.celebration,
    group: "Occasion",
  ),
];

/// POPULAR
final List<CategoryIconOption> popularCategories = [
  CategoryIconOption(
    label: "Trending",
    icon: Icons.trending_up,
    group: "Popular",
  ),
  CategoryIconOption(label: "Chef Pick", icon: Icons.star, group: "Popular"),
];

/// MERGED FULL LIST — REQUIRED FOR SEARCHING ICON
final List<CategoryIconOption> predefinedCategoryIcons = [
  ...mealTypeCategories,
  ...dietaryCategories,
  ...occasionCategories,
  ...popularCategories,
];
