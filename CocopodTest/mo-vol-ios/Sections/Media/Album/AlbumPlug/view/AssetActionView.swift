//
//  AssetActionView.swift
//  AssetCollectionViewControll和预览控制器底部的功能view
//
//  Created by 许永霖 on 2020/8/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit

let ActionButtonWidth = 70.0
let ActionButtonSpacingToContainer = 12.0 //功能按钮到容器的内边距

enum ActionViewStyle {
    case light //白底黑字
    case dark  //黑底白字
}

class AssetActionView: UIView {
    let previewButton: UIButton = UIButton.init(type: .custom)
    let useOriginalButton: UIButton = UIButton.init(type: .custom)
    let completeButton: UIButton = UIButton.init(type: .custom)
    
    var style: ActionViewStyle = .light
    var useOriginal: Bool = false
    var customBackgroundColor: UIColor {
        if style == .light {
            return .white
        } else {
            return UIColor.init(white: 0, alpha: 0.8)
        }
    }
    var customTitleColor: UIColor {
        if style == .light {
            return .black
        } else {
            return .white
        }

    }
    var customOriginalUnselectedImage: UIImage {
        if style == .light {
            return UIImage(named: "original_unselected", in: PPUtil.frameworkBundle, compatibleWith: nil)!
        } else {
            return UIImage(named: "original_unselected_white", in: PPUtil.frameworkBundle, compatibleWith: nil)!
        }
    }
    var customOriginalSelectedImage: UIImage {
        if style == .light {
            return UIImage(named: "original_selected", in: PPUtil.frameworkBundle, compatibleWith: nil)!
        } else {
            return UIImage(named: "original_selected_white", in: PPUtil.frameworkBundle, compatibleWith: nil)!
        }
    }
    
    var previewAction:(() -> Void)?
    var useOriginalAction: ((Bool) -> Void)?
    var completeAction: (() -> Void)?
    
    init(style: ActionViewStyle = .light) {
        var height = AssetCollectionActionViewHeight
        if PPUtil.hasNotch {
            height += 34.0
        }
        let frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - CGFloat(height), width: UIScreen.main.bounds.size.width, height: CGFloat(height))
        super.init(frame: frame)
        self.frame = frame
        self.style = style
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(0.5)
        var borderColor: UIColor = .gray
        if style == .dark {
            borderColor = .black
        }
        context?.setStrokeColor(borderColor.cgColor)
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: rect.size.width, y: 0))
        context?.strokePath()
    }
    
    func setUp() {
        self.backgroundColor = customBackgroundColor
        //预览
        previewButton.frame = CGRect(x: ActionButtonSpacingToContainer, y: ActionButtonSpacingToContainer, width: ActionButtonWidth, height: AssetCollectionActionViewHeight - ActionButtonSpacingToContainer * 2)
        previewButton.setTitle(NSLocalizedString("album_preview", comment: "预览"), for: .normal)
        previewButton.setTitleColor(customTitleColor, for: .normal)
        previewButton.setTitleColor(.gray, for: .disabled)
        previewButton.contentHorizontalAlignment = .left
        previewButton.isEnabled = false
        previewButton.addTarget(self, action: #selector(previewButtonClicked), for: .touchUpInside)
        self.addSubview(previewButton)
        //使用原图
        useOriginalButton.frame = CGRect(x: 0, y: 0, width: ActionButtonWidth, height: AssetCollectionActionViewHeight - ActionButtonSpacingToContainer * 2)
        useOriginalButton.center = CGPoint(x: self.center.x, y: CGFloat(ActionButtonSpacingToContainer) + useOriginalButton.frame.size.height / 2.0)
        useOriginalButton.setTitle(NSLocalizedString("album_originalPicture", comment: "原图"), for: .normal)
        useOriginalButton.setTitleColor(customTitleColor, for: .normal)
        useOriginalButton.setImage(customOriginalUnselectedImage, for: .normal)
//        useOriginalButton.set
        useOriginalButton.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -2, bottom: 0, right: 2)
        useOriginalButton.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: -2)
        useOriginalButton.addTarget(self, action: #selector(useOriginalButtonClicked), for: .touchUpInside)
        self.addSubview(useOriginalButton)

        //完成
        completeButton.frame = CGRect(x: Double(frame.size.width) - ActionButtonSpacingToContainer - ActionButtonWidth, y: ActionButtonSpacingToContainer, width: ActionButtonWidth, height: AssetCollectionActionViewHeight - ActionButtonSpacingToContainer * 2)
        completeButton.layer.cornerRadius = 5
        completeButton.setTitle(NSLocalizedString("album_complete", comment: "完成"), for: .normal)
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.setTitleColor(.white, for: .disabled)
        completeButton.isEnabled = false
        completeButton.setImage(UIImage(size: 21, color: .white, number: 0), for: .normal)
        completeButton.backgroundColor = UIColor.hexColor("#00CD66")
        completeButton.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -2, bottom: 0, right: 2)
        completeButton.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: -2)
        completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
        self.addSubview(completeButton)
    }
    
//MARK:- event
    @objc func previewButtonClicked(sender: UIButton) {
        previewAction?()
    }
    
    @objc func useOriginalButtonClicked(sender: UIButton) {
        useOriginal = !useOriginal
        if useOriginal {
            useOriginalButton.setImage(customOriginalSelectedImage, for: .normal)
        } else {
            useOriginalButton.setImage(customOriginalUnselectedImage, for: .normal)
        }
        useOriginalAction?(useOriginal)
    }
    
    @objc func completeButtonClicked(sender: UIButton) {
        completeAction?()
    }
    
    /// 更新UI
    /// - Parameter selectedCount: 已选择的图片数量
    func updateUI(useOriginal: Bool, selectedCount: Int) {
        self.useOriginal = useOriginal
        previewButton.isEnabled = (selectedCount > 0)
        if useOriginal {
            useOriginalButton.setImage(customOriginalSelectedImage, for: .normal)
        } else {
            useOriginalButton.setImage(customOriginalUnselectedImage, for: .normal)
        }
        completeButton.isEnabled = (selectedCount > 0)
        completeButton.setImage(UIImage(size: 21, number: selectedCount), for: .normal)
    }
    
    deinit {
        previewAction = nil
        useOriginalAction = nil
        completeAction = nil
    }
    
}
