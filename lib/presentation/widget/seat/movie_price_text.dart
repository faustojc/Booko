import 'package:flutter/material.dart';

class MoviePriceText extends StatelessWidget {
  final num price;

  const MoviePriceText({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        const Text('Price: ₱ ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )),
        Text(
          price.toStringAsFixed(2),
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ]),
    );
  }
}
