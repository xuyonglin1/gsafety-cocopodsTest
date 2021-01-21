//
//  UIImage+Extension.swift
//  WMVideo
//
//  Created by 许永霖 on 2020/8/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit

extension UIImage{
    
    /// Get image from WMCameraResource.bundle
    ///
    /// - Parameter imgName: image name
    /// - Returns:  UIImage
    class func wm_imageWithName_WMCameraResource(named imgName:String) -> UIImage?{
        let imgBundle:Bundle = Bundle.wm_videoBundle()
        let name:String = imgName.appending("@2x")
        guard let imgPath = imgBundle.path(forResource: name, ofType: "png") else { return nil }
        let image:UIImage? = UIImage.init(contentsOfFile: imgPath)
        return image
    }
    
    
}
