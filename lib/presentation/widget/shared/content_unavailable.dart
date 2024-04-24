import 'package:flutter/material.dart';

class ContentUnavailable extends StatelessWidget {
  final String message;

  const ContentUnavailable({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/content/no-movies.png"),
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
