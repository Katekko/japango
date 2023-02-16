class Initializer {
  static final listCharacters = [];
  static void init() {
    final list = List.generate(
      87,
      (index) => String.fromCharCode(index + 12352),
    );

    listCharacters.addAll(list);
  }
}
