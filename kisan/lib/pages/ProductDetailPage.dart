import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final String productName;
  final int productPrice;
  final String productImagePath;
  final String productDescription;

  const ProductDetailPage({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productImagePath,
    required this.productDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          color: Color(0xFF313423),
          fontFamily: 'Serif',
          fontSize: 25.0, // Increase the text size
        ),
        title: Text(productName),
        backgroundColor: const Color(0xFF626F47),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              productImagePath,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              productName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Rs. $productPrice/-',
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              productDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add to cart logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF798645),
                  textStyle: const TextStyle(color: Color(0xFFF2EED7)),
                ),
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
