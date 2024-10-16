import 'package:flutter/material.dart';
import 'ProductDetailPage.dart';

class KisanMartPage extends StatelessWidget {
  const KisanMartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAE0),
      appBar: AppBar(
        titleTextStyle: const TextStyle(
        color: Color(0xFF3B3F2A),
        fontFamily: 'Serif',
        fontSize: 25.0, // Increase the text size
        ),
        title: const Text('KISANMART'),
        centerTitle: true,
        backgroundColor: const Color(0xFF798645),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Add profile action here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Shop by category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryCard(category: 'Protection', icon: Icons.shield),
                  CategoryCard(category: 'Seeds', icon: Icons.grass),
                  CategoryCard(category: 'Hardware', icon: Icons.build),
                  CategoryCard(category: 'Combo Kit', icon: Icons.build_circle),
                  CategoryCard(category: 'Nutrition', icon: Icons.local_florist),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Popularity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductDetailPage(
                          productName: 'Calcium Nitrate',
                          productPrice: 149,
                          productImagePath: 'assets/calcium_nitrate.png',
                          productDescription: 'Premium protection spray for plants.',
                        ),
                      ),
                    );
                  },
                  child: const ProductCard(
                    name: 'Calcium Nitrate',
                    price: 149,
                    imagePath: 'assets/calcium_nitrate.png',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductDetailPage(
                          productName:'Battery Sprayer',
                          productPrice: 4999,
                          productImagePath: 'assets/battery_sprayer.png',
                          productDescription: 'High-performance organic pesticide.',
                        ),
                      ),
                    );
                  },
                  child: const ProductCard(
                    name: 'Battery Sprayer',
                    price: 4999,
                    imagePath: 'assets/battery_sprayer.png',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductDetailPage(
                          productName: 'Tomato Seeds',
                          productPrice: 79,
                          productImagePath: 'assets/tomato_seeds.png',
                          productDescription: 'Advanced seed treatment solution.',
                        ),
                      ),
                    );
                  },
                  child: const ProductCard(
                    name: 'Tomato Seeds',
                    price: 79,
                    imagePath: 'assets/tomato_seeds.png',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductDetailPage(
                          productName: 'Sickle',
                          productPrice: 249,
                          productImagePath: 'assets/sickle.png',
                          productDescription: 'Heavy-duty hardware for agricultural use.',
                        ),
                      ),
                    );
                  },
                  child: const ProductCard(
                    name: 'Sickle',
                    price: 249,
                    imagePath: 'assets/sickle.png',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final IconData icon;

  const CategoryCard({required this.category, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFEEEEEE),
            child: Icon(icon, size: 30, color: Colors.red),
          ),
          const SizedBox(height: 8),
          Text(category, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final String imagePath;

  const ProductCard({
    required this.name,
    required this.price,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Rs. $price/-', style: const TextStyle(fontSize: 14, color: Colors.red)),
          ),
        ],
      ),
    );
  }
}