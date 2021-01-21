//
//  NSObject + Extension.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/8/4.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit

extension NSObject {

    ///获取顶部控制器  .windows.first { $0.isKeyWindow }   keyWindow
    public func topViewController(controller: UIViewController? = UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    ///获取一个对象的str
    public func classNameStr() -> String {
        //let project_cls_name: String = String(describing: self) //返回的是一个对象信息
        let project_cls_name: String = NSStringFromClass(type(of: self))//返回的是一个对象名称字符串
        let range = (project_cls_name as NSString).range(of: ".")
        let cls_name = (project_cls_name as NSString).substring(from: range.location + 1) as String
        return cls_name
    }
    
    ///获取一个对象的str
    var className: String {
            //let project_cls_name: String = String(describing: self) //返回的是一个对象信息
            let project_cls_name: String = NSStringFromClass(type(of: self))//返回的是一个对象名称字符串
            let range = (project_cls_name as NSString).range(of: ".")
            let cls_name = (project_cls_name as NSString).substring(from: range.location + 1) as String
            return cls_name
    }
    
    
    
    
}
