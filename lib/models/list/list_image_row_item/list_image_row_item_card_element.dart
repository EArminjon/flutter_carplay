import 'package:uuid/uuid.dart';

import '../../common/ui_color.dart';
import 'list_image_row_item_element.dart';

/// https://developer.apple.com/documentation/carplay/cplistimagerowitemcardelement
/// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
class CPListImageRowItemCardElement implements CPListImageRowItemElement {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// The image to display in the card.
  /// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
  @override
  final String image;

  /// The title associated with this element.
  /// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
  String? title;

  /// The subtitle associated with this element.
  /// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
  String? subtitle;

  /// A UIColor used to tint the element. When @c showsImageFullHeight is true,
  /// the tint color is applied behind the labels at the bottom of the card.
  /// Otherwise, this color is part of the gradient color at the bottom of the card.
  UIColor? tintColor;

  /// A Boolean value indicating whether the element should be fill with the image.
  /// iOS 14.0–26.0 | iPadOS 14.0–26.0 | Mac Catalyst 14.0–26.0
  final bool showsImageFullHeight;

  /// Initialize a card element with an image.
  CPListImageRowItemCardElement({
    required this.image,
    this.title,
    this.subtitle,
    this.showsImageFullHeight = true,
  });

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'image': image,
        'title': title,
        'subtitle': subtitle,
        'tintColor': tintColor?.toJson(),
        'showsImageFullHeight': showsImageFullHeight,
        'runtimeType': 'FCPListImageRowItemCardElement',
      };

  void setTitle(String title) {
    this.title = title;
    // TODO: trigger update to CarPlay
  }

  void setSubtitle(String subtitle) {
    this.subtitle = subtitle;
    // TODO: trigger update to CarPlay
  }

  void setTintColor(UIColor tintColor) {
    this.tintColor = tintColor;
    // TODO: trigger update to CarPlay
  }

  @override
  String get uniqueId {
    return _elementId;
  }
}
