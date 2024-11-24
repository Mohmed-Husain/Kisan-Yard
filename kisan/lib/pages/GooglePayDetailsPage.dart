import 'package:flutter/material.dart';
//import 'internet_banking_page.dart';

class GooglePayDetailsPage extends StatefulWidget {
  const GooglePayDetailsPage({super.key});

  @override
  _GooglePayDetailsPageState createState() => _GooglePayDetailsPageState();
}

class _GooglePayDetailsPageState extends State<GooglePayDetailsPage> {
  final TextEditingController _upiController = TextEditingController();
  bool _isPayButtonEnabled = false;

  @override
  void dispose() {
    _upiController.dispose();
    super.dispose();
  }

  void _validateUPI() {
    setState(() {
      _isPayButtonEnabled = _upiController.text.isNotEmpty;
    });
  }

  void _processPayment() {
    // Placeholder for payment processing logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment initiated via UPI ID: ${_upiController.text}'),
        duration: const Duration(seconds: 2),
      ),
    );

    // Navigate back or to a success page
    Navigator.pop(context);
  }

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
          'Google Pay UPI Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your UPI ID for Google Pay:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _upiController,
              decoration: const InputDecoration(
                labelText: 'UPI ID',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _validateUPI(),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: _isPayButtonEnabled ? _processPayment : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Pay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
