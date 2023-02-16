import 'package:kana_kit/kana_kit.dart';
import 'package:rxdart/rxdart.dart';

class CardModel {
  final String char;
  final remainingChances = BehaviorSubject<int>.seeded(3);

  CardModel(this.char);

  bool isCorrect(String answerFromUser) {
    const kanaKit = KanaKit();
    final romanji = kanaKit.toRomaji(char);

    return romanji.toLowerCase() == answerFromUser.toLowerCase();
  }
}
