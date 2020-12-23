//
//  RootNavigationViewController.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/8/4.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit

class RootNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.navigationBar.barTintColor =  .gray
    }

    
    override func pushViewController(_ viewController:UIViewController, animated:Bool) {
        if children.count>0{
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

}
