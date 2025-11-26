import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Stream to listen to login/logout status
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Register a new user with email + password
  Future<AppUser?> register(String name, String email, String password) async {
    try {
      // Create user in Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = result.user!;

      // Create user document in Firestore
      AppUser newUser = AppUser(
        id: user.uid,
        name: name,
        email: email,
        preferences: {}, // empty until onboarding
        savedCount: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _db.collection('users').doc(user.uid).set(newUser.toMap());

      return newUser;
    } catch (e) {
      print("Registration error: $e");
      return null;
    }
  }

  /// Login with email + password
  Future<AppUser?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = result.user!;
      return await getUserProfile(user.uid);
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }

  /// Logout user
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// Fetch user profile from Firestore
  Future<AppUser?> getUserProfile(String userId) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(userId).get();

      if (doc.exists) {
        return AppUser.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      print("Profile fetch error: $e");
      return null;
    }
  }
}
