//
//  AssetCollectionCell.swift
//  
//
//  Created by 许永霖 on 2020/8/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit

class AssetCollectionCell: UICollectionViewCell {
    var photoView: UIImageView = UIImageView.init()
    var infoLabel: UILabel = UILabel.init() //视频信息
    var blurView: UIView = UIView.init()
    var statusButton: UIButton = UIButton.init(type: .custom)
    var selectAction: (() -> (toSelect: Bool, order: Int))?
    var indexPathRow: Int = -1
    let coverView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.contentMode = .scaleToFill
        view.image = UIImage(contentsOfFile: PPUtil.frameworkBundlePath! + "/placeholder_icon.png")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //缩略图
        photoView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        photoView.contentMode = .scaleAspectFill
        self.contentView.addSubview(photoView)
        
        //视频信息
        infoLabel.frame = CGRect(origin: CGPoint(x: 10, y: frame.size.height - 3 - 20), size: CGSize(width: frame.size.width - 2 * 10, height: 20))
        infoLabel.textColor = .white
        infoLabel.font = UIFont.systemFont(ofSize: 12)
        infoLabel.isHidden = true
        photoView.addSubview(infoLabel)
        
        //蒙版
        blurView.frame = photoView.frame
        blurView.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        blurView.isHidden = true
        self.contentView.addSubview(blurView)
        
        //图片选择状态
        statusButton.setImage(UIImage(named: "unselected_icon", in: PPUtil.frameworkBundle, compatibleWith: nil)!, for: .normal)
        statusButton.contentVerticalAlignment = .top
        statusButton.contentHorizontalAlignment = .right
        statusButton.frame = CGRect(x: frame.width - 40, y: 0, width: 40, height: 40)
        statusButton.addTarget(self, action: #selector(statusButtonClicked), for: .touchUpInside)
        self.contentView.addSubview(statusButton)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeBlur), name: NSNotification.Name.init(rawValue: AssetCollectionCellChangeBlurNotification), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        coverView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.contentView.addSubview(coverView)
        infoLabel.isHidden = true
    }
    
    func setPhoto(photo: UIImage?, isVideo: Bool = false, videoDuration: Double = 0) {
        photoView.image = photo
        if isVideo {
            infoLabel.text = formatTime(seconds: Int(videoDuration))
            infoLabel.addImage(image: UIImage(named: "video_icon", in: PPUtil.frameworkBundle, compatibleWith: nil)!, iconRect: CGRect(x: 0, y: 0, width: 19, height: 10), at: 0)
            infoLabel.isHidden = false
        }
        coverView.removeFromSuperview()
    }
    
    private func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        let minutesStr = minutes < 10 ? "0\(minutes)":"\(minutes)"
        let secsStr = secs < 10 ? "0\(secs)":"\(secs)"
        
        return "  \(minutesStr):\(secsStr)"
    }
    
    func update(order: Int, isBlur: Bool) {
        if order == AssetCannotSelected {
            statusButton.setImage(UIImage(named: "unselected_icon", in: PPUtil.frameworkBundle, compatibleWith: nil)!, for: .normal)
        } else {
            statusButton.setImage(UIImage(number: order), for: .normal)
        }
        blurView.isHidden = !isBlur
    }
    
    @objc func statusButtonClicked(sender: UIButton) {
        if let validation = selectAction?() {
            if validation.toSelect { //未选中->选中
                if validation.order == AssetCannotSelected {
                    statusButton.setImage(UIImage(named: "unselected_icon", in: PPUtil.frameworkBundle, compatibleWith: nil)!, for: .normal)
                } else {
                    statusButton.setImage(UIImage(number: validation.order), for: .normal)
                }
            } else { //选中 -> 未选中
                statusButton.setImage(UIImage(named: "unselected_icon", in: PPUtil.frameworkBundle, compatibleWith: nil)!, for: .normal)
            }
        }
    }
    
    @objc func changeBlur(notification: Notification) {
        if let selectedAssets = notification.object as? Array<Int> {
            blurView.isHidden = selectedAssets.contains(indexPathRow)
        } else {
            blurView.isHidden = true
        }
        
        
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        selectAction = nil
    }

}
