import 'package:flutter/material.dart';

class SeatButtons extends StatelessWidget {
  const SeatButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 64,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index % 8 == 3 || index % 8 == 4) {
            //for middle space
            return const SizedBox(width: 0);
          } else if (index == 0 || index == 7) {
            //for first and last squares of first row
            return const SizedBox(width: 0);
          } else if (index / 8 >= 3 && index / 8 < 4) {
            //for vertical gap
            return const SizedBox(width: 0);
          } else {
            return Icon(
              Icons.crop_square,
              size: 55,
              color: Theme.of(context).colorScheme.outline,
            );
          }
        },
      ),
    );
  }
}
