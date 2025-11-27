import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../services/category_service.dart';

class AdminCategoriesScreen extends StatelessWidget {
  const AdminCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Categories")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add-category');
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: CategoryService().getCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No categories found"));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;

              return ListTile(
                leading: Icon(
                  IconData(data["iconCode"], fontFamily: data["iconFamily"]),
                ),
                title: Text(data["name"]),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
