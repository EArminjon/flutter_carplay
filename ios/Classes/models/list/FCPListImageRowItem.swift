//
//  FCPListImageRowItem.swift
//  flutter_carplay
//

import CarPlay

@available(iOS 14.0, *)
final class FCPListImageRowItem {
  private(set) var _super: CPListImageRowItem?
  private(set) var elementId: String
  private(set) var text: String?
  private var gridImages: [String]?
  private var imageTitles: [String]?
  private var allowsMultipleLines: Bool
  private var isOnPressListenerActive: Bool
  private var isOnItemPressListenerActive: Bool
  private var completeHandler: (() -> Void)?
  private var completeItemHandler: (() -> Void)?
  private var elements: [Any] = []  // Any used for compatibility instead of CPListImageRowItemElement
  private var objcElements: [Any] = []  // Any used for compatibility instead of FCPListImageRowItemElement

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
    self.text = obj["text"] as? String
    self.gridImages = obj["gridImages"] as? [String]
    self.imageTitles = obj["imageTitles"] as? [String]
    self.allowsMultipleLines = obj["allowsMultipleLines"] as? Bool ?? false
    self.isOnPressListenerActive = obj["onPress"] as? Bool ?? false
    self.isOnItemPressListenerActive = obj["onItemPress"] as? Bool ?? false

    if #available(iOS 26.0, *), let elements = obj["elements"] as? [[String: Any]] {
      self.objcElements = elements.map { dict -> FCPListImageRowItemElement in
        guard let type = dict["runtimeType"] as? String else {
          fatalError("Missing runtimeType in item")
        }
        if type == "FCPListImageRowItemCardElement" {
          return FCPListImageRowItemCardElement(obj: dict) as FCPListImageRowItemElement
        } else if type == "FCPListImageRowItemCondensedElement" {
          return FCPListImageRowItemCondensedElement(obj: dict) as FCPListImageRowItemElement
        } else if type == "FCPListImageRowItemGridElement" {
          return FCPListImageRowItemGridElement(obj: dict) as FCPListImageRowItemElement
        } else if type == "FCPListImageRowItemImageGridElement" {
          return FCPListImageRowItemImageGridElement(obj: dict) as FCPListImageRowItemElement
        } else if type == "FCPListImageRowItemRowElement" {
          return FCPListImageRowItemRowElement(obj: dict) as FCPListImageRowItemElement
        } else {
          fatalError("Unknown item type: \(type)")
        }
      }
      self.elements = self.objcElements.compactMap { ($0 as? FCPListImageRowItemElement)?.get }
    }
  }

  private func handler(selectedItem: CPSelectableListItem, complete: @escaping () -> Void) {
    if isOnPressListenerActive {
      completeHandler = complete

      DispatchQueue.main.async {
        FCPStreamHandlerPlugin.sendEvent(
          type: FCPChannelTypes.onListImageRowItemSelected,
          data: ["elementId": self.elementId]
        )
      }
    } else {
      complete()
    }
  }

  private func listImageRowHandler(
    selectedItem: CPSelectableListItem, index: Int, complete: @escaping () -> Void
  ) {
    if isOnItemPressListenerActive {
      completeItemHandler = complete

      DispatchQueue.main.async {
        FCPStreamHandlerPlugin.sendEvent(
          type: FCPChannelTypes.onListImageRowItemElementSelected,
          data: ["elementId": self.elementId, "index": index]
        )
      }
    } else {
      complete()
    }
  }

  var get: CPListTemplateItem {
    var listImageRowItem: CPListImageRowItem
    if #available(iOS 26.0, *), let firstElement = elements.first {
      let runtimeType = type(of: firstElement)

      if runtimeType == CPListImageRowItemCardElement.self {
        let cardElements = elements.compactMap { $0 as? CPListImageRowItemCardElement }
        listImageRowItem = CPListImageRowItem.init(
          text: text ?? "", cardElements: cardElements, allowsMultipleLines: allowsMultipleLines)
      } else if runtimeType == CPListImageRowItemCondensedElement.self {
        let condensedElements = elements.compactMap { $0 as? CPListImageRowItemCondensedElement }
        listImageRowItem = CPListImageRowItem.init(
          text: text ?? "", condensedElements: condensedElements,
          allowsMultipleLines: allowsMultipleLines)
      } else if runtimeType == CPListImageRowItemGridElement.self {
        let gridElements = elements.compactMap { $0 as? CPListImageRowItemGridElement }
        listImageRowItem = CPListImageRowItem.init(
          text: text ?? "", gridElements: gridElements, allowsMultipleLines: allowsMultipleLines)
      } else if runtimeType == CPListImageRowItemImageGridElement.self {
        let imageGridElements = elements.compactMap { $0 as? CPListImageRowItemImageGridElement }
        listImageRowItem = CPListImageRowItem.init(
          text: text ?? "", imageGridElements: imageGridElements,
          allowsMultipleLines: allowsMultipleLines)
      } else if runtimeType == CPListImageRowItemRowElement.self {
        let elements = elements.compactMap { $0 as? CPListImageRowItemRowElement }
        listImageRowItem = CPListImageRowItem.init(
          text: text ?? "", elements: elements, allowsMultipleLines: allowsMultipleLines)
      } else {
        fatalError("Missing runtimeType in item")
      }
    } else {
      let gridImages = self.gridImages ?? []
      let placeholderImages = Array(repeating: makeSafeUIPlaceholder(), count: gridImages.count)
      if #available(iOS 17.4, *), let imageTitles = imageTitles {
        listImageRowItem = CPListImageRowItem.init(
          text: text ?? "", images: placeholderImages, imageTitles: imageTitles)
      } else {
        listImageRowItem = CPListImageRowItem.init(text: text ?? "", images: placeholderImages)
      }

      for (index, imagePath) in gridImages.enumerated() {
        let imageSource = imagePath.toImageSource()
        loadUIImageAsync(from: imageSource) { uiImage in
          if let uiImage = uiImage {
            var currentImages = listImageRowItem.gridImages
            currentImages[index] = uiImage
            listImageRowItem.update(currentImages)
          }
        }
      }
    }

    if isOnPressListenerActive {
      listImageRowItem.handler = self.handler
    }
    if isOnItemPressListenerActive {
      listImageRowItem.listImageRowHandler = self.listImageRowHandler
    }

    self._super = listImageRowItem
    return listImageRowItem
  }

  public func stopHandler() {
    guard self.completeHandler != nil else {
      return
    }
    self.completeHandler!()
    self.completeHandler = nil
  }

  public func stopItemHandler() {
    guard self.completeItemHandler != nil else {
      return
    }
    self.completeItemHandler!()
    self.completeItemHandler = nil
  }

  public func update(args: [String: Any]) {
    let text = args["text"] as? String
    let elements = args["elements"] as? [[String: Any]]

    if let text = text {
      self._super?.text = text
      self.text = text
    }

    if #available(iOS 26.0, *), let elementsData = elements {
      let newObjcElements: [FCPListImageRowItemElement] = elementsData.map { dict in
        guard let type = dict["runtimeType"] as? String else {
          fatalError("Missing runtimeType in item")
        }
        if type == "FCPListImageRowItemCardElement" {
          return FCPListImageRowItemCardElement(obj: dict) as FCPListImageRowItemElement
        } else if type == "FCPListImageRowItemCondensedElement" {
          return FCPListImageRowItemCondensedElement(obj: dict) as FCPListImageRowItemElement
        } else if type == "FCPListImageRowItemGridElement" {
          return FCPListImageRowItemGridElement(obj: dict) as FCPListImageRowItemElement
        } else if type == "FCPListImageRowItemImageGridElement" {
          return FCPListImageRowItemImageGridElement(obj: dict) as FCPListImageRowItemElement
        } else if type == "FCPListImageRowItemRowElement" {
          return FCPListImageRowItemRowElement(obj: dict) as FCPListImageRowItemElement
        } else {
          fatalError("Unknown item type: \(type)")
        }
      }
      let newElements = newObjcElements.map { $0.get }
      self._super?.elements = newElements
      self.objcElements = newObjcElements
      self.elements = newElements
    }
  }

  public func merge(with: FCPListImageRowItem) -> FCPListImageRowItem {
    with._super = self._super
    with._super?.handler = with.handler
    with._super?.listImageRowHandler = with.listImageRowHandler
    return with
  }
}

@available(iOS 14.0, *)
extension FCPListImageRowItem: FCPListTemplateItem {}
