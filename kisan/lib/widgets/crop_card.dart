import 'package:flutter/material.dart';
import '../pages/crop_detail_page.dart';

class CropCard extends StatelessWidget {
  final String cropName;
  final String startTime;

  const CropCard({required this.cropName, required this.startTime, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: InkWell(
        onTap: () {
          // Navigate to CropDetailPage when tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CropDetailPage(cropName: cropName),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(
                Icons.eco,
                color: Colors.green[800],
                size: 40,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cropName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    startTime,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
            ],
          ),
        ),
      ),
    );
  }
}
