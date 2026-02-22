import 'package:flutter_carplay/models/alert/alert_action.dart';
import 'package:uuid/uuid.dart';

import '../template.dart';

/// A template that displays a modal action sheet.
/// https://developer.apple.com/documentation/carplay/cpactionsheettemplate
/// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
class CPActionSheetTemplate implements CPTemplate, CPActionsTemplate {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// The title of the action sheet.
  /// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
  final String? title;

  /// The descriptive message providing details about the reason for displaying the action sheet.
  /// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
  final String? message;

  /// The list of actions available on the action sheet.
  /// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
  @override
  final List<CPAlertAction> actions;

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

  /// Creates [CPActionSheetTemplate]
  CPActionSheetTemplate({
    this.title,
    this.message,
    required this.actions,
    this.tabTitle,
    this.showsTabBadge = false,
    this.systemIcon,
  });

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'title': title,
        'message': message,
        'actions': actions.map((e) => e.toJson()).toList(),
        'tabTitle': tabTitle,
        'showsTabBadge': showsTabBadge,
        'systemIcon': systemIcon,
      };

  @override
  String get uniqueId {
    return _elementId;
  }
}
