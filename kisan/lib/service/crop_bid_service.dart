import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisan/models/register_crop.dart';


class CropBidService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Singleton pattern for service
  static final CropBidService _instance = CropBidService._internal();
  factory CropBidService() => _instance;
  CropBidService._internal();

  // Method to update minimum bid
  Future<void> updateMinBid({
    required RegisteredCrop crop, 
    required String newBidAmount
  }) async {
    try {
      // Validate document ID
      if (crop.documentId == null || crop.documentId!.trim().isEmpty) {
        throw ArgumentError('Invalid crop document ID');
      }

      // Parse and validate bid amounts
      double currentBid = double.tryParse(crop.minBid) ?? 0.0;
      double newBidValue = double.tryParse(newBidAmount) ?? 0.0;

      // Bid validation
      if (newBidValue <= currentBid) {
        throw ArgumentError('New bid must be higher than current bid');
      }

      // Get reference to the specific crop document
      DocumentReference cropDocRef = 
        _firestore.collection('registered_crops').doc(crop.documentId!.trim());

      // Prepare update data
      final updateData = {
        'minBid': newBidAmount,
        'bidTimestamp': FieldValue.serverTimestamp(),
      };

      // Perform the update
      await cropDocRef.update(updateData);

      print('Bid successfully updated to $newBidAmount');
    } catch (e) {
      print('Bid update failed: $e');
      rethrow;
    }
  }

  // Method to fetch crops by type with real-time updates
  Stream<List<RegisteredCrop>> getCropsByType(String cropType) {
    return _firestore
      .collection('registered_crops')
      .where('cropName', isEqualTo: cropType)
      .snapshots()
      .map((snapshot) => snapshot.docs
        .map((doc) => RegisteredCrop.fromFirestore(doc))
        .toList());
  }

  // Method for bid history tracking
  Future<void> recordBidHistory({
    required String cropId, 
    required String bidAmount, 
    required String bidderId
  }) async {
    try {
      // Validate input parameters
      if (cropId.trim().isEmpty || bidAmount.trim().isEmpty || bidderId.trim().isEmpty) {
        throw ArgumentError('All bid history parameters must be non-empty');
      }

      await _firestore.collection('bid_history').add({
        'cropId': cropId.trim(),
        'bidAmount': bidAmount.trim(),
        'bidderId': bidderId.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('Bid history recorded successfully');
    } catch (e) {
      print('Failed to record bid history: $e');
      rethrow;
    }
  }
}