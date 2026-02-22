import 'package:uuid/uuid.dart';

import '../template.dart';
import 'poi.dart';

/// A template that displays a map with selectable points of interest.
/// https://developer.apple.com/documentation/carplay/cppointofinteresttemplate
/// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
class CPPointOfInterestTemplate implements CPTemplate {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// The scrollable picker’s title.
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  final String title;

  /// The points of interest the template displays on the map and in the scrollable picker.
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  final List<CPPointOfInterest> poi;

  /// A short title that describes the content of the tab.
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  @override
  final String? tabTitle;

  /// An indicator you use to call attention to the tab.
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  @override
  final bool showsTabBadge;

  /// An image that represents the content of the tab.
  /// Note:
  /// - If null, template title will not be display in the tab bar.
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  @override
  final String? systemIcon;

  /// Creates [CPPointOfInterestTemplate]
  CPPointOfInterestTemplate({
    required this.title,
    required this.poi,
    this.tabTitle,
    this.showsTabBadge = false,
    this.systemIcon,
  });

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'title': title,
        'poi': poi.map((e) => e.toJson()).toList(),
        'tabTitle': tabTitle,
        'showsTabBadge': showsTabBadge,
        'systemIcon': systemIcon,
      };

  @override
  String get uniqueId {
    return _elementId;
  }
}
