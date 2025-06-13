import 'package:flutter/material.dart';

class StoryMain extends StatelessWidget {
  final int index;

  StoryMain({required this.index});

  @override
  Widget build(BuildContext context) {
    // Example: Use different images for each index if you have multiple story images
    // You can expand this logic with a list of image paths if desired.
    String imagePath = 'assets/loyaltybg.jpg'; // Default image
    // Example for multiple images:
    // List<String> images = [
    //   'assets/story1.jpg',
    //   'assets/story2.jpg',
    //   'assets/story3.jpg',
    //   ...
    // ];
    // String imagePath = images[index % images.length];

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