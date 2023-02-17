import 'package:kana_kit/kana_kit.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/abstractions/field.interface.dart';
import '../../../domain/abstractions/controllers/home_controller.interface.dart';
import '../../../domain/models/card.model.dart';
import '../../../domain/usecases/get_one_question.usecase.dart';

mixin HomeStateMixin implements IHomeController {
  final kanaKit = const KanaKit();

  late final IField<String> answer;
  final isTheCorrectAnswer = BehaviorSubject<bool>();
  final currentQuestion = BehaviorSubject<CardModel>();
  final totalQuestions = BehaviorSubject<int>.seeded(0);
  final totalWrongQuestions = BehaviorSubject<int>.seeded(0);
  final totalCorrectQuestions = BehaviorSubject<int>.seeded(0);
  final correctAnswer = BehaviorSubject<String>();
  final remainingChances = BehaviorSubject<int>.seeded(3);

  late final GetOneQuestionUseCase getOneQuestionUseCase;

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
  Stream<int> get remainingChancesStream => remainingChances.stream;
}
