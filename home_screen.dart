import 'package:flutter/material.dart';
import 'package:efgh/Uploader.dart'; // Import your PlantInfoScreen.dart file

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body:
      PlantInfoScreen(), // Assuming PlantInfoScreen is the main screen you want to display
    );
  }
}