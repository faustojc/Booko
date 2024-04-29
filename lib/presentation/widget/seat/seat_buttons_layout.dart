import 'package:flutter/material.dart';

class SeatButtons extends StatelessWidget {
  const SeatButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        itemCount: 42,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Row(
              children: [
                Icon(
                  Icons.square_outlined,
                  size: 40,
                  color: Theme.of(context).colorScheme.outline,
                ),
                Icon(
                  Icons.square_outlined,
                  size: 40,
                  color: Theme.of(context).colorScheme.outline,
                ),
                Icon(
                  Icons.square_outlined,
                  size: 40,
                  color: Theme.of(context).colorScheme.outline,
                ),
                SizedBox(width: 50),
                Icon(
                  Icons.square_outlined,
                  size: 40,
                  color: Theme.of(context).colorScheme.outline,
                ),
                Icon(
                  Icons.square_outlined,
                  size: 40,
                  color: Theme.of(context).colorScheme.outline,
                ),
                Icon(
                  Icons.square_outlined,
                  size: 40,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
