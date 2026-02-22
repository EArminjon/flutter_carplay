import 'package:flutter_carplay/models/grid/grid_button.dart';
import 'package:uuid/uuid.dart';

import '../template.dart';

/// Creates a grid template with a title and a set of buttons.
/// https://developer.apple.com/documentation/carplay/cpgridtemplate
/// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
class CPGridTemplate implements CPTemplate {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// The title shown in the grid template’s navigation bar.
  /// [systemIcon] must be set in order for the title to be displayed in a tab bar.
  /// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
  final String title;

  /// The array of grid buttons displayed on the template.
  /// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
  final List<CPGridButton> buttons;

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

  /// Creates [CPGridTemplate] in order to display a grid of items as buttons.
  /// When creating the grid template, provide an array of [CPGridButton] objects.
  /// Each button must contain a title that is shown in the grid template's navigation bar.
  CPGridTemplate({
    required this.title,
    required this.buttons,
    this.tabTitle,
    this.showsTabBadge = false,
    this.systemIcon,
  });

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'title': title,
        'buttons': buttons.map((e) => e.toJson()).toList(),
        'tabTitle': tabTitle,
        'showsTabBadge': showsTabBadge,
        'systemIcon': systemIcon,
      };

  @override
  String get uniqueId {
    return _elementId;
  }
}
