import 'package:kana_kit/kana_kit.dart';

class CardModel {
  final String char;
  CardModel(this.char);

  bool isCorrect(String answerFromUser) {
    const kanaKit = KanaKit();
    final romanji = kanaKit.toRomaji(char);

    return romanji.toLowerCase() == answerFromUser.toLowerCase();
  }
}
