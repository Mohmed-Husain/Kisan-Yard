import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CropRegistrationPage extends StatefulWidget {
  final String cropName;

  const CropRegistrationPage({required this.cropName, super.key});

  @override
  _CropRegistrationPageState createState() => _CropRegistrationPageState();
}

class _CropRegistrationPageState extends State<CropRegistrationPage> {
  final TextEditingController _cropNameController = TextEditingController();
  final TextEditingController _minBidController = TextEditingController();
  final TextEditingController _totalWeightController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles;

  @override
  void initState() {
    super.initState();
    // Set the cropNameController with the passed cropName
    _cropNameController.text = widget.cropName;
  }

  void _registerCrop() {
    String cropName = _cropNameController.text;
    String minBid = _minBidController.text;
    String totalWeight = _totalWeightController.text;
    String address = _addressController.text;
    String phoneNumber = _phoneNumberController.text;

    print('Crop Name: $cropName');
    print('Min Bid: $minBid');
    print('Total Weight: $totalWeight');
    print('Address: $address');
    print('Phone Number: $phoneNumber');
    // Additional registration logic here
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
            TextField(
              controller: _cropNameController,
              decoration: const InputDecoration(
                labelText: 'Crop Name',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
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
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
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
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Upload Photos'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerCrop,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
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
