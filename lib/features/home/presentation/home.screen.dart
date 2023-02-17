import 'package:flutter/material.dart';
import 'package:japango/features/home/domain/abstractions/controllers/home_controller.interface.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: widget.controller.totalCorrectQuestionsStream,
                  initialData: 0,
                  builder: (_, snap) => Text(
                    '${snap.data!}',
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
                const SizedBox(width: 30),
                StreamBuilder(
                  stream: widget.controller.totalQuestionsStream,
                  initialData: 0,
                  builder: (_, snap) => Text('${snap.data!}'),
                ),
                const SizedBox(width: 30),
                StreamBuilder(
                  stream: widget.controller.totalWrongQuestionsStream,
                  initialData: 0,
                  builder: (_, snap) => Text(
                    '${snap.data!}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            StreamBuilder<CardModel>(
              stream: widget.controller.currentQuestionStream,
              builder: (_, snap) {
                return Column(
                  children: [
                    CardWidget(character: snap.data?.char ?? ''),
                    StreamBuilder<int>(
                      stream: snap.data?.remainingChances,
                      initialData: 0,
                      builder: (_, chancesSnap) {
                        return Text('Chances faltantes: ${chancesSnap.data}');
                      },
                    ),
                  ],
                );
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
              child: StreamBuilder<String>(
                stream: widget.controller.correctAnswerStream,
                initialData: '',
                builder: (_, snap) {
                  return Column(
                    children: [
                      Visibility(
                        visible: snap.data!.isNotEmpty,
                        child: Text('Resposta correta: ${snap.data!}'),
                      ),
                      const SizedBox(height: 20),
                      FancyButtonWidget(
                        label: snap.data!.isNotEmpty ? 'PROXIMA' : 'RESPONDER',
                        onPressed: snap.data!.isNotEmpty
                            ? widget.controller.getAnotherQuestion
                            : widget.controller.answerQuestion,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
