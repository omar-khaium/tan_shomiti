enum DrawMethod {
  physicalSlips,
  numberedTokens,
  simpleRandomizer,
}

extension DrawMethodStorage on DrawMethod {
  String get value => name;

  static DrawMethod fromValue(String value) {
    return DrawMethod.values.byName(value);
  }
}

