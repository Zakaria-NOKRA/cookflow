import 'package:flutter/material.dart';
import 'categories/admin_categories_screen.dart'; // <-- add this import

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double cardWidth = (MediaQuery.of(context).size.width - 48) / 2;

    return Scaffold(
      backgroundColor: const Color(0xff1e1f23),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff1e1f23),
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// SEARCH BAR
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xff2d2f33),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white70),
                  SizedBox(width: 10),
                  Text(
                    "Search admin tools...",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// SECTION TITLE
            const Text(
              "Management",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            /// RESPONSIVE WRAP GRID
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _adminCard(
                  width: cardWidth,
                  title: "Manage Recipes",
                  icon: Icons.restaurant_menu,
                  color: Colors.orange,
                  onTap: () {},
                ),
                _adminCard(
                  width: cardWidth,
                  title: "Manage Categories",
                  icon: Icons.list_alt,
                  color: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AdminCategoriesScreen(),
                      ),
                    );
                  },
                ),
                _adminCard(
                  width: cardWidth,
                  title: "Manage Users",
                  icon: Icons.people,
                  color: Colors.green,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// FIXED & RESPONSIVE ADMIN CARD
  Widget _adminCard({
    required double width,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xff2d2f33),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.25),
              radius: 28,
              child: Icon(icon, size: 28, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
