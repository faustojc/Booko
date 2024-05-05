import 'package:flutter/material.dart';

class ContentUnavailable extends StatelessWidget {
  final String message;
  final String imagePath;

  const ContentUnavailable({super.key, required this.message, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath),
        const SizedBox(height: 20),
        Text(message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}
