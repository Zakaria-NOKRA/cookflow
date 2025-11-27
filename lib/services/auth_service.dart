import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// REGISTER USER
  Future<String?> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      // 1️⃣ Create user in Firebase Auth
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      // 2️⃣ Save user data in Firestore
      await _db.collection("users").doc(uid).set({
        "uid": uid,
        "fullName": fullName,
        "email": email,
        "role": "user", // 👈 default role
        "createdAt": FieldValue.serverTimestamp(),
      });

      return null; // success → no error message
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Unexpected error: $e";
    }
  }

  /// LOGIN USER
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Unexpected error: $e";
    }
  }

  /// LOGOUT USER
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// GET CURRENT USER UID
  String? get uid => _auth.currentUser?.uid;

  /// CHECK IF LOGGED IN
  bool get isLoggedIn => _auth.currentUser != null;

  /// GET USER DATA FROM FIRESTORE
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    final uid = _auth.currentUser!.uid;
    return await _db.collection("users").doc(uid).get();
  }
}
