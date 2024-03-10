import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlantInfoScreen extends StatefulWidget {
  @override
  _PlantInfoScreenState createState() => _PlantInfoScreenState();
}

class _PlantInfoScreenState extends State<PlantInfoScreen> {
  List<Map<String, dynamic>> plantInfo = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
    await http.get(Uri.parse('http://127.0.0.1:5000/get_plant_info'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        plantInfo = responseData.cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('Failed to load plant info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Info'),
      ),
      body: plantInfo.isEmpty
          ? Center(
          child:
          CircularProgressIndicator()) // Display loading indicator while fetching data
          : ListView.builder(
        itemCount: plantInfo.length,
        itemBuilder: (BuildContext context, int index) {
          final plant = plantInfo[index];
          return ListTile(
            title: Text('Common Name: ${plant['common_name']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Scientific Name: ${plant['scientific_name']}'),
                Text('Age Group: ${plant['age_group']}'),
                Text('Drug Content: ${plant['drug_content']}'),
                Text('Family: ${plant['family']}'),
                Text(
                    'Geographical Availability: ${plant['geographical_availability']}'),
                Text('Remedies: ${plant['remedies']}'),
                Text(
                    'Seasonal Availability: ${plant['seasonal_availability']}'),
                Text('Side Effects: ${plant['side_effects']}'),
                Text('Uses: ${plant['uses']}'),
              ],
            ),
            onTap: () {
              // Handle tap on the list item
            },
          );
        },
      ),
    );
  }
}
