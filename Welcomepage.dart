import 'package:flutter/material.dart';
import 'Login.dart'; // Import the HomeScreen class
import 'Signup.dart'; // Import the SignUpScreen class

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Icon(
              Icons.eco,
              color: Colors.green.withOpacity(0.3),
              size: 300,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'Herbease',
                  style: TextStyle(
                    fontFamily: 'YourCustomFont',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Login',
                      style: TextStyle(
                        color: Colors.green[900], // Change the color to dark green
                      ),),
                    onPressed: () {
                      // Navigate to the next screen when the Login button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()), // Use the HomeScreen class
                      );
                    },
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    child: Text('Sign Up',
                      style: TextStyle(
                        color: Colors.green[900], // Change the color to dark green
                      ),),
                    onPressed: () {
                      // Navigate to the next screen when the Sign Up button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()), // Use the SignUpScreen class
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 32),
            ],
          ),
        ],
      ),
    );
  }
}