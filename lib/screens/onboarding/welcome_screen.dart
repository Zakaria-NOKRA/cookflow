import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../navigation/app_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdecef), // soft pink background
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // IMAGE
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/images/welcome.png", // We'll add this later
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // SMALL TEXT
            const Text(
              "30+ premium recipes",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 10),

            // TITLE
            const Text(
              "Cook like\na chef",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 30),

            // BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    // Save onboarding as done
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('seenOnboarding', true);

                    // Navigate to choose auth screen
                    Navigator.pushNamed(context, AppRouter.chooseAuth);
                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
