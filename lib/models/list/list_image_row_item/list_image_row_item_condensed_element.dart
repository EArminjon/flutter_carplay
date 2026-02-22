import 'package:uuid/uuid.dart';

import 'list_image_row_item_constants.dart';
import 'list_image_row_item_element.dart';

/// https://developer.apple.com/documentation/carplay/cplistimagerowitemcondensedelement
/// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
class CPListImageRowItemCondensedElement implements CPListImageRowItemElement {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// The image to display in the card.
  /// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
  @override
  final String image;

  /// The title associated with this element.
  /// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
  String title;

  /// The subtitle associated with this element.
  /// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
  String? subtitle;

  /// The name of the system symbol image to use as accessory.
  /// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
  String? accessorySymbolName;

  /// Shape used to draw the image of the element.
  /// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
  final CPListImageRowItemCondensedElementShape imageShape;

  /// Initialize a list image row condensed element with an image, an image shape,
  /// a title, subtitle and a system symbol name.
  CPListImageRowItemCondensedElement({
    required this.image,
    required this.title,
    this.subtitle,
    this.accessorySymbolName,
    this.imageShape = CPListImageRowItemCondensedElementShape.roundedRectangle,
  });

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'image': image,
        'title': title,
        'subtitle': subtitle,
        'accessorySymbolName': accessorySymbolName,
        'imageShape': imageShape.name,
        'runtimeType': 'FCPListImageRowItemCondensedElement',
      };

  void setTitle(String title) {
    this.title = title;
    // TODO: trigger update to CarPlay
  }

  void setSubtitle(String subtitle) {
    this.subtitle = subtitle;
    // TODO: trigger update to CarPlay
  }

  void setAccessorySymbolName(String accessorySymbolName) {
    this.accessorySymbolName = accessorySymbolName;
    // TODO: trigger update to CarPlay
  }

  @override
  String get uniqueId {
    return _elementId;
  }
}
