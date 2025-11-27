import 'package:flutter/material.dart';
import '../screens/onboarding/welcome_screen.dart';
import '../screens/auth/choose_auth_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/admin/admin_home_screen.dart';
import '../screens/admin/categories/admin_categories_screen.dart';
import '../screens/admin/categories/add_category_screen.dart';

class AppRouter {
  static const String welcome = '/welcome';
  static const String chooseAuth = '/choose-auth';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String adminHome = '/admin-home';
  static const String adminCategories = '/admin-categories';
  static const String adminAddCategory = '/add-category';

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

      case adminHome:
        return MaterialPageRoute(builder: (_) => const AdminHomeScreen());

      case adminCategories:
        return MaterialPageRoute(builder: (_) => const AdminCategoriesScreen());

      case adminAddCategory:
        return MaterialPageRoute(builder: (_) => const AddCategoryScreen());

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
