import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> testFirebase() async {
    try {
      await FirebaseFirestore.instance.collection("test").doc("hello").set({
        "message": "Firebase is working!",
        "time": DateTime.now(),
      });
      print("🔥 Firebase write success!");
    } catch (e) {
      print("❌ Firebase error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CookFlow",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fastfood, size: 80, color: Colors.orange),
            const SizedBox(height: 20),
            const Text(
              "Welcome to CookFlow!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Press the button below to test Firebase.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: testFirebase,
              child: const Text("Test Firebase Write"),
            ),
          ],
        ),
      ),
    );
  }
}
