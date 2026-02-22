import CarPlay
import Foundation

@available(iOS 14.0, *)
public protocol FCPListTemplateItem {
  var text: String? { get }
  var elementId: String { get }
  var get: CPListTemplateItem { get }
  func merge(with other: Self) -> Self
}

@available(iOS 14.0, *)
extension FCPListTemplateItem {
  public func merge(with other: any FCPListTemplateItem) -> any FCPListTemplateItem {
    if let other = other as? Self {
      return self.merge(with: other)
    }
    return other
  }
}
