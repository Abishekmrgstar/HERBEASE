import 'dart:convert';
import 'dart:io'; // Import File and Directory classes
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PhotoUploader extends StatefulWidget {
  @override
  _PhotoUploaderState createState() => _PhotoUploaderState();
}

class _PhotoUploaderState extends State<PhotoUploader> {
  File? _image; // Declare File type variable for image
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path); // Create File object from pickedFile
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _storeImageAndDetectObjects(File imageFile) async {
    final Directory? downloadsDirectory = await getDownloadsDirectory();
    if (downloadsDirectory == null) {
      print('Error: Downloads directory not available');
      return;
    }

    final String imagePath = '${downloadsDirectory.path}/image.jpg';
    await imageFile.copy(imagePath);
    print('Image saved in Downloads directory: $imagePath');

    // Send image path to backend for object detection
    final url = 'http://127.0.0.1:5000/detect';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'image_path': imagePath}),
    );

    if (response.statusCode == 200) {
      print('Object detection completed and result stored');
      // Handle the response here, if needed
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('message')) {
        final String message = responseData['message'];
        print(message); // Print the message from the response

        // Assuming the detection results are saved to runs\detect\predict3
        final String detectionResultPath = 'runs/detect/predict3';
        // Load the labels if available
        final File labelsFile = File('$detectionResultPath/labels');
        if (labelsFile.existsSync()) {
          final List<String> labels = labelsFile.readAsLinesSync();
          print('Labels: $labels');
        }

        // Assuming the detection result images are saved with a specific naming convention
        final Directory detectionResultDir = Directory(detectionResultPath);
        if (detectionResultDir.existsSync()) {
          final List<File> detectionResultImages = detectionResultDir
              .listSync()
              .whereType<File>()
              .where((file) => file.path.endsWith('.png'))
              .toList();
          for (final File imageFile in detectionResultImages) {
            print('Detected image: ${imageFile.path}');
            // Handle the detected image as needed
          }
        } else {
          print('No detection results found.');
        }
      } else if (responseData.containsKey('error')) {
        final String error = responseData['error'];
        print('Error: $error'); // Print the error message from the response
      } else {
        print('Unexpected response: $responseData');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Photo Uploader',
          style: TextStyle(color: Colors.green[700]),
        ),
        backgroundColor: Colors.lightGreen[300],
      ),
      body: Center(
        child: _image == null
            ? Text(
          'No image selected.',
          style: TextStyle(color: Colors.green[700]),
        )
            : Image.file(_image!), // Use Image.file with the File object
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => getImage(ImageSource.camera),
            tooltip: 'Take Photo',
            child: Icon(Icons.camera, color: Colors.green[700]),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => getImage(ImageSource.gallery),
            tooltip: 'Select Image',
            child: Icon(Icons.image, color: Colors.green[700]),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              if (_image != null) {
                _storeImageAndDetectObjects(_image!);
              } else {
                print('No image selected.');
              }
            },
            tooltip: 'Save Image Locally and Detect Objects',
            child: Icon(Icons.save, color: Colors.green[700]),
          ),
        ],
      ),
    );
  }
}

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

      // After fetching the plant information, fetch detection results
      await fetchDetectionResults();
    } else {
      throw Exception('Failed to load plant info');
    }
  }

  Future<void> fetchDetectionResults() async {
    // Fetch the detection results from the server
    final response =
    await http.get(Uri.parse('http://127.0.0.1:5000/detection_results'));
    if (response.statusCode == 200) {
      final List<dynamic> detectionResults = json.decode(response.body);
      // Process the detection results here and update the UI if needed
      // Example: Display additional information about the detected plants
    } else {
      print('Failed to fetch detection results: ${response.statusCode}');
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
        child: CircularProgressIndicator(),
      ) // Display loading indicator while fetching data
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
                Text('Geographical Availability: ${plant['geographical_availability']}'),
                Text('Remedies: ${plant['remedies']}'),
                Text('Seasonal Availability: ${plant['seasonal_availability']}'),
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