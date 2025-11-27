import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1e1f23),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              /// -----------------------
              /// USER AVATAR
              /// -----------------------
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade300,
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 16),

              /// -----------------------
              /// USER NAME (dummy for now)
              /// -----------------------
              const Text(
                "Guest User",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                "guest@example.com",
                style: TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 40),

              /// -----------------------
              /// OPTIONS LIST
              /// -----------------------
              _menuItem(
                icon: Icons.bookmark,
                title: "Saved Recipes",
                onTap: () {},
              ),
              _menuItem(icon: Icons.edit, title: "Edit Profile", onTap: () {}),
              _menuItem(icon: Icons.settings, title: "Settings", onTap: () {}),
              _menuItem(icon: Icons.logout, title: "Logout", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff2d2f33),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(title, style: const TextStyle(color: Colors.white)),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white54,
            size: 16,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
