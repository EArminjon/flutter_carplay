import 'package:flutter_carplay/models/action_sheet/action_sheet_template.dart';
import 'package:flutter_carplay/models/alert/alert_template.dart';
import 'package:flutter_carplay/models/grid/grid_template.dart';
import 'package:flutter_carplay/models/information/information_template.dart';
import 'package:flutter_carplay/models/list/list_template.dart';
import 'package:flutter_carplay/models/poi/poi_template.dart';
import 'package:uuid/uuid.dart';

import '../template.dart';

/// A container template that displays and manages other templates, presenting them as tabs.
/// Supported template types: [CPListTemplate], [CPPointOfInterestTemplate],
/// [CPGridTemplate], [CPInformationTemplate], [CPActionSheetTemplate], [CPAlertTemplate]
/// https://developer.apple.com/documentation/carplay/cptabbartemplate
/// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
class CPTabBarTemplate implements CPTemplate {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// The tab bar’s templates.
  /// Supported types: [CPListTemplate], [CPPointOfInterestTemplate],
  /// [CPGridTemplate], [CPInformationTemplate]
  /// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
  final List<CPTemplate> templates;

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

  /// When creating a [CPTabBarTemplate], provide an array of templates for the tab bar to display.
  /// CarPlay treats the array’s templates as root templates, each with its own
  /// navigation hierarchy. When a tab bar template is the rootTemplate of your
  /// app’s interface controller and you use the controller to add and remove templates,
  /// CarPlay applies those changes to the selected tab’s navigation hierarchy.
  ///
  /// [!] You can’t add a tab bar template to an existing navigation hierarchy,
  /// or present one modally.
  CPTabBarTemplate({
    required List<CPTemplate> templates,
    this.tabTitle,
    this.showsTabBadge = false,
    this.systemIcon,
  }) : templates = List<CPTemplate>.from(templates);

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'tabTitle': tabTitle,
        'templates': templates.map((e) => _templateToJson(e)).toList(),
        'showsTabBadge': showsTabBadge,
        'systemIcon': systemIcon,
      };

  /// Converts a template to JSON with its runtime type identifier.
  Map<String, dynamic> _templateToJson(CPTemplate template) {
    final json = template.toJson();
    if (template is CPListTemplate) {
      json['runtimeType'] = 'FCPListTemplate';
    } else if (template is CPPointOfInterestTemplate) {
      json['runtimeType'] = 'FCPPointOfInterestTemplate';
    } else if (template is CPGridTemplate) {
      json['runtimeType'] = 'FCPGridTemplate';
    } else if (template is CPInformationTemplate) {
      json['runtimeType'] = 'FCPInformationTemplate';
    }
    return json;
  }

  @override
  String get uniqueId {
    return _elementId;
  }

  void updateTemplates(List<CPTemplate> newTemplates) {
    final copy = List<CPTemplate>.from(newTemplates);
    templates
      ..clear()
      ..addAll(copy);
  }
}
