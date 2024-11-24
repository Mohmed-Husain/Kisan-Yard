import 'package:flutter/material.dart';
import 'payment_details_page.dart';
import 'internet_banking_page.dart';

class PaymentPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems; // Add cartItems parameter

  const PaymentPage({super.key, required this.cartItems}); // Constructor

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedMethod = '';

  // Function to calculate the total bill
  int calculateTotalBill() {
    return widget.cartItems.fold(0, (sum, item) => sum + item['totalPrice'] as int);
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total items and total bill
    final totalItems = widget.cartItems.length;
    final totalBill = calculateTotalBill();

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
          'Payment Method',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary Section
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];
                  return Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name: ${item['name']}'),
                                Text('Quantity: ${item['quantity']}'),
                                Text('Price: Rs. ${item['price']}'),
                                Text('Total: Rs. ${item['totalPrice']}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        item['image'],
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Bill: ₹$totalBill',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select one of the payment methods',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            _buildPaymentOption('Credit Card', Icons.credit_card),
            _buildPaymentOption('Internet Banking', Icons.account_balance),
            _buildPaymentOption('PayPal', Icons.payment),
            _buildPaymentOption('Bitcoin Wallet', Icons.account_balance_wallet),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF798645),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (selectedMethod == 'Internet Banking') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InternetBankingOptionsPage(),
                      ),
                    );
                  } else if (selectedMethod.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentDetailsPage(paymentMethod: selectedMethod),
                      ),
                    );
                  }
                },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: RadioListTile(
        title: Row(
          children: [
            Icon(icon, color: const Color(0xFF798645)),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
        value: title,
        groupValue: selectedMethod,
        onChanged: (value) {
          setState(() {
            selectedMethod = value.toString();
          });
        },
      ),
    );
  }
}
