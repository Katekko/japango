import 'dart:math';

String getOneChar() {
  final list = List.generate(
    87,
    (index) => String.fromCharCode(index + 12352),
  );

  final random = Random();
  var element = list[random.nextInt(list.length)];

  return element;
}
