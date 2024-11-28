import 'package:flutter/material.dart';
import '../pages/crop_detail_page.dart';
import '../models/register_crop.dart';

class CropCard extends StatelessWidget {
  final RegisteredCrop crop;

  const CropCard({required this.crop, super.key});

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
              builder: (context) => CropDetailPage(crop: crop),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(
                Icons.eco,
                color: const Color(0xFF798645),
                size: 40,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crop.cropName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF626F47),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Min Bid: ${crop.minBid}',
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