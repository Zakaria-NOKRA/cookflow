import 'package:flutter/material.dart';
import '../profile/profile_screen.dart';
import 'home_main_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final List<Widget> _pages = [
    const HomeMainContent(), // Discover section
    const Center(
      child: Text("Community Page", style: TextStyle(color: Colors.white)),
    ),
    const ProfileScreen(), // Profile screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1e1f23),

      body: _pages[_index],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff1e1f23),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        currentIndex: _index,
        onTap: (i) {
          setState(() => _index = i);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Discover"),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: "Community",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
