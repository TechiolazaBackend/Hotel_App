import 'package:flutter/material.dart';

class StoryMain extends StatelessWidget {
  final int index;

  StoryMain({required this.index});

  @override
  Widget build(BuildContext context) {
    // You can use different images for each index or the same image if needed.
    String imagePath = 'assets/loyaltybg.jpg'; // Replace this with your logic for different images

    return Scaffold(
      appBar: AppBar(
        title: Text('Story $index'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          child: Image.asset(imagePath),
          minScale: 0.1,
          maxScale: 4.0,
        ),
      ),
    );
  }
}
