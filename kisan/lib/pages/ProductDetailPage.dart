import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final String name;
  final int price;
  final String imagePath;

  const ProductDetailPage({
    required this.name,
    required this.price,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Rs. $price/-', style: const TextStyle(fontSize: 20, color: Colors.red)),
            const SizedBox(height: 16),
            const Text('Availability', style: TextStyle(fontSize: 16)),
            const Text('In Stock', style: TextStyle(fontSize: 16, color: Colors.green)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Quantity', style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        // Handle quantity decrease
                      },
                    ),
                    const Text('1'), // Replace with actual quantity state
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // Handle quantity increase
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle add to cart
              },
              child: const Text('Add to cart'),
            ),
          ],
        ),
      ),
    );
  }
}
