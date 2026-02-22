//
//  FCPListImageRowItem.swift
//  flutter_carplay
//

import CarPlay

@available(iOS 26.0, *)
final class FCPListImageRowItemCardElement {
  private(set) var _super: CPListImageRowItemCardElement?
  private(set) var elementId: String
  private(set) var image: String
  var title: String?
  var subtitle: String?
  var tintColor: UIColor?
  var showsImageFullHeight: Bool

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
    self.image = obj["image"] as! String
    self.title = obj["title"] as? String
    self.subtitle = obj["subtitle"] as? String
    if let colorDict = obj["tintColor"] as? [String: Any],
      let color = UIColor(from: colorDict)
    {
      self.tintColor = color
    }
    self.showsImageFullHeight = obj["showsImageFullHeight"] as! Bool
  }

  var get: CPListImageRowItemElement {
    var listImageRowItemElement = CPListImageRowItemCardElement.init(
      image: makeSafeUIPlaceholder(),
      showsImageFullHeight: showsImageFullHeight,
      title: title,
      subtitle: subtitle,
      tintColor: tintColor,
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

  public func update(args: [String: Any]) {
    // TODO: properties
  }
}

@available(iOS 26.0, *)
extension FCPListImageRowItemCardElement: FCPListImageRowItemElement {}
