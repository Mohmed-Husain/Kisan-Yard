import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class RegisteredCrop {
  String? documentId; // New field to store Firestore document ID
  String cropName;
  String minBid;
  String totalWeight;
  String state;
  String phoneNumber;
  DateTime timestamp;
  List<String> imageUrls; // Added to store image URLs

  // Constructor
  RegisteredCrop({
    this.documentId, // Optional since it's not always available during creation
    required this.cropName,
    required this.minBid,
    required this.totalWeight,
    required this.state,
    required this.phoneNumber,
    required this.timestamp,
    required this.imageUrls, // Pass image URLs
  });

  // Factory constructor to create an instance from Firestore Document
  factory RegisteredCrop.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> firestoreData = doc.data() as Map<String, dynamic>;
    return RegisteredCrop(
      documentId: doc.id, // Use the Firestore document ID
      cropName: firestoreData['cropName'] ?? '',
      minBid: firestoreData['minBid'] ?? '',
      totalWeight: firestoreData['totalWeight'] ?? '',
      state: firestoreData['state'] ?? '',
      phoneNumber: firestoreData['phoneNumber'] ?? '',
      timestamp: (firestoreData['timestamp'] as Timestamp).toDate(),
      imageUrls: List<String>.from(firestoreData['imageUrls'] ?? []), // Fetch image URLs
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
      'imageUrls': imageUrls, // Save image URLs
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

  // Method to upload images and return their URLs
  static Future<List<String>> _uploadImages(List<XFile>? imageFiles) async {
    List<String> imageUrls = [];
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('No authenticated user found');
        return imageUrls;
      }

      // Ensure there are files to upload
      if (imageFiles != null && imageFiles.isNotEmpty) {
        for (var file in imageFiles) {
          File imageFile = File(file.path);

          // Check if the file exists
          if (!await imageFile.exists()) {
            print('File does not exist: ${file.path}');
            continue; // Skip this file and move to the next
          }

          // Generate a unique file name for Firebase Storage
          String fileName = 'crop_images/${currentUser.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg';

          try {
            // Firebase Storage reference to upload the image
            Reference storageReference = FirebaseStorage.instance.ref().child(fileName);

            // Upload task
            UploadTask uploadTask = storageReference.putFile(
              imageFile,
              SettableMetadata(contentType: 'image/jpeg'),
            );

            // Wait for the upload task to complete
            TaskSnapshot snapshot = await uploadTask;

            // Retrieve the download URL after upload
            String downloadUrl = await snapshot.ref.getDownloadURL();

            // Add the image URL to the list
            imageUrls.add(downloadUrl);
            print('Successfully uploaded: $downloadUrl');
          } on FirebaseException catch (e) {
            // Handle Firebase errors
            print('Firebase Storage Error: ${e.code} - ${e.message}');
          }
        }
      } else {
        print('No images selected for upload');
      }
    } catch (e) {
      // Handle unexpected errors
      print('Unexpected error in image upload: $e');
    }

    return imageUrls;
  }
}

// Function to handle crop registration
void _registerCrop(BuildContext context, List<XFile>? _imageFiles, TextEditingController _minBidController, TextEditingController _totalWeightController, TextEditingController _phoneNumberController, String? _selectedCrop, String? _selectedState) async {
  String cropName = _selectedCrop ?? 'Not Selected';
  String minBid = _minBidController.text;
  String totalWeight = _totalWeightController.text;
  String address = _selectedState ?? 'Not Selected';
  String phoneNumber = _phoneNumberController.text;

  // Get the current user ID from FirebaseAuth
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  print('Crop Name: $cropName');
  print('Min Bid: $minBid');
  print('Total Weight (Kg): $totalWeight');
  print('Address (State): $address');
  print('Phone Number: $phoneNumber');
  print('User ID: $userId'); // Print the user ID
  print('Image Files: $_imageFiles');

  // Upload images and get their URLs
  List<String> imageUrls = await RegisteredCrop._uploadImages(_imageFiles);

  try {
    // Create RegisteredCrop instance with the image URLs
    RegisteredCrop newCrop = RegisteredCrop(
      cropName: cropName,
      minBid: minBid,
      totalWeight: totalWeight,
      state: address,
      phoneNumber: phoneNumber,
      timestamp: DateTime.now(),
      imageUrls: imageUrls, // Pass image URLs to RegisteredCrop
    );

    // Save data to Firestore
    await newCrop.saveToFirestore();

    print('Crop registration successful!');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Crop registration successful!')),
    );
  } catch (e) {
    print('Failed to register crop: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to register crop.')),
    );
  }
}
