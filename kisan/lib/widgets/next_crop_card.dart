import 'package:flutter/material.dart';

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