import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BiddingSpacePage(),
    );
  }
}

class BiddingSpacePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kisan'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Implement notification functionality here
            },
          )
        ],
      ),
      body: ListView(
        children: [
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // Add navigation logic here
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Bidding Space',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Kisan Mart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
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

class CropCard extends StatelessWidget {
  final String cropName;
  final String startTime;

  const CropCard({required this.cropName, required this.startTime, Key? key}) : super(key: key);

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

  CropDetailPage({required this.cropName});

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

  NextCropCard({required this.farmerName, required this.cropName});

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
