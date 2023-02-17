import 'package:flutter/material.dart';
import 'package:japango/features/home/domain/abstractions/controllers/home_controller.interface.dart';
import 'package:japango/features/shared/view_controller.interface.dart';

class CardWidget extends ViewController<IHomeController> {
  final String character;
  const CardWidget({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: controller.isTheCorrectAnswerStream,
      initialData: true,
      builder: (_, snap) {
        return Card(
          elevation: 5,
          color: !snap.data! ? Colors.red.withOpacity(.1) : null,
          shadowColor: !snap.data! ? Colors.red : null,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              character,
              style: const TextStyle(fontSize: 200),
            ),
          ),
        );
      },
    );
  }
}
