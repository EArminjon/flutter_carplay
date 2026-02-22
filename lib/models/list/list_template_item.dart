/// A description of the common properties of all list item types.
/// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
abstract interface class CPListTemplateItem {
  /// The item’s primary text.
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  String? get text;

  Map<String, dynamic> toJson();

  String get uniqueId;
}
