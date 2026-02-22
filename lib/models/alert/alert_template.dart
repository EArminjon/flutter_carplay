import 'package:flutter_carplay/models/alert/alert_action.dart';
import 'package:uuid/uuid.dart';

import '../template.dart';

/// A template that displays a modal alert.
/// https://developer.apple.com/documentation/carplay/cpalerttemplate
/// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
class CPAlertTemplate implements CPTemplate, CPActionsTemplate {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// The array of title variants.
  /// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
  final List<String> titleVariants;

  /// The array of actions available on the alert.
  /// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
  @override
  final List<CPAlertAction> actions;

  /// The closure that CarPlay invokes after the user taps the action button.
  /// Notes:
  /// - If completed is true, the alert successfully presented. If not, you may want to show an error to the user.
  /// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
  final Function(bool completed)? onPresent;

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

  /// Creates [CPAlertTemplate]
  CPAlertTemplate({
    required this.titleVariants,
    required this.actions,
    this.onPresent,
    this.tabTitle,
    this.showsTabBadge = false,
    this.systemIcon,
  });

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'titleVariants': titleVariants,
        'actions': actions.map((e) => e.toJson()).toList(),
        'onPresent': onPresent != null ? true : false,
        'tabTitle': tabTitle,
        'showsTabBadge': showsTabBadge,
        'systemIcon': systemIcon,
      };

  @override
  String get uniqueId {
    return _elementId;
  }
}
