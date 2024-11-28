import 'package:flutter/material.dart';
import 'crop_farmers_page.dart';

class CropTypesPage extends StatefulWidget {
  const CropTypesPage({Key? key}) : super(key: key);

  @override
  _CropTypesPageState createState() => _CropTypesPageState();
}

class _CropTypesPageState extends State<CropTypesPage> {
  // Predefined list of crops
  final List<Map<String, String>> cropTypes = [
    {'name': 'Wheat', 'image': 'assets/images/wheat.jpg', 'description': 'Staple food grain.'},
    {'name': 'Rice', 'image': 'assets/images/rice.jpg', 'description': 'Grown in paddy fields.'},
    {'name': 'Jawar', 'image': 'assets/images/jawar.jpg', 'description': 'Rich in dietary fiber.'},
    {'name': 'Bajra', 'image': 'assets/images/bajra.jpg', 'description': 'Nutritious millet crop.'},
    {'name': 'Maize', 'image': 'assets/images/maize.jpg', 'description': 'Used for food and fodder.'},
    {'name': 'Cotton', 'image': 'assets/images/cotton.jpg', 'description': 'Essential for textiles.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAE0),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Bidding Space',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF798645),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        itemCount: cropTypes.length,
        itemBuilder: (context, index) {
          final crop = cropTypes[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CropFarmersPage(cropType: crop['name']!),
                    ),
                  );
                },
                child: Row(
                  children: [
                    // Crop Image
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: AssetImage(crop['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Crop Details
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              crop['name']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4A4A4A),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              crop['description']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Navigate Icon
                    const Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(Icons.arrow_forward_ios, color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
