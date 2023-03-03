import 'package:japango/core/abstractions/field.interface.dart';
import 'package:japango/features/home/domain/usecases/get_one_question.usecase.dart';
import 'package:japango/features/home/presentation/controller/mixins/home_state.mixin.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../initializer.dart';

class HomeController with HomeStateMixin {
  HomeController({
    required IField<String> answer,
    required GetOneQuestionUseCase getOneQuestionUseCase,
  }) {
    this.answer = answer;
    this.getOneQuestionUseCase = getOneQuestionUseCase;
  }

  @override
  void getOneQuestion() {
    final list = Initializer.listCharacters;
    final question = getOneQuestionUseCase(characterList: list);
    currentQuestion.sink.add(question);
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
        final minor = remainingChances.value! - 1;
        remainingChances.sink.add(minor);
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
    answer.clearError();
    getOneQuestion();
  }

  @override
  void dispose() {
    answer.dispose();
    isTheCorrectAnswer.close();
    correctAnswer.close();
  }
}
