import 'package:cloud_firestore/cloud_firestore.dart';

class RegisteredCrop {
  String cropName;
  String minBid;
  String totalWeight;
  String state;
  String phoneNumber;
  DateTime timestamp;

  // Constructor
  RegisteredCrop({
    required this.cropName,
    required this.minBid,
    required this.totalWeight,
    required this.state,
    required this.phoneNumber,
    required this.timestamp,
  });

  // Factory constructor to create an instance from Firestore Document
  factory RegisteredCrop.fromFirestore(Map<String, dynamic> firestoreData) {
    return RegisteredCrop(
      cropName: firestoreData['cropName'] ?? '',
      minBid: firestoreData['minBid'] ?? '',
      totalWeight: firestoreData['totalWeight'] ?? '',
      state: firestoreData['state'] ?? '',
      phoneNumber: firestoreData['phoneNumber'] ?? '',
      timestamp: (firestoreData['timestamp'] as Timestamp).toDate(),
    );
  }

  // Method to convert the RegisteredCrop object to a Map (for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'cropName': cropName,
      'minBid': minBid,
      'totalWeight': totalWeight,
      'state': state,
      'phoneNumber': phoneNumber,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  // Method to save the RegisteredCrop object to Firestore
  Future<void> saveToFirestore() async {
    try {
      // Get a reference to the 'registered_crops' collection
      CollectionReference cropsCollection =
          FirebaseFirestore.instance.collection('registered_crops');

      // Add the RegisteredCrop data to Firestore
      await cropsCollection.add(toMap());

      print('Crop registered successfully!');
    } catch (e) {
      print('Failed to register crop: $e');
    }
  }
}
