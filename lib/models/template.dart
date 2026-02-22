import 'alert/alert_action.dart';

/// https://developer.apple.com/documentation/carplay/cptemplate
/// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
abstract interface class CPTemplate {
  /// An indicator you use to call attention to the tab.
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  bool get showsTabBadge;

  /// An image that represents the content of the tab.
  /// Note:
  /// - This property is given to tabImage
  /// - If null, template title will not be display in the tab bar.
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  String? get systemIcon;

  /// A short title that describes the content of the tab.
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  String? get tabTitle;

  String get uniqueId;

  Map<String, dynamic> toJson();
}

abstract interface class CPActionsTemplate {
  const CPActionsTemplate();

  List<CPAlertAction> get actions;
}
