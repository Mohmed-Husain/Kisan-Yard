import 'package:flutter/material.dart';
import 'bidding_space_page.dart';
import 'kisan_mart_page.dart';
import 'crop_registration_page.dart';
import 'order_status_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BiddingSpacePage(),
    const KisanMartPage(),
    const CropRegistrationPage(cropName: 'DefaultCropName'),
    const OrderStatusPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
         backgroundColor: Colors.blue, // Set the background color of the nav bar
        selectedItemColor: Colors.white, // Set the color of the selected item
        unselectedItemColor: Colors.grey, // Set the color of unselected items (optional)
        
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Bidding Space'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Kisan Mart'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Crop Registration'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Order Status'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
