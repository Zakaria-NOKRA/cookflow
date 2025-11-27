import 'package:flutter/material.dart';

class HomeMainContent extends StatelessWidget {
  const HomeMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ----------------------------------
            /// TOP AVATAR + SEARCH BAR
            /// ----------------------------------
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  child: Image.asset("assets/images/welcome.png"),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xff2d2f33),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.white70),
                        SizedBox(width: 8),
                        Text(
                          "Search for recipes",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// ----------------------------------
            /// WELCOME TITLE
            /// ----------------------------------
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "WELCOME TO",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "CookFlow",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const Text(
              "Here’s what we recommend for you!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),

            /// ----------------------------------
            /// GRID OF RECIPES
            /// ----------------------------------
            GridView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.70,
              ),
              itemBuilder: (context, index) {
                return _recipeCard(
                  image: "assets/images/welcome.png",
                  title: index == 0
                      ? "Garlic Shrimp Pasta"
                      : index == 1
                      ? "Energy Bites"
                      : index == 2
                      ? "Vegan Pancakes"
                      : "Red Velvet Cookies",
                  time: ["30 mins", "15 mins", "35 mins", "25 mins"][index],
                  rating: ["97%", "95%", "96%", "92%"][index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ----------------------------------
  /// RECIPE CARD WIDGET
  /// ----------------------------------
  Widget _recipeCard({
    required String image,
    required String title,
    required String time,
    required String rating,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff2d2f33),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "$time • 👍 $rating",
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),

          const SizedBox(height: 6),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
