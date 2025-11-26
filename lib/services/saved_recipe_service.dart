import 'package:cloud_firestore/cloud_firestore.dart';

class SavedRecipeService {
  final CollectionReference savedRecipesRef = FirebaseFirestore.instance
      .collection('savedRecipes');

  /// Save a recipe for a user
  Future<void> saveRecipe(String userId, String recipeId) async {
    try {
      // Check if already saved
      final existing = await savedRecipesRef
          .where('userId', isEqualTo: userId)
          .where('recipeId', isEqualTo: recipeId)
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        print("Recipe already saved.");
        return;
      }

      await savedRecipesRef.add({
        'userId': userId,
        'recipeId': recipeId,
        'savedAt': Timestamp.now(),
      });

      print("Recipe saved successfully");
    } catch (e) {
      print("Error saving recipe: $e");
    }
  }

  /// Unsave a recipe
  Future<void> removeSavedRecipe(String userId, String recipeId) async {
    try {
      final query = await savedRecipesRef
          .where('userId', isEqualTo: userId)
          .where('recipeId', isEqualTo: recipeId)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        print("Recipe is not saved.");
        return;
      }

      await query.docs.first.reference.delete();

      print("Recipe unsaved successfully");
    } catch (e) {
      print("Error removing saved recipe: $e");
    }
  }

  /// Check if recipe is saved
  Future<bool> isRecipeSaved(String userId, String recipeId) async {
    try {
      final query = await savedRecipesRef
          .where('userId', isEqualTo: userId)
          .where('recipeId', isEqualTo: recipeId)
          .limit(1)
          .get();

      return query.docs.isNotEmpty;
    } catch (e) {
      print("Error checking saved recipe: $e");
      return false;
    }
  }

  /// Get all saved recipes of a user
  Future<List<String>> getUserSavedRecipeIds(String userId) async {
    try {
      final snapshot = await savedRecipesRef
          .where('userId', isEqualTo: userId)
          .orderBy('savedAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => doc['recipeId'] as String).toList();
    } catch (e) {
      print("Error fetching saved recipes: $e");
      return [];
    }
  }
}
