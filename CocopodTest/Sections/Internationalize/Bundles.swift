//
//  Bundle.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/11/24.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
/// 首先, 我们会在启动时设置成我们自己的Bundle,这样就可以做到,当使用时会调用这个方法.
class Bundles: Foundation.Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = AppSettings.shared.language.bundle {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        } else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}
