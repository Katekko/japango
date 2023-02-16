import 'package:flutter/material.dart';
import 'package:japango/features/home/domain/abstractions/home_controller.interface.dart';
import 'package:japango/features/home/domain/models/card.model.dart';
import 'package:japango/features/shared/text_field.widget.dart';
import 'package:japango/features/shared/view_controller.interface.dart';

import 'widgets/answer.button.dart';
import 'widgets/card.widget.dart';

class HomeScreen extends ViewStateController<IHomeController> {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.getOneQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<CardModel>(
              stream: widget.controller.currentQuestionStream,
              builder: (_, snap) {
                return CardWidget(character: snap.data?.char ?? '');
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * .3,
              child: TextFieldWidget(field: widget.controller.answerField),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: FancyButtonWidget(
                label: 'RESPONDER',
                onPressed: () => widget.controller.answerQuestion(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
