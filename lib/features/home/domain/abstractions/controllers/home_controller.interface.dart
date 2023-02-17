import 'package:japango/features/home/domain/models/card.model.dart';

import '../../../../../core/abstractions/controller.interface.dart';
import '../../../../../core/abstractions/field.interface.dart';

abstract class IHomeController extends IController {
  IField<String> get answerField;

  Stream<bool> get isTheCorrectAnswerStream;
  Stream<CardModel> get currentQuestionStream;
  Stream<int> get totalQuestionsStream;
  Stream<int> get totalWrongQuestionsStream;
  Stream<int> get totalCorrectQuestionsStream;
  Stream<String> get correctAnswerStream;
  Stream<int> get remainingChancesStream;

  void getOneQuestion();
  void answerQuestion();
  void getAnotherQuestion();
}
