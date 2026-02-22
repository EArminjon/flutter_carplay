import 'package:uuid/uuid.dart';

import 'list_image_row_item_element.dart';

/// https://developer.apple.com/documentation/carplay/cplistimagerowitemgridelement
/// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
class CPListImageRowItemGridElement implements CPListImageRowItemElement {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// The image to display in the card.
  /// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
  @override
  final String image;

  /// Initialize an element that is constituted of an image.
  CPListImageRowItemGridElement({
    required this.image,
  });

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'image': image,
        'runtimeType': 'FCPListImageRowItemGridElement',
      };

  @override
  String get uniqueId {
    return _elementId;
  }
}
