import 'package:flutter/material.dart';
import 'GooglePayDetailsPage.dart'; // Import the new GooglePayDetailsPage

class InternetBankingOptionsPage extends StatelessWidget {
  final String googlePayImageUrl =
      'https://cdn-icons-png.flaticon.com/512/6124/6124998.png';

  const InternetBankingOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Select Internet Banking Option',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                googlePayImageUrl,
                height: 100,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const Text('Failed to load image');
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select a payment method for Internet Banking:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            _buildOption(context, 'Google Pay', Icons.payments),
            _buildOption(context, 'PhonePe', Icons.mobile_friendly),
            _buildOption(context, 'Paytm', Icons.money),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, String title, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        onTap: () {
          if (title == 'Google Pay') {
            // Navigate to GooglePayDetailsPage for Google Pay details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GooglePayDetailsPage(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Selected: $title'),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
      ),
    );
  }
}
