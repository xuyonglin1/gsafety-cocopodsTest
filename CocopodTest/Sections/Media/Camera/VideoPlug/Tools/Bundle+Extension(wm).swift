//
//  Bundle+Extension.swift
//  WMVideo
//
//  Created by 许永霖 on 2020/8/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit

extension Bundle{
    
    /// get bundle
    ///
    /// - Returns: Bundle
    class func wm_videoBundle() -> Bundle{
        var bundle:Bundle = Bundle.init(for: WMCameraViewController.self)
        let url:URL = bundle.url(forResource: "WMCameraResource", withExtension: "bundle")!
        bundle = Bundle.init(url: url)!
        return bundle
    }
    
    
}
