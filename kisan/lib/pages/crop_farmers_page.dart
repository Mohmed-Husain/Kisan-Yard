import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/register_crop.dart';
import 'crop_detail_page.dart';

class CropFarmersPage extends StatefulWidget {
  final String cropType;

  const CropFarmersPage({Key? key, required this.cropType}) : super(key: key);

  @override
  _CropFarmersPageState createState() => _CropFarmersPageState();
}

class _CropFarmersPageState extends State<CropFarmersPage> {
  List<RegisteredCrop> crops = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchCrops();
  }

  Future<void> _fetchCrops() async {
    try {
      QuerySnapshot cropSnapshot = await FirebaseFirestore.instance
          .collection('registered_crops')
          .where('cropName', isEqualTo: widget.cropType)
          .get();

      setState(() {
        crops = cropSnapshot.docs
            .map((doc) => RegisteredCrop.fromFirestore(doc))
            .toList();

        crops.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _showBidDialog(RegisteredCrop crop) {
    final TextEditingController bidController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Place Bid for ${crop.cropName}'),
        content: TextField(
          controller: bidController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter bid higher than ₹${crop.minBid}',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final newBid = bidController.text.trim();

              if (newBid.isEmpty || double.tryParse(newBid) == null) {
                _showSnackBar('Please enter a valid bid amount.');
                return;
              }

              final newBidValue = double.parse(newBid);
              final currentBidValue = double.tryParse(crop.minBid) ?? 0.0;

              if (newBidValue <= currentBidValue) {
                _showSnackBar('Bid must be higher than ₹${crop.minBid}');
                return;
              }

              try {
                // Update Firestore
                await FirebaseFirestore.instance
                    .collection('registered_crops')
                    .doc(crop.documentId)
                    .update({'minBid': newBid});

                setState(() {
                  crop.minBid = newBid; // Update local UI
                });

                _showSnackBar('Bid placed successfully!');
                Navigator.pop(context);
              } catch (e) {
                _showSnackBar('Failed to place bid: $e');
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAE0),
      appBar: AppBar(
        title: Text('${widget.cropType} Farmers'),
        backgroundColor: const Color(0xFF798645),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : crops.isEmpty
                  ? Center(child: Text('No ${widget.cropType} crops available'))
                  : Column(
                      children: [
                        // Active Bid Section
                        if (crops.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(15),
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          _getImageForCrop(crops[0].cropName),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Active Bid: ${crops[0].cropName}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Minimum Bid: ₹${crops[0].minBid}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          'Available Weight: ${crops[0].totalWeight} kg',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () =>
                                                  _showBidDialog(crops[0]),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFF798645),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Text('Place Bid'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CropDetailPage(
                                                            crop: crops[0]),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'More Details',
                                                style: TextStyle(
                                                  color: Color(0xFF798645),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        // Other Crops List
                        Expanded(
                          child: ListView.builder(
                            itemCount: crops.length > 1 ? crops.length - 1 : 0,
                            itemBuilder: (context, index) {
                              final crop = crops[index + 1];

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                        _getImageForCrop(crop.cropName),
                                      ),
                                    ),
                                    title: Text(crop.cropName),
                                    subtitle: Text(
                                      'Min Bid: ₹${crop.minBid} | Weight: ${crop.totalWeight} kg',
                                    ),
                                    trailing: const Icon(Icons.arrow_forward_ios),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CropDetailPage(crop: crop),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
    );
  }

  String _getImageForCrop(String cropName) {
    switch (cropName.toLowerCase()) {
      case 'wheat':
        return 'assets/images/wheat.jpg';
      case 'rice':
        return 'assets/images/rice.jpg';
      case 'cotton':
        return 'assets/images/cotton.jpg';
      default:
        return 'assets/images/default_crop.jpg';
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black87,
      ),
    );
  }
}
