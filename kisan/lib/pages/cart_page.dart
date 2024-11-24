import 'package:flutter/material.dart';
import 'cart_items.dart'; // Import the global cart list
import 'payment_page.dart'; // Import the updated PaymentPage

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // Function to calculate the total price of all items in the cart
  double calculateCartTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item['totalPrice']; // Use the totalPrice for each item
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFF798645),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty!'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: Image.asset(
                            item['image'],
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item['name']),
                          subtitle: Text(
                            'Rs. ${item['price']} x ${item['quantity']} = Rs. ${item['totalPrice']}', // Show item price, quantity, and total price
                          ),
                          trailing: TextButton(
                            onPressed: () {
                              // Remove item from cart
                              cartItems.removeAt(index);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Item removed from cart'),
                                  duration: Duration(seconds: 2),
                                ),
                              );

                              // Refresh the UI
                              (context as Element).markNeedsBuild();
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Remove'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Total cart price widget
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rs. ${calculateCartTotal().toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Confirm Order Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Pass cart details to PaymentPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PaymentPage(cartItems: cartItems),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF798645),
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                          ),
                          child: const Text(
                            'Confirm Order',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
