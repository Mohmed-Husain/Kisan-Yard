import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/register_crop.dart';

class CropService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch crops data for a specific user and include user details
  Future<List<Map<String, dynamic>>> fetchCropsDataWithUserDetails(String userId) async {
    try {
      // Fetch crops associated with the given userId
      QuerySnapshot cropSnapshot = await _firestore
          .collection('registered_crops')
          .where('userId', isEqualTo: userId)
          .get();

      // Fetch user details from the 'users' collection
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        throw Exception('User details not found');
      }

      final userData = userDoc.data() as Map<String, dynamic>;

      // Merge crops data with user details
      List<Map<String, dynamic>> cropsWithUserDetails = cropSnapshot.docs.map((doc) {
        Map<String, dynamic> cropData = doc.data() as Map<String, dynamic>;
        return {
          'username': userData['username'],
          'email': userData['email'],
          ...cropData, // Include all crop fields
        };
      }).toList();

      return cropsWithUserDetails;
    } catch (e) {
      throw Exception('Error fetching crops and user details: $e');
    }
  }
}
