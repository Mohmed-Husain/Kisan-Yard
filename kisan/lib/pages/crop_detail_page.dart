import 'package:flutter/material.dart';

class CropDetailPage extends StatelessWidget {
  final String cropName;

  const CropDetailPage({required this.cropName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kisan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$cropName: Farmer 1',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              color: Colors.grey[300],
              child: const Center(
                child: Text('Image Placeholder'),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Time Left: 15 minutes'),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bid Amount',
              ),
            ),
            const SizedBox(height: 10),
            const Text('Grade A crop'),
            const SizedBox(height: 20),
            const Text('Next Crop', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            NextCropCard(farmerName: 'Farmer 2', cropName: cropName),
            NextCropCard(farmerName: 'Farmer 3', cropName: cropName),
            const NextCropCard(farmerName: 'Header', cropName: 'Subhead'),
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
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(farmerName),
        subtitle: Text(cropName),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}
