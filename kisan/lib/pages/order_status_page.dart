import 'package:flutter/material.dart';
import 'dart:math';

class OrderStatusPage extends StatefulWidget {
  const OrderStatusPage({super.key});

  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  Map<String, dynamic>? orderData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    trackOrder(_generateRandomTrackingID());
  }

  String _generateRandomTrackingID() {
    final random = Random();
    return 'TRACK-${random.nextInt(100000)}';
  }

  Future<void> trackOrder(String id) async {
    setState(() {
      isLoading = true;
    });

    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock order data
    setState(() {
      orderData = {
        'order_id': id,
        'items': ['Fertilizer'],
        'status': 'In Transit',
        'estimated_delivery': 'October 15, 2024 - 5:00 PM',
        'progress': 3,
        'delivery': 'Jeet Residency, Plaj, Gandhinagar, Gujarat',
        'number': '1',
        'price': '500',
        'image_url': 'https://via.placeholder.com/300',
      };
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Status',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        backgroundColor: const Color(0xFF798645),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey.shade100, Colors.blueGrey.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (orderData != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Tracking Card
                    Card(
                      elevation: 8,
                      shadowColor: const Color(0xFF798645),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Details',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF798645),
                              ),
                            ),
                            const Divider(),
                            // Order ID
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Order ID: ${orderData!['order_id']}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            // Additional Image
                            Container(
                              width: double.infinity,
                              height: 150,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/calcium_nitrate.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Text(
                                        'Image not found',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Products and Details
                            Text(
                              'Products: ${orderData!['items'].join(', ')}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Quantity: ${orderData!['number']}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Price: ₹${orderData!['price']}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Icon(Icons.delivery_dining,
                                    color: Colors.green),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    'Recent Status: ${orderData!['status']}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.timer, color: Colors.orange),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    'Estimated Delivery: ${orderData!['estimated_delivery']}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Progress Bar
                            Container(
                              width: double.infinity,
                              height: 50,
                              margin: const EdgeInsets.only(top: 20),
                              child:
                                  ProgressBar(progress: orderData!['progress']),
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                Icon(Icons.location_city, color: Colors.green),
                                Text(
                                  'Delivery',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${orderData!['delivery']}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              else
                const Center(child: Text('Unable to fetch order details.')),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final int progress;
  const ProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStep('Order Confirmed', progress >= 1),
        _buildStep('Dispatched', progress >= 2),
        _buildStep('In Transit', progress >= 3),
        _buildStep('Out for Delivery', progress >= 4),
        _buildStep('Delivered', progress >= 5),
      ],
    );
  }

  Widget _buildStep(String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF798645) : Colors.grey[400],
            shape: BoxShape.circle,
          ),
          child: isActive
              ? const Icon(Icons.check, color: Colors.white, size: 8)
              : const SizedBox(),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF798645) : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
