import 'package:flutter/material.dart';

class CustomizationsScreen extends StatefulWidget {
  @override
  State<CustomizationsScreen> createState() => _CustomizationsScreenState();
}

class _CustomizationsScreenState extends State<CustomizationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF5757),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFFF5757),
        title: Text(
          'Customizations',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add customization widgets here in the future.
            ],
          ),
        ),
      ),
    );
  }
}