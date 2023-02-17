import 'dart:math';

import 'package:kana_kit/kana_kit.dart';

import '../exceptions/small_character.exception.dart';
import '../models/card.model.dart';

class GetOneQuestionUseCase {
  CardModel call({required List<String> characterList}) {
    const kanaKit = KanaKit();
    final random = Random();
    var element = characterList[random.nextInt(characterList.length)];

    try {
      final romanji = kanaKit.toRomaji(element);
      if (kanaKit.isJapanese(romanji)) {
        throw SmallCharacterException();
      }

      final question = CardModel(element);
      return question;
    } on SmallCharacterException catch (_) {
      characterList.remove(element);
      call(characterList: characterList);
    }

    return CardModel('ERROR');
  }
}
