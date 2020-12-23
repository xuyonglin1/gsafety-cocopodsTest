//
//  Path.swift
//  Test
//
//  Created by layne on 2020/9/9.
//  Copyright © 2020 Elite. All rights reserved.
//

import UIKit

class PPUtil {
    static var frameworkBundlePath: String? {
        let bundle = Bundle(for: PPUtil.self)
        return bundle.path(forResource: "PhotoPickerResources", ofType: "bundle")
    }
    static var frameworkBundle: Bundle? {
        if let path = PPUtil.frameworkBundlePath {
            return Bundle(path: path)
        }
        return nil
    }
    // 判断刘海屏
    static var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.windows.filter({$0.isKeyWindow}).first!.safeAreaInsets.bottom > 0.0
        }
        return false
    }
    /// ~/Library/Caches
    public static var CachesPath: String {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        return paths.first!
    }
}

extension UIImage {
    /// 创建数字icon
    convenience init?(size diameter: Int = 25, color: UIColor = UIColor.hexColor("#00CD00")!, number: Int){
        let title = String(number)
        let size = CGSize(width: diameter, height: diameter)
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fillEllipse(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))

        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byCharWrapping
        paragraphStyle.alignment = NSTextAlignment.center

        let textSize = title.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)], context: nil).size
        let rect = CGRect(x: (size.width - textSize.width)/2, y: (size.height - textSize.height)/2, width: textSize.width, height: textSize.height)
        title.draw(in: rect, withAttributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //UIImage的scale是其*缩小因子*而非放大因子，因此这里传入UIScreen.main.scale
        self.init(cgImage: result.cgImage!, scale: UIScreen.main.scale, orientation: .up)

    }
}

extension UILabel {
    /// 为label增加image
    func addImage(image: UIImage?, iconRect: CGRect, at index: Int) {
        guard let icon = image else {
            return
        }
        var attString: NSMutableAttributedString
        if let att = self.attributedText {
            attString = NSMutableAttributedString(attributedString: att)
        } else {
            let text = (self.text == nil) ? "" : self.text!
            attString = NSMutableAttributedString(string: text)
        }
        
        var idx = 0
        if index > attString.length {
            idx = attString.length
        } else if index < 0 {
            idx = 0
        } else {
            idx = index
        }
         
        let attachment = NSTextAttachment()
        attachment.image = icon
        attachment.bounds = iconRect
        let attachmentString = NSAttributedString(attachment: attachment)
        
        attString.insert(attachmentString, at: idx)
        self.attributedText = attString
    }
}
