class EnumUtils {
  const EnumUtils();

  static T enumFromString<T extends Enum>(Iterable<T> values, String string) {
    return values.firstWhere(
      (T f) => f.name.toUpperCase() == string.toUpperCase(),
    );
  }
}
