import 'dart:math';

import 'package:japango/core/abstractions/field.interface.dart';
import 'package:japango/features/home/domain/abstractions/home_controller.interface.dart';
import 'package:japango/features/home/domain/models/card.model.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../initializer.dart';
import '../../domain/exceptions/small_character.exception.dart';

class HomeController implements IHomeController {
  final kanaKit = const KanaKit();

  final IField<String> answer;
  final isTheCorrectAnswer = BehaviorSubject<bool>();
  final currentQuestion = BehaviorSubject<CardModel>();
  final totalQuestions = BehaviorSubject<int>();

  HomeController({required this.answer});

  @override
  IField<String> get answerField => answer;

  @override
  Stream<bool> get isTheCorrectAnswerStream => isTheCorrectAnswer.stream;

  @override
  Stream<CardModel> get currentQuestionStream => currentQuestion.stream;

  @override
  Stream<int> get totalQuestionsStream => totalQuestions;

  @override
  void getOneQuestion() {
    final list = Initializer.listCharacters;

    final random = Random();
    var element = list[random.nextInt(list.length)];

    try {
      final romanji = kanaKit.toRomaji(element);
      if (kanaKit.isJapanese(romanji)) {
        throw SmallCharacterException();
      }

      final question = CardModel(element);
      currentQuestion.sink.add(question);
    } on SmallCharacterException catch (_) {
      Initializer.listCharacters.remove(element);
      getOneQuestion();
    }

    totalQuestions.sink.add(Initializer.listCharacters.length);
  }

  @override
  void answerQuestion() {
    if (answerField.validate()) {
      final isCorrect = currentQuestion.value!.isCorrect(answer.value!);
      isTheCorrectAnswer.sink.add(isCorrect);
      if (isCorrect) {
        getOneQuestion();
        final hiragana = kanaKit.toHiragana(answer.value!);
        Initializer.listCharacters.remove(hiragana);
        answer.controller.text = '';
      }
    }
  }

  @override
  void dispose() {}
}
