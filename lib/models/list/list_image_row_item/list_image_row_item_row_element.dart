import 'package:uuid/uuid.dart';

import 'list_image_row_item_element.dart';

/// https://developer.apple.com/documentation/carplay/cplistimagerowitemrowelement
/// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
class CPListImageRowItemRowElement implements CPListImageRowItemElement {
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

  /// Initialize an element that is constituted of an image, title and subtitle.
  /// Only image is required while the two others can be omitted.
  CPListImageRowItemRowElement({
    required this.image,
    this.title,
    this.subtitle,
  });

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'image': image,
        'title': title,
        'subtitle': subtitle,
        'runtimeType': 'FCPListImageRowItemRowElement',
      };

  void setTitle(String title) {
    this.title = title;
    // TODO: trigger update to CarPlay
  }

  void setSubtitle(String subtitle) {
    this.subtitle = subtitle;
    // TODO: trigger update to CarPlay
  }

  @override
  String get uniqueId {
    return _elementId;
  }
}
