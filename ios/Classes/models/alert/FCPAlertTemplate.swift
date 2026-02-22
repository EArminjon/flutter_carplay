//
//  FCPAlertTemplate.swift
//  flutter_carplay
//
//  Created by Oğuzhan Atalay on 21.08.2021.
//

import CarPlay

@available(iOS 14.0, *)
class FCPAlertTemplate {
  private(set) var _super: CPAlertTemplate?
  private(set) var elementId: String
  private var titleVariants: [String]
  private var tabTitle: String?
  private var systemIcon: String?
  private var showsTabBadge: Bool = false
  private var actions: [CPAlertAction]
  private var objcActions: [FCPAlertAction]

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
    self.titleVariants = obj["titleVariants"] as! [String]
    self.tabTitle = obj["tabTitle"] as? String
    self.systemIcon = obj["systemIcon"] as? String
    self.showsTabBadge = obj["showsTabBadge"] as! Bool
    self.objcActions = (obj["actions"] as! [[String: Any]]).map {
      FCPAlertAction(obj: $0, type: FCPAlertActionTypes.ALERT)
    }
    self.actions = self.objcActions.map {
      $0.get
    }
  }

  var get: CPAlertTemplate {
    let alertTemplate = CPAlertTemplate.init(titleVariants: titleVariants, actions: actions)
    alertTemplate.tabTitle = tabTitle
    alertTemplate.showsTabBadge = showsTabBadge
    if let systemIcon = systemIcon {
      alertTemplate.tabImage = UIImage(systemName: systemIcon)
    }

    alertTemplate.elementId = self.elementId
    self._super = alertTemplate
    return alertTemplate
  }
}

@available(iOS 14.0, *)
extension FCPAlertTemplate: FCPPresentTemplate {}
