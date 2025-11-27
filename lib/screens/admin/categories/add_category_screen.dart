import 'package:flutter/material.dart';
import '../../../services/category_service.dart';
import '../../../utils/category_icons.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController nameController = TextEditingController();

  CategoryIconOption? selectedIcon;
  bool isLoading = false;

  final CategoryService _service = CategoryService();

  Future<void> _save() async {
    final name = nameController.text.trim();

    if (name.isEmpty || selectedIcon == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter name & icon")));
      return;
    }

    setState(() => isLoading = true);

    final error = await _service.addCategory(
      name: name,
      iconCode: selectedIcon!.icon.codePoint,
      iconFamily: selectedIcon!.icon.fontFamily!,
    );

    setState(() => isLoading = false);

    if (error == null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Category Added")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Category")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Category Name"),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<CategoryIconOption>(
              decoration: const InputDecoration(labelText: "Select Icon"),
              items: predefinedCategoryIcons.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Row(
                    children: [
                      Icon(option.icon),
                      const SizedBox(width: 10),
                      Text(option.label),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => selectedIcon = value),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Save Category"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
