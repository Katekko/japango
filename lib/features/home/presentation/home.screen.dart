import 'package:flutter/material.dart';

import '../../../functions/get_one_char.function.dart';
import '../../../widgets/card.widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CardWidget(character: getOneChar())),
    );
  }
}
