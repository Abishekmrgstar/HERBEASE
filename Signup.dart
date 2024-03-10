import 'package:flutter/material.dart';
import 'Uploader.dart'; // Import the file where you want to navigate

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _signUp() {
    // Perform sign-up functionality
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Here, you would implement your sign-up logic
    // For demonstration, we'll just print the email and password
    print('Email: $email');
    print('Password: $password');
    print('Confirm Password: $confirmPassword');

    // After successful sign-up, navigate to another screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhotoUploader()), // Navigate to the UploaderPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Herbease', // Change text to Herbease
          style: TextStyle(
            color: Theme.of(context).primaryColor, // Use primaryColor as text color
          ),
        ),
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // Remove elevation
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Icon(
              Icons.eco,
              color: Colors.green.withOpacity(0.3), // Adjust opacity to increase darkness
              size: 300, // Adjust size as needed
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.lightGreen[200]!, // Lighter shade of green
                  Colors.lightGreen[100]!, // Lightest shade of green
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Herbease', // Change text to Herbease
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green[900], // Darker shade of green
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _signUp,
                  child: Text('Sign Up'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue), // Change button color to blue
                    textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}