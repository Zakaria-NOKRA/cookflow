import 'package:flutter/material.dart';
import '../../../utils/category_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // ⭐ For kIsWeb
import 'dart:typed_data'; // ⭐ Needed for web image memory

class AdminAddRecipeScreen extends StatefulWidget {
  const AdminAddRecipeScreen({super.key});

  @override
  State<AdminAddRecipeScreen> createState() => _AdminAddRecipeScreenState();
}

class _AdminAddRecipeScreenState extends State<AdminAddRecipeScreen> {
  /// FORM CONTROLLERS
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final videoUrlController = TextEditingController();
  final timeController = TextEditingController();
  final servingsController = TextEditingController();

  String difficulty = "Easy";

  /// CATEGORY SELECTION
  List<String> selectedCategories = [];

  List<CategoryIconOption> get allCategories => [
    ...mealTypeCategories,
    ...dietaryCategories,
    ...occasionCategories,
    ...popularCategories,
  ];

  /// MAIN IMAGE
  XFile? selectedImage;
  final ImagePicker picker = ImagePicker();

  Future<void> pickMainImage() async {
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() => selectedImage = img);
    }
  }

  /// Universal Image Loader (Mobile + Web)
  Widget buildImagePreview(XFile? file) {
    if (file == null) {
      return const Center(
        child: Text(
          "Tap to choose image",
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    if (kIsWeb) {
      // WEB fallback
      return FutureBuilder(
        future: file.readAsBytes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(snapshot.data as Uint8List, fit: BoxFit.cover),
          );
        },
      );
    }

    // MOBILE version
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(File(file.path), fit: BoxFit.cover),
    );
  }

  /// VIDEO PICKER — Safe for Web
  Future<void> pickVideo() async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Video picking not supported on web")),
      );
      return;
    }

    final vid = await picker.pickVideo(source: ImageSource.gallery);
    if (vid != null) {
      setState(() {
        videoUrlController.text = vid.path;
      });
    }
  }

  /// INGREDIENTS
  List<_IngredientInput> ingredients = [];

  /// STEPS
  List<_StepInput> steps = [];

  @override
  void initState() {
    super.initState();
    ingredients.add(_IngredientInput());
    steps.add(_StepInput());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1e1f23),
      appBar: AppBar(
        backgroundColor: const Color(0xff1e1f23),
        title: const Text("Add Recipe", style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Recipe Title"),
            _inputField(titleController),

            const SizedBox(height: 20),

            _sectionTitle("Description"),
            _inputField(descriptionController, maxLines: 4),

            const SizedBox(height: 20),

            /// MAIN IMAGE
            _sectionTitle("Main Image"),
            GestureDetector(
              onTap: pickMainImage,
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff2d2f33),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: buildImagePreview(selectedImage), // ⭐ Updated
              ),
            ),

            const SizedBox(height: 20),

            /// VIDEO URL + PICKER BUTTON
            _sectionTitle("Video URL"),
            Row(
              children: [
                Expanded(child: _inputField(videoUrlController)),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.video_library, color: Colors.white),
                  onPressed: pickVideo,
                ),
              ],
            ),

            const SizedBox(height: 20),

            _sectionTitle("Time & Servings"),
            Row(
              children: [
                Expanded(child: _inputField(timeController, hint: "Minutes")),
                const SizedBox(width: 12),
                Expanded(
                  child: _inputField(servingsController, hint: "Servings"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _sectionTitle("Difficulty"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xff2d2f33),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: difficulty,
                  dropdownColor: const Color(0xff2d2f33),
                  items: ["Easy", "Medium", "Hard"]
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => difficulty = v!),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// CATEGORIES
            _sectionTitle("Categories"),
            GestureDetector(
              onTap: () => _openCategorySelector(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xff2d2f33),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: selectedCategories.isEmpty
                      ? [
                          const Text(
                            "Tap to select categories",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ]
                      : selectedCategories.map((cat) {
                          final icon = allCategories
                              .firstWhere((c) => c.label == cat)
                              .icon;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(icon, size: 16, color: Colors.white),
                                const SizedBox(width: 6),
                                Text(
                                  cat,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// INGREDIENTS
            _sectionTitle("Ingredients"),
            Column(
              children: [
                for (int i = 0; i < ingredients.length; i++) _ingredientRow(i),
                _addButton("Add Ingredient", () {
                  setState(() => ingredients.add(_IngredientInput()));
                }),
              ],
            ),

            const SizedBox(height: 20),

            /// STEPS
            _sectionTitle("Steps"),
            Column(
              children: [
                for (int i = 0; i < steps.length; i++) _stepRow(i),
                _addButton("Add Step", () {
                  setState(() => steps.add(_StepInput()));
                }),
              ],
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () => _onSavePressed(context),
                child: const Text(
                  "Save Recipe (UI only)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------
  // SMALL REUSABLE WIDGETS
  // ---------------------------

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _inputField(
    TextEditingController controller, {
    int maxLines = 1,
    String? hint,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: const Color(0xff2d2f33),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _addButton(String text, VoidCallback onTap) {
    return TextButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  // ---------------------------
  // CATEGORY SELECTOR
  // ---------------------------

  void _openCategorySelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff1e1f23),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (_) {
        List<String> tempSelected = List.from(selectedCategories);

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Select Categories",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _categoryGroup(
                    "Meal Type",
                    mealTypeCategories,
                    tempSelected,
                    setModalState,
                  ),
                  const SizedBox(height: 16),

                  _categoryGroup(
                    "Dietary",
                    dietaryCategories,
                    tempSelected,
                    setModalState,
                  ),
                  const SizedBox(height: 16),

                  _categoryGroup(
                    "Occasions",
                    occasionCategories,
                    tempSelected,
                    setModalState,
                  ),
                  const SizedBox(height: 16),

                  _categoryGroup(
                    "Popular",
                    popularCategories,
                    tempSelected,
                    setModalState,
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        setState(() => selectedCategories = tempSelected);
                        Navigator.pop(context);
                      },
                      child: const Text("Done"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _categoryGroup(
    String title,
    List<CategoryIconOption> options,
    List<String> tempSelected,
    void Function(void Function()) update,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((cat) {
            final selected = tempSelected.contains(cat.label);

            return GestureDetector(
              onTap: () {
                update(() {
                  if (selected) {
                    tempSelected.remove(cat.label);
                  } else {
                    tempSelected.add(cat.label);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: selected ? Colors.redAccent : Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(cat.icon, color: Colors.white, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      cat.label,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ---------------------------
  // INGREDIENT ROW
  // ---------------------------

  Widget _ingredientRow(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff2d2f33),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: ingredients[index].name,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Ingredient name",
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() => ingredients.removeAt(index));
                },
                icon: const Icon(Icons.delete, color: Colors.white70),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              _qtyButton("-", () {
                setState(() {
                  ingredients[index].quantity -=
                      ingredients[index].incrementStep;
                  if (ingredients[index].quantity < 0) {
                    ingredients[index].quantity = 0;
                  }
                });
              }),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  ingredients[index].quantity.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              _qtyButton("+", () {
                setState(() {
                  ingredients[index].quantity +=
                      ingredients[index].incrementStep;
                });
              }),

              const Spacer(),

              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: const Color(0xff2d2f33),
                  value: ingredients[index].unit,
                  items: _units
                      .map(
                        (u) => DropdownMenuItem(
                          value: u,
                          child: Text(
                            u,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    setState(() => ingredients[index].unit = v!);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Wrap(
            spacing: 8,
            children: [
              _fractionButton("¼", 0.25, index),
              _fractionButton("½", 0.50, index),
              _fractionButton("¾", 0.75, index),
              _fractionButton("1", 1.0, index),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(String symbol, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(symbol, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _fractionButton(String label, double step, int index) {
    bool selected = ingredients[index].incrementStep == step;

    return GestureDetector(
      onTap: () {
        setState(() => ingredients[index].incrementStep = step);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.redAccent : Colors.white10,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ---------------------------
  // STEP ROW
  // ---------------------------

  Widget _stepRow(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff2d2f33),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Step ${index + 1}",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  setState(() => steps.removeAt(index));
                },
                icon: const Icon(Icons.delete, color: Colors.white70),
              ),
            ],
          ),

          TextField(
            controller: steps[index].description,
            maxLines: 3,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: "Describe this step...",
              hintStyle: TextStyle(color: Colors.white38),
              border: InputBorder.none,
            ),
          ),

          const SizedBox(height: 6),

          if (steps[index].image != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: buildImagePreview(steps[index].image), // ⭐ Updated
              ),
            ),

          TextButton.icon(
            onPressed: () async {
              final img = await picker.pickImage(source: ImageSource.gallery);
              if (img != null) {
                setState(() => steps[index].image = img);
              }
            },
            icon: const Icon(Icons.image, color: Colors.white),
            label: const Text(
              "Add Image",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------
  // SAVE (UI ONLY)
  // ---------------------------

  void _onSavePressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("UI done! Backend comes next.")),
    );
  }
}

// =====================================================
// MODELS
// =====================================================

class _IngredientInput {
  final TextEditingController name = TextEditingController();
  double quantity = 0;
  double incrementStep = 1;
  String unit = "g";
}

final List<String> _units = [
  "g",
  "kg",
  "ml",
  "L",
  "cup",
  "tbsp",
  "tsp",
  "piece",
];

class _StepInput {
  final TextEditingController description = TextEditingController();
  XFile? image;
}
