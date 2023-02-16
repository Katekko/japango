import 'package:flutter_test/flutter_test.dart';

void main() {
  test('', () {
    final list =
        List.generate(87, (index) => print(String.fromCharCode(index + 12352)));
  });
}
