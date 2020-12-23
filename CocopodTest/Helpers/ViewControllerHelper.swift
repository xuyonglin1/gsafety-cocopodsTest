//
//  ViewControllerHelper.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/8/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
import UIKit

class  ViewControllerHelper: NSObject{
  //获取当前视图所在导航控制器
  public class func getTopMostViewController(base: UIViewController? = UIApplication.shared.windows.last { $0.isKeyWindow }?.rootViewController) -> UIViewController? {
          if let nav = base as? UINavigationController {
              return getTopMostViewController(base: nav.visibleViewController)
          }
          if let tab = base as? UITabBarController {
              if let selected = tab.selectedViewController {
                  return getTopMostViewController(base: selected)
              }
          }
          if let presented = base?.presentedViewController {
              return getTopMostViewController(base: presented)
          }
          return base
      }
}
