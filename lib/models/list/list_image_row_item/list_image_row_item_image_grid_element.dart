import 'package:uuid/uuid.dart';

import 'list_image_row_item_constants.dart';
import 'list_image_row_item_element.dart';

/// https://developer.apple.com/documentation/carplay/cplistimagerowitemimagegridelement
/// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
class CPListImageRowItemImageGridElement implements CPListImageRowItemElement {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// The image to display in the card.
  /// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
  @override
  final String image;

  /// The title associated with this element.
  /// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
  String title;

  /// The name of the system symbol image to use as accessory.
  /// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
  String? accessorySymbolName;

  /// Shape used to draw the image of the element.
  /// iOS 26.0+ | iPadOS 26.0+ | Mac Catalyst 26.0+
  final CPListImageRowItemImageGridElementShape imageShape;

  /// Initialize an element that is constituted of an image, title and subtitle.
  /// Only image is required while the two others can be omitted.
  CPListImageRowItemImageGridElement({
    required this.image,
    required this.title,
    this.accessorySymbolName,
    this.imageShape = CPListImageRowItemImageGridElementShape.circular,
  });

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'image': image,
        'title': title,
        'accessorySymbolName': accessorySymbolName,
        'imageShape': imageShape.name,
        'runtimeType': 'FCPListImageRowItemImageGridElement',
      };

  void setTitle(String title) {
    this.title = title;
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
