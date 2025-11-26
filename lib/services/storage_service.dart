import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload an image file and return public download URL
  Future<String?> uploadImage(File file, String recipeId) async {
    try {
      final String fileName =
          "recipes/images/$recipeId${p.extension(file.path)}";

      final ref = _storage.ref().child(fileName);

      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Image upload error: $e");
      return null;
    }
  }

  /// Upload a video file and return public download URL
  Future<String?> uploadVideo(File file, String recipeId) async {
    try {
      final String fileName =
          "recipes/videos/$recipeId${p.extension(file.path)}";

      final ref = _storage.ref().child(fileName);

      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Video upload error: $e");
      return null;
    }
  }

  /// Delete a stored file (image or video)
  Future<void> deleteFile(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (e) {
      print("Delete file error: $e");
    }
  }
}
