//
//  FCPListImageRowItem.swift
//  flutter_carplay
//

import CarPlay

@available(iOS 26.0, *)
final class FCPListImageRowItemGridElement {
  private(set) var _super: CPListImageRowItemGridElement?
  private(set) var elementId: String
  private(set) var image: String

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
    self.image = obj["image"] as! String
  }

  var get: CPListImageRowItemElement {
    var listImageRowItemElement = CPListImageRowItemGridElement.init(
      image: makeSafeUIPlaceholder(),
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
    if let newImage = args["image"] as? String {
      self.image = newImage
      let imageSource = newImage.toImageSource()
      loadUIImageAsync(from: imageSource) { uiImage in
        if let uiImage = uiImage {
          self._super?.image = uiImage
        }
      }
    }
  }
}

@available(iOS 26.0, *)
extension FCPListImageRowItemGridElement: FCPListImageRowItemElement {}
