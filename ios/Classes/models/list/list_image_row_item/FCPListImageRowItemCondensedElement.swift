//
//  FCPListImageRowItem.swift
//  flutter_carplay
//

import CarPlay

@available(iOS 26.0, *)
final class FCPListImageRowItemCondensedElement {
  private(set) var _super: CPListImageRowItemCondensedElement?
  private(set) var elementId: String
  private(set) var image: String
  var imageShape: CPListImageRowItemCondensedElement.Shape
  var title: String
  var subtitle: String?
  var accessorySymbolName: String?

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
    self.image = obj["image"] as! String
    self.title = obj["title"] as! String
    self.subtitle = obj["subtitle"] as? String
    self.imageShape = Self.getImageShape(fromString: obj["imageShape"] as? String)
    self.accessorySymbolName = obj["accessorySymbolName"] as? String
  }

  var get: CPListImageRowItemElement {
    var listImageRowItemElement = CPListImageRowItemCondensedElement.init(
      image: makeSafeUIPlaceholder(),
      imageShape: imageShape,
      title: title,
      subtitle: subtitle,
      accessorySymbolName: accessorySymbolName,
    )

    let imageSource = self.image.toImageSource()
    loadUIImageAsync(from: imageSource) { uiImage in
      if let uiImage = uiImage {
        listImageRowItemElement.image = uiImage
      }
    }

    self._super = listImageRowItemElement
    return listImageRowItemElement
  }

  public static func getImageShape(fromString: String?) -> CPListImageRowItemCondensedElement.Shape
  {
    guard let fromString = fromString else {
      return .circular
    }
    switch fromString {
    case "circular":
      return .circular
    case "roundedRectangle":
      return .roundedRectangle
    default:
      return .circular
    }
  }

  public func update(args: [String: Any]) {
    // TODO: properties
  }
}

@available(iOS 26.0, *)
extension FCPListImageRowItemCondensedElement: FCPListImageRowItemElement {}
