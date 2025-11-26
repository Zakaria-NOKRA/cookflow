import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe.dart';

class RecipeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch ALL recipes
  Future<List<Recipe>> getAllRecipes() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('recipes')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map(
            (doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>, doc.id),
          )
          .toList();
    } catch (e) {
      print("Error fetching recipes: $e");
      return [];
    }
  }

  /// Fetch recipes by category ("Breakfast", "Dinner", "Healthy", etc.)
  Future<List<Recipe>> getRecipesByCategory(String category) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('recipes')
          .where('categories', arrayContains: category)
          .get();

      return snapshot.docs
          .map(
            (doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>, doc.id),
          )
          .toList();
    } catch (e) {
      print("Error fetching recipes by category: $e");
      return [];
    }
  }

  /// Fetch a single recipe by ID
  Future<Recipe?> getRecipe(String recipeId) async {
    try {
      DocumentSnapshot doc = await _db
          .collection('recipes')
          .doc(recipeId)
          .get();

      if (!doc.exists) return null;

      return Recipe.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      print("Error fetching recipe: $e");
      return null;
    }
  }

  /// Search recipes by title (basic)
  Future<List<Recipe>> searchRecipes(String query) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('recipes')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: "$query\uf8ff")
          .get();

      return snapshot.docs
          .map(
            (doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>, doc.id),
          )
          .toList();
    } catch (e) {
      print("Error searching recipes: $e");
      return [];
    }
  }

  /// Admin: add new recipe
  Future<void> addRecipe(Recipe recipe) async {
    try {
      await _db.collection('recipes').add(recipe.toMap());
    } catch (e) {
      print("Error adding recipe: $e");
    }
  }
}
