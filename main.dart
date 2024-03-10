import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:efgh/home_screen.dart'; // Import your HomeScreen.dart file
import 'package:efgh/Welcomepage.dart'; // Import your WelcomePage.dart file

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Info App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage() // Set WelcomePage as the initial screen
    );
  }
}
