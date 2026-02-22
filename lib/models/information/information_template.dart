import 'package:flutter_carplay/models/button/text_button.dart';
import 'package:uuid/uuid.dart';

import '../template.dart';
import 'information_constants.dart';
import 'information_item.dart';

/// A template object that displays and manages information items and text buttons.
/// https://developer.apple.com/documentation/carplay/cpinformationtemplate
/// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
class CPInformationTemplate implements CPTemplate {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// The template’s title.
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  final String title;

  /// The layout that the template uses to arrange its items.
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  final CPInformationTemplateLayout layout;

  /// The actions that the template displays.
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  final List<CPTextButton> actions;

  /// An array of information items that the template displays.
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  final List<CPInformationItem> informationItems;

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

  /// Creates [CPInformationTemplate]
  CPInformationTemplate({
    required this.title,
    required this.layout,
    required this.actions,
    required this.informationItems,
    this.tabTitle,
    this.showsTabBadge = false,
    this.systemIcon,
  });

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'layout': layout.name,
        'title': title,
        'actions': actions.map((e) => e.toJson()).toList(),
        'informationItems': informationItems.map((e) => e.toJson()).toList(),
        'tabTitle': tabTitle,
        'showsTabBadge': showsTabBadge,
        'systemIcon': systemIcon,
      };

  @override
  String get uniqueId {
    return _elementId;
  }
}
