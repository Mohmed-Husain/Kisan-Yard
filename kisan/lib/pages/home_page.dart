// home_page.dart
import 'package:flutter/material.dart';
import 'cart_page.dart'; // Import CartPage
import 'bidding_space_page.dart';
import 'kisan_mart_page.dart';
import 'crop_registration_page.dart';
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
    const CartPage(), // CartPage added here
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF626F47),
        selectedItemColor: const Color.fromARGB(255, 204, 200, 179),
        unselectedItemColor: const Color(0xFFFEFAE0),
        elevation: 10, // Adds a shadow effect to the bottom navigation
        type: BottomNavigationBarType.fixed, // Keeps all labels visible
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Bidding Space',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Kisan Mart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Crop Registration',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart', // Cart added here
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
