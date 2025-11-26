import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String videoUrl;
  final List<String> categories;
  final String difficulty; // EASY, MEDIUM, HARD
  final int totalTime;
  final double ratingPercentage;
  final int servings;
  final List<Map<String, dynamic>> ingredients;
  final List<Map<String, dynamic>> steps;
  final List<String> dietaryTags; // vegan, sugar-free, etc.
  final String createdBy;
  final DateTime createdAt;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.categories,
    required this.difficulty,
    required this.totalTime,
    required this.ratingPercentage,
    required this.servings,
    required this.ingredients,
    required this.steps,
    required this.dietaryTags,
    required this.createdBy,
    required this.createdAt,
  });

  factory Recipe.fromMap(Map<String, dynamic> data, String documentId) {
    return Recipe(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      videoUrl: data['videoUrl'] ?? '',
      categories: List<String>.from(data['categories'] ?? []),
      difficulty: data['difficulty'] ?? 'EASY',
      totalTime: data['totalTime'] ?? 0,
      ratingPercentage: (data['ratingPercentage'] ?? 0).toDouble(),
      servings: data['servings'] ?? 1,
      ingredients: List<Map<String, dynamic>>.from(data['ingredients'] ?? []),
      steps: List<Map<String, dynamic>>.from(data['steps'] ?? []),
      dietaryTags: List<String>.from(data['dietaryTags'] ?? []),
      createdBy: data['createdBy'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'categories': categories,
      'difficulty': difficulty,
      'totalTime': totalTime,
      'ratingPercentage': ratingPercentage,
      'servings': servings,
      'ingredients': ingredients,
      'steps': steps,
      'dietaryTags': dietaryTags,
      'createdBy': createdBy,
      'createdAt': createdAt,
    };
  }
}
