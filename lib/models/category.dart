class Category {
  final String id; // Category ID (e.g. "breakfast")
  final String name; // Display name (e.g. "Breakfast")
  final String iconUrl; // Small icon to display in UI

  Category({required this.id, required this.name, required this.iconUrl});

  /// Convert Firestore document → Category object
  factory Category.fromMap(Map<String, dynamic> data, String documentId) {
    return Category(
      id: documentId,
      name: data['name'] ?? '',
      iconUrl: data['iconUrl'] ?? '',
    );
  }

  /// Convert Category object → Firestore map
  Map<String, dynamic> toMap() {
    return {'name': name, 'iconUrl': iconUrl};
  }
}
