import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import '../models/register_crop.dart' as model;
import '../service/crop_bid_service.dart';

class CropDetailPage extends StatefulWidget {
  final model.RegisteredCrop crop;

  const CropDetailPage({required this.crop, super.key});

  @override
  _CropDetailPageState createState() => _CropDetailPageState();
}

class _CropDetailPageState extends State<CropDetailPage> {
  final TextEditingController _bidController = TextEditingController();

  // Helper method to get crop image
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

  void _submitBid() async {
    final cropService = CropBidService();
    final newBid = _bidController.text.trim();

    try {
      // Validate bid input
      if (newBid.isEmpty) {
        _showSnackBar('Please enter a bid amount.');
        return;
      }

      final newBidValue = double.tryParse(newBid);
      if (newBidValue == null) {
        _showSnackBar('Invalid bid amount. Please enter a valid number.');
        return;
      }

      final currentBidValue = double.tryParse(widget.crop.minBid) ?? 0.0;
      if (newBidValue <= currentBidValue) {
        _showSnackBar('Bid must be higher than the current minimum bid.');
        return;
      }

      // Update bid in Firestore
      await cropService.updateMinBid(
        crop: widget.crop,
        newBidAmount: newBid,
      );

      // Record bid history
      await cropService.recordBidHistory(
        cropId: widget.crop.documentId!,
        bidAmount: newBid,
        bidderId:
            'USER_ID', // Replace with the actual bidder's ID (e.g., Firebase UID)
      );

      // Show success message and reset input
      _showSnackBar('Bid placed successfully!');
      setState(() {
        widget.crop.minBid = newBid; // Update UI with the new minimum bid
      });
      _bidController.clear();
    } catch (e) {
      _showSnackBar('Failed to place bid: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAE0),
      appBar: AppBar(
        title: Text('${widget.crop.cropName} Details'),
        backgroundColor: const Color(0xFF798645),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Crop Image
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_getImageForCrop(widget.crop.cropName)),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    print('Error loading crop image: ${widget.crop.cropName}');
                  },
                ),
              ),
            ),

            // Crop Details Card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.crop.cropName} Details',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF798645),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow(
                        icon: Icons.monitor_weight_outlined,
                        label: 'Total Weight',
                        value: '${widget.crop.totalWeight} kg',
                      ),
                      _buildDetailRow(
                        icon: Icons.attach_money,
                        label: 'Current Minimum Bid',
                        value: '₹${widget.crop.minBid}',
                      ),
                      _buildDetailRow(
                        icon: Icons.location_on_outlined,
                        label: 'State',
                        value: widget.crop.state,
                      ),
                      _buildDetailRow(
                        icon: Icons.phone,
                        label: 'Contact Number',
                        value: widget.crop.phoneNumber,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bid Submission Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Place Your Bid',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF798645),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _bidController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.monetization_on_outlined),
                          labelText: 'Bid Amount',
                          hintText:
                              'Enter bid higher than ₹${widget.crop.minBid}',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _submitBid,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF798645),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Submit Bid',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper method to create consistent detail rows
  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF798645), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  @override
  void dispose() {
    _bidController.dispose();
    super.dispose();
  }
}
