import 'package:flutter/material.dart';

class BottomIcons extends StatelessWidget {
  const BottomIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(),
        Icon(
          Icons.facebook,
          color: Colors.blue,
          size: 45,
        ),
        Icon(
          Icons.apple,
          color: Colors.black,
          size: 45,
        ),
        Icon(
          Icons.telegram,
          color: Colors.blue,
          size: 45,
        ),
        Spacer()
      ],
    );
  }
}
