import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisan/models/register_crop.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'dart:io';

class CropRegistrationPage extends StatefulWidget {
  final String cropName;

  const CropRegistrationPage({required this.cropName, super.key});

  @override
  _CropRegistrationPageState createState() => _CropRegistrationPageState();
}

class _CropRegistrationPageState extends State<CropRegistrationPage> {
  final TextEditingController _minBidController = TextEditingController();
  final TextEditingController _totalWeightController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles;

  String? _selectedState;
  String? _selectedCrop;

  final List<String> crops = ['Wheat', 'Rice', 'Jowar', 'Bajra'];
  final List<String> states = ['Gujarat', 'Maharashtra', 'Rajasthan', 'Punjab', 'Tamil Nadu'];

  @override
  void initState() {
    super.initState();
    // Set the initial selected crop if it's in the crops list; otherwise, default to the first crop.
    _selectedCrop = crops.contains(widget.cropName) ? widget.cropName : crops.first;
  }


Future<List<String>> _uploadImages() async {
  List<String> imageUrls = [];
  try {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('No authenticated user found');
      return imageUrls;
    }

    if (_imageFiles != null && _imageFiles!.isNotEmpty) {
      for (var file in _imageFiles!) {
        File imageFile = File(file.path);
        
        if (!await imageFile.exists()) {
          print('File does not exist: ${file.path}');
          continue;
        }

        String fileName = 'crop_images/${currentUser.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg';
        
        try {
          // Use ref() instead of reference()
          Reference storageReference = FirebaseStorage.instance.ref().child(fileName);

          UploadTask uploadTask = storageReference.putFile(
            imageFile,
            SettableMetadata(
              contentType: 'image/jpeg',
            ),
          );

          TaskSnapshot snapshot = await uploadTask;
          
          String downloadUrl = await snapshot.ref.getDownloadURL();
          imageUrls.add(downloadUrl);
          print('Successfully uploaded: $downloadUrl');
        } on FirebaseException catch (e) {
          print('Firebase Storage Error: ${e.code} - ${e.message}');
        }
      }
    }
  } catch (e) {
    print('Unexpected error in image upload: $e');
  }
  
  return imageUrls;
}


void _registerCrop() async {
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
  List<String> imageUrls = await _uploadImages();

  try {
    // Save data to Firestore
    CollectionReference cropsCollection =
        FirebaseFirestore.instance.collection('registered_crops');

    await cropsCollection.add({
      'cropName': cropName,
      'minBid': minBid,
      'totalWeight': totalWeight,
      'state': address,
      'phoneNumber': phoneNumber,
      'timestamp': FieldValue.serverTimestamp(), // Optional: Adds timestamp
      'userId': userId, // Add user ID to the document
      'imageUrls': imageUrls, // Add image URLs to the document
    });

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


  Future<void> _pickImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      setState(() {
        _imageFiles = pickedFiles;
      });
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.cropName} Registration'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Dropdown for Crop Name
            DropdownButtonFormField<String>(
              value: _selectedCrop,
              decoration: const InputDecoration(
                labelText: 'Select Crop',
                border: OutlineInputBorder(),
              ),
              items: crops.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCrop = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _minBidController,
              decoration: const InputDecoration(
                labelText: 'Minimum Bid',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _totalWeightController,
              decoration: const InputDecoration(
                labelText: 'Total Weight',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Dropdown for State
            DropdownButtonFormField<String>(
              value: _selectedState,
              decoration: const InputDecoration(
                labelText: 'Select State',
                border: OutlineInputBorder(),
              ),
              items: states.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedState = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _pickImages,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF798645),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Upload Photos'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _registerCrop,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF798645),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Register'),
            ),
            const SizedBox(height: 20),

            _imageFiles != null && _imageFiles!.isNotEmpty
                ? Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _imageFiles!.map((file) {
                      return Image.file(
                        File(file.path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  )
                : const Text('No images selected'),
          ],
        ),
      ),
    );
  }
}
