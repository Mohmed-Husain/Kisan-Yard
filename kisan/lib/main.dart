// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kisan',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BiddingSpacePage(),
    KisanMartPage(),
    CropRegistrationPage(),
    OrderStatusPage(),
    ProfilePage(),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Bidding Space',
            backgroundColor:
                Colors.lightBlue, // Optional for visual enhancement
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
            icon: Icon(Icons.receipt_long),
            label: 'Order Status',
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

class BiddingSpacePage extends StatelessWidget {
  const BiddingSpacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kisan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Implement notification functionality here
            },
          )
        ],
      ),
      body: ListView(
        children: const [
          CropCard(
            cropName: 'Wheat',
            startTime: 'Starts Today 9 am',
          ),
          CropCard(
            cropName: 'Rice',
            startTime: 'Starts Tomorrow 9 am',
          ),
          CropCard(
            cropName: 'Jowar',
            startTime: 'Coming Soon',
          ),
          CropCard(
            cropName: 'Bajra',
            startTime: 'Coming Soon',
          ),
          CropCard(
            cropName: 'Cotton',
            startTime: 'Coming Soon',
          ),
        ],
      ),
    );
  }
}

class CropCard extends StatelessWidget {
  final String cropName;
  final String startTime;

  const CropCard({required this.cropName, required this.startTime, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(cropName, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(startTime),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CropDetailPage(cropName: cropName)),
          );
        },
      ),
    );
  }
}

class CropDetailPage extends StatelessWidget {
  final String cropName;

  const CropDetailPage({required this.cropName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kisan'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$cropName: Farmer 1',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              color: Colors.grey[300],
              child: Center(
                child: Text('Image Placeholder'),
              ),
            ),
            SizedBox(height: 20),
            Text('Time Left: 15 minutes'),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bid Amount',
              ),
            ),
            SizedBox(height: 10),
            Text('Grade A crop'),
            SizedBox(height: 20),
            Text('Next Crop', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            NextCropCard(farmerName: 'Farmer 2', cropName: cropName),
            NextCropCard(farmerName: 'Farmer 3', cropName: cropName),
            NextCropCard(farmerName: 'Header', cropName: 'Subhead'),
          ],
        ),
      ),
    );
  }
}

class NextCropCard extends StatelessWidget {
  final String farmerName;
  final String cropName;

  const NextCropCard({required this.farmerName, required this.cropName, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(farmerName),
        subtitle: Text(cropName),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}

class KisanMartPage extends StatelessWidget {
  const KisanMartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kisan Mart'),
      ),
      body: const Center(
        child: Text('Welcome to Kisan Mart!'),
      ),
    );
  }
}

class CropRegistrationPage extends StatefulWidget {
  const CropRegistrationPage({super.key});

  @override
  _CropRegistrationPageState createState() => _CropRegistrationPageState();
}

class _CropRegistrationPageState extends State<CropRegistrationPage> {
  final TextEditingController _cropNameController = TextEditingController();
  final TextEditingController _minBidController = TextEditingController();
  final TextEditingController _totalWeightController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles;

  void _registerCrop() {
    String cropName = _cropNameController.text;
    String minBid = _minBidController.text;
    String totalWeight = _totalWeightController.text;
    String address = _addressController.text;
    String phoneNumber = _phoneNumberController.text;

    print('Crop Name: $cropName');
    print('Min Bid: $minBid');
    print('Total Weight: $totalWeight');
    print('Address: $address');
    print('Phone Number: $phoneNumber');
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      setState(() {
        _imageFiles = pickedFiles;
      });
        } catch (e) {
      print('Error picking images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Registration'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _cropNameController,
              decoration: const InputDecoration(
                labelText: 'Crop Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _minBidController,
              decoration: const InputDecoration(
                labelText: 'Min Bid',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _totalWeightController,
              decoration: const InputDecoration(
                labelText: 'Total Weight',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImages,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Background color
                minimumSize: const Size(double.infinity, 50), // Button height
              ),
              child: Text('Upload Photos'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerCrop,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Background color
                minimumSize: const Size(double.infinity, 50), // Button height
              ),
              child: Text('Register'),
            ),
            const SizedBox(height: 20),
            _imageFiles != null
                ? Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _imageFiles!.map((file) {
                      return Image.file(
                        File(file.path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class OrderStatusPage extends StatelessWidget {
  const OrderStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Status'),
      ),
      body: const Center(
        child: Text('Check your order status here!'),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('View your profile and settings here!'),
      ),
    );
  }
}


// sneh changes