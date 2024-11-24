import 'package:flutter/material.dart';

class CropProvider extends ChangeNotifier {
  final List<Map<String, String>> _crops = [
    {'name': 'Wheat', 'startTime': 'Starts at 10 AM'},
    {'name': 'Rice', 'startTime': 'Starts at 11 AM'},
    {'name': 'Jawar', 'startTime': 'Starts at 12 PM'},
    {'name': 'Bajra', 'startTime': 'Starts at 1 PM'},
    {'name': 'Maize', 'startTime': 'Starts at 2 PM'},
    {'name': 'Cotton', 'startTime': 'Starts at 3 PM'},
    {'name': 'Sugarcane', 'startTime': 'Starts at 4 PM'},
    {'name': 'Potato', 'startTime': 'Starts at 5 PM'},
    {'name': 'Onion', 'startTime': 'Starts at 6 PM'},
    // Add initial crops as needed
  ];

  List<Map<String, String>> get crops => List.unmodifiable(_crops);

  void addCrop(String name, String startTime) {
    _crops.add({'name': name, 'startTime': startTime});
    notifyListeners();
  }
}
