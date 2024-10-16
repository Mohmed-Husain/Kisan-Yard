import 'package:flutter/material.dart';
import '../widgets/crop_card.dart';

class BiddingSpacePage extends StatelessWidget {
  final List<Map<String, String>> crops = [
    {'name': 'Wheat', 'startTime': 'Starts at 10 AM'},
    {'name': 'Rice', 'startTime': 'Starts at 11 AM'},
    {'name': 'Jawar', 'startTime': 'Starts at 12 PM'},
    {'name': 'Bajra', 'startTime': 'Starts at 1 PM'},
    {'name': 'Maize', 'startTime': 'Starts at 2 PM'},
    {'name': 'Cotton', 'startTime': 'Starts at 3 PM'},
    {'name': 'Sugarcane', 'startTime': 'Starts at 4 PM'},
    {'name': 'Potato', 'startTime': 'Starts at 5 PM'},
    {'name': 'Onion', 'startTime': 'Starts at 6 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAE0),
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color(0xFF3B3F2A),
          fontFamily: 'Serif',
          fontSize: 25.0, // Increase the text size
        ),
        title: const Text('Bidding Space'),
        backgroundColor: const Color(0xFF798645),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add search functionality here if needed
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Add filter functionality here if needed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: crops.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CropCard(
                cropName: crops[index]['name']!,
                startTime: crops[index]['startTime']!,
              ),
            );
          },
        ),
      ),
    );
  }
}
