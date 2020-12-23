//
//  RootTabBarController.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/8/4.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        creatSubViewControllers()
        
    }
    
    func setupUI(){
        
        let color: UIColor = .green
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : color], for: UIControl.State.selected)
        self.tabBar.barTintColor = .darkGray
    }
    
    func creatSubViewControllers(){
        // Use a UIHostingController as window root view controller.

        let vc1  = HomeViewController ()
        let navc1 = RootNavigationViewController(rootViewController: vc1)
        let item1 : UITabBarItem = UITabBarItem (title: "第一页面", image: UIImage(named: "ic_action_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ic_action_normal")?.withRenderingMode(.alwaysOriginal))
        navc1.tabBarItem = item1
        
        let vc2 = HomeViewController()
        let navc2 = RootNavigationViewController(rootViewController: vc2)
        let item2 : UITabBarItem = UITabBarItem (title: "第二页面", image: UIImage(named: "ic_mechanical_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ic_mechanical_normal")?.withRenderingMode(.alwaysOriginal))
        navc2.tabBarItem = item2

        let vc3 = HomeViewController()
        let navc3 = RootNavigationViewController(rootViewController: vc3)
        let item3 : UITabBarItem = UITabBarItem (title: "第三页面", image: UIImage(named: "ic_letter_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ic_letter_normal")?.withRenderingMode(.alwaysOriginal))
        navc3.tabBarItem = item3

        let tabArray = [navc1, navc2, navc3]
        self.viewControllers = tabArray
    }
}
