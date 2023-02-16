import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String character;
  const CardWidget({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          character,
          style: const TextStyle(fontSize: 200),
        ),
      ),
    );
  }
}
