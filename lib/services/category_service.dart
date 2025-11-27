import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String?> addCategory({
    required String name,
    required int iconCode,
    required String iconFamily,
  }) async {
    try {
      await _db.collection("categories").add({
        "name": name,
        "iconCode": iconCode,
        "iconFamily": iconFamily,
        "createdAt": FieldValue.serverTimestamp(),
      });

      return null; // success
    } catch (e) {
      return e.toString();
    }
  }

  Stream<QuerySnapshot> getCategories() {
    return _db.collection("categories").orderBy("name").snapshots();
  }
}
