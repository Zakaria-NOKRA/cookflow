import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Create user in Firestore after Firebase Auth registration
  Future<void> createUser(String userId, String name, String email) async {
    try {
      await _db.collection('users').doc(userId).set({
        'name': name,
        'email': email,
        'preferences': {},
        'savedCount': 0,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print("User created successfully!");
    } catch (e) {
      print("Error creating user: $e");
    }
  }

  /// Fetch user profile from Firestore
  Future<AppUser?> getUser(String userId) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(userId).get();

      if (!doc.exists) {
        print("User not found.");
        return null;
      }

      print("User data: ${doc.data()}");

      return AppUser.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }

  /// Listen to user profile in real time
  Stream<AppUser?> streamUser(String userId) {
    return _db.collection('users').doc(userId).snapshots().map((snapshot) {
      if (!snapshot.exists) return null;
      return AppUser.fromMap(snapshot.data()!, snapshot.id);
    });
  }

  /// Update user preferences
  Future<void> updatePreferences(
    String userId,
    Map<String, dynamic> prefs,
  ) async {
    try {
      await _db.collection('users').doc(userId).update({
        'preferences': prefs,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print("Preferences updated!");
    } catch (e) {
      print("Error updating preferences: $e");
    }
  }

  /// Update user name
  Future<void> updateName(String userId, String name) async {
    try {
      await _db.collection('users').doc(userId).update({
        'name': name,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print("Name updated!");
    } catch (e) {
      print("Error updating name: $e");
    }
  }

  /// Increase savedCount when user saves a recipe
  Future<void> increaseSavedCount(String userId) async {
    try {
      await _db.collection('users').doc(userId).update({
        'savedCount': FieldValue.increment(1),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print("savedCount +1");
    } catch (e) {
      print("Error increasing savedCount: $e");
    }
  }

  /// Decrease savedCount when user removes a saved recipe
  Future<void> decreaseSavedCount(String userId) async {
    try {
      await _db.collection('users').doc(userId).update({
        'savedCount': FieldValue.increment(-1),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print("savedCount -1");
    } catch (e) {
      print("Error decreasing savedCount: $e");
    }
  }
}
