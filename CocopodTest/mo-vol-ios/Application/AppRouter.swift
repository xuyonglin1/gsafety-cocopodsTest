//
//  AppRouter.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/8/4.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation

final class AppRouter {
    
    fileprivate var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    lazy var rootTabVC: UIViewController = {
        
//         MARK: - 原生功能测试列表页面
//        let tabVC1 = RootTabBarController()
        
//         MARK: - 以webview作为启动页
        let tabVC = DSbridgeViewController()
        return tabVC
    }()
    
    func setWindowRootViewController(_ viewController: UIViewController) {
        // 设置导航栏根目录
        if window.rootViewController == nil{
//            window.rootViewController = viewController
            window.rootViewController = UINavigationController(rootViewController: viewController)
            return
        }
//        window.rootViewController = viewController
        window.rootViewController = UINavigationController(rootViewController: viewController)
    }

}
