import 'package:flutter/material.dart';
import '../screens/onboarding/welcome_screen.dart';
import '../screens/auth/choose_auth_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/home_screen.dart';

class AppRouter {
  static const String welcome = '/welcome';
  static const String chooseAuth = '/choose-auth';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case chooseAuth:
        return MaterialPageRoute(builder: (_) => const ChooseAuthScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text("Page Not Found")),
            body: const Center(
              child: Text(
                "404 - Route Not Found",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
    }
  }
}
