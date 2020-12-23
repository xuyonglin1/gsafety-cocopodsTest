//
//  AssetPreviewTopView.swift
//  预览控制器顶部视图
//
//  Created by 许永霖 on 2020/8/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit

class AssetPreviewTopView: UIView {
    var backButton: UIButton = UIButton.init(type: .custom)
    var statusButton: UIButton = UIButton.init(type: .custom)
    var backAction: (() -> Void)?
    var selectAction: (() -> Int)?
    
    init() {
        var height = 64.0
        if PPUtil.hasNotch {
            height = 88.0
        }
        let frame = CGRect(x: 0.0, y: 0.0, width: Double(UIScreen.main.bounds.size.width), height: height)
        super.init(frame: frame)
        self.frame = frame
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        //返回
        backButton = UIButton.init(type: .custom)
        backButton.setTitle("   ", for: .normal)
        backButton.setImage(UIImage(named: "back_icon_white", in: PPUtil.frameworkBundle, compatibleWith: nil)!, for: .normal)
        backButton.sizeToFit()
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        var frame = backButton.frame
        frame.origin.x = 20
        frame.origin.y = self.frame.size.height - (44.0 - frame.size.height) / 2.0 - frame.size.height
        backButton.frame = frame
        self.addSubview(backButton)
        
        //选择状态
        statusButton = UIButton.init(type: .custom)
        statusButton.setImage(UIImage(named: "unselected_icon", in: PPUtil.frameworkBundle, compatibleWith: nil)!, for: .normal)
        statusButton.addTarget(self, action: #selector(statusButtonClicked), for: .touchUpInside)
        statusButton.contentVerticalAlignment = .top
        statusButton.contentHorizontalAlignment = .right
        frame = statusButton.frame
        frame.size = CGSize(width: 30, height: 30)
        frame.origin.x = self.frame.size.width - 20 - frame.size.width
        frame.origin.y = backButton.frame.origin.y
        
        statusButton.frame = frame
        self.addSubview(statusButton)
    }
    
    func updateData(order: Int){
        if order == AssetCannotSelected {
            statusButton.setImage(UIImage(named: "unselected_icon", in: PPUtil.frameworkBundle, compatibleWith: nil)!, for: .normal)
        } else {
            statusButton.setImage(UIImage(number: order), for: .normal)
        }
    }
    
//MARK:- event
    @objc func backButtonClicked(sender: UIButton) {
        backAction?()
    }
    
    @objc func statusButtonClicked(sender: UIButton) {
        let order = selectAction?()
        if order! == AssetCannotSelected {
            statusButton.setImage(UIImage(named: "unselected_icon", in: PPUtil.frameworkBundle, compatibleWith: nil)!, for: .normal)
        } else {
            statusButton.setImage(UIImage(number: order!), for: .normal)
        }
    }
    
    deinit {
        backAction = nil
        selectAction = nil
    }
    
}
