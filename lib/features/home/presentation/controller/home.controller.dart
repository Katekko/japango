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
  final totalQuestions = BehaviorSubject<int>.seeded(0);
  final totalWrongQuestions = BehaviorSubject<int>.seeded(0);
  final totalCorrectQuestions = BehaviorSubject<int>.seeded(0);
  final correctAnswer = BehaviorSubject<String>();

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
  Stream<int> get totalWrongQuestionsStream => totalWrongQuestions.stream;

  @override
  Stream<int> get totalCorrectQuestionsStream => totalCorrectQuestions.stream;

  @override
  Stream<String> get correctAnswerStream => correctAnswer.stream;

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
        final total = totalCorrectQuestions.value! + 1;
        totalCorrectQuestions.sink.add(total);
        getOneQuestion();
        final hiragana = kanaKit.toHiragana(answer.value!);
        Initializer.listCharacters.remove(hiragana);
      } else {
        final minor = currentQuestion.value!.remainingChances.value! - 1;
        currentQuestion.value!.remainingChances.sink.add(minor);
        if (minor == 0) {
          final total = totalWrongQuestions.value! + 1;
          totalWrongQuestions.sink.add(total);

          final romanji = kanaKit.toRomaji(currentQuestion.value!.char);
          correctAnswer.sink.add(romanji);
        }
      }
      answer.controller.text = '';
    }
  }

  @override
  void getAnotherQuestion() {
    correctAnswer.sink.add('');
    isTheCorrectAnswer.sink.add(true);
    getOneQuestion();
  }

  @override
  void dispose() {}
}
