import 'package:cloud_firestore/cloud_firestore.dart';

class SavedRecipe {
  final String id; // Firestore document ID
  final String userId; // Which user saved the recipe
  final String recipeId; // Which recipe is saved
  final DateTime savedAt; // Timestamp of save action

  SavedRecipe({
    required this.id,
    required this.userId,
    required this.recipeId,
    required this.savedAt,
  });

  /// Convert Firestore document → SavedRecipe object
  factory SavedRecipe.fromMap(Map<String, dynamic> data, String documentId) {
    return SavedRecipe(
      id: documentId,
      userId: data['userId'] ?? '',
      recipeId: data['recipeId'] ?? '',
      savedAt: (data['savedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Convert SavedRecipe object → Firestore map
  Map<String, dynamic> toMap() {
    return {'userId': userId, 'recipeId': recipeId, 'savedAt': savedAt};
  }
}
