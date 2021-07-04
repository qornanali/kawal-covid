class IntegerParser {
  static int parseToIntegerOrZero(String value) {
    if (value.isEmpty) {
      return 0;
    }

    var modifiedValue = value.replaceAll(",", "");
    return int.parse(modifiedValue);
  }
}
