import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String name;
  final String email;
  final Map<String, dynamic> preferences; // diet, lifestyle, allergies...
  final int savedCount; // total saved recipes
  final DateTime createdAt;
  final DateTime updatedAt;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.preferences,
    required this.savedCount,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convert Firestore document into AppUser object
  factory AppUser.fromMap(Map<String, dynamic> data, String documentId) {
    return AppUser(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      preferences: data['preferences'] ?? {},
      savedCount: data['savedCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Convert AppUser object into Firestore-friendly map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'preferences': preferences,
      'savedCount': savedCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// Useful when updating profile without overwriting everything
  AppUser copyWith({
    String? name,
    String? email,
    Map<String, dynamic>? preferences,
    int? savedCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppUser(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      preferences: preferences ?? this.preferences,
      savedCount: savedCount ?? this.savedCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
