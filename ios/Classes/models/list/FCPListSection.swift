//
//  FCPListSection.swift
//  flutter_carplay
//
//  Created by Oğuzhan Atalay on 21.08.2021.
//

import CarPlay

@available(iOS 14.0, *)
class FCPListSection {
  private(set) var _super: CPListSection?
  private(set) var elementId: String
  private var header: String?
  private var items: [CPListTemplateItem]
  private var objcItems: [FCPListTemplateItem]
  private var sectionIndexEnabled: Bool

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
    self.header = obj["header"] as? String
    self.sectionIndexEnabled = obj["sectionIndexEnabled"] as? Bool ?? true
    self.objcItems = (obj["items"] as! [[String: Any]]).map { dict -> FCPListTemplateItem in
      guard let type = dict["runtimeType"] as? String else {
        fatalError("Missing runtimeType in item")
      }

      if type == "FCPListImageRowItem" {
        return FCPListImageRowItem(obj: dict) as FCPListTemplateItem
      } else if type == "FCPListItem" {
        return FCPListItem(obj: dict) as FCPListTemplateItem
      } else {
        fatalError("Unknown item type: \(type)")
      }
    }
    self.items = self.objcItems.map {
      $0.get
    }
  }

  var get: CPListSection {
    let sectionIndexTitle = sectionIndexEnabled ? header : nil

    let listSection = CPListSection.init(
      items: items, header: header, sectionIndexTitle: sectionIndexTitle)

    self._super = listSection
    return listSection
  }

  public func getItems() -> [FCPListTemplateItem] {
    return objcItems
  }

  public func merge(with: FCPListSection) -> FCPListSection {
    let copy = with
    self.updateItems(items: copy.objcItems)
    copy._super = self._super
    copy.objcItems = self.objcItems
    copy.items = self.items
    return copy
  }

  public func updateItems(items: [FCPListTemplateItem]) {
    let fcpListTemplateItem: [String: FCPListTemplateItem] = Dictionary(
      uniqueKeysWithValues: self.objcItems.map { ($0.elementId, $0) })
    let cpListTemplateItem = Dictionary(
      uniqueKeysWithValues: zip(self.objcItems.map { $0.elementId }, self.items))

    /// Keep Flutter CarPlay object if necessary, use new instance.
    self.objcItems = items.map { item in
      if let existing = fcpListTemplateItem[item.elementId] {
        return existing.merge(with: item)  // Merge old instance with newest to keep some data (eg: completeHandler)
      } else {
        return item  // Use new instance
      }
    }
    self.items = items.map { item in
      if let existing = cpListTemplateItem[item.elementId] {
        return existing  // Reuse existing CP template
      } else {
        return item.get  // New CP template
      }
    }
  }
}
