class Category {
  final String id;
  final String name;
  final String iconUrl;

  Category({required this.id, required this.name, required this.iconUrl});

  Map<String, dynamic> toMap() {
    return {'name': name, 'iconUrl': iconUrl};
  }

  factory Category.fromMap(Map<String, dynamic> data, String documentId) {
    return Category(
      id: documentId,
      name: data['name'] ?? '',
      iconUrl: data['iconUrl'] ?? '',
    );
  }
}
