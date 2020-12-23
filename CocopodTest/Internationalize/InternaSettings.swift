//
//  AppSettings.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/11/23.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
class AppSettings: NSObject{
    fileprivate static let kSharedSettingsKey = "DefaultUserSettings"

    static let shared: AppSettings = {
        let appSettings: AppSettings
        if let savedData = UserDefaults.standard.object(forKey: AppSettings.kSharedSettingsKey) as? Data,
           let defaultSettings = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? AppSettings {
            appSettings = defaultSettings
        } else {
            appSettings = AppSettings()
        }
        
        return appSettings
    }()

    static func saveSharedInstance(){
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: AppSettings.shared, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: AppSettings.kSharedSettingsKey)
        } catch {
            print("archivedData Error")
        }
    }

    enum Language: String {
        /// 请注意, 这个命名不是随意的, 是根据你本地的语言包,可以show in finder 看到. en.lproj / zh-Hans.lproj
        case Chinese = "zh-Hans"
        case English = "en"
        case Tradition = "zh-Hant"
        var code: String {
            return rawValue
        }
    }
    /// 判断手机语言是不是中文
    static func localeIsChinese() -> Bool {
        if let lang = Locale.preferredLanguages.first {
            UserDefaults.standard.setValue(lang as String, forKey: "localLanguage")
            return lang.hasPrefix("zh") ? true : false ;
        } else {
            return false
        }

    }

    var language: Language
    override init() {
        // 第一次初始语言, 看手机是什么语言
        language = AppSettings.localeIsChinese() ? .Chinese : .English
        super.init()
    }

}
private var bundleByLanguageCode: [String: Foundation.Bundle] = [:]
extension AppSettings.Language {
    var bundle: Foundation.Bundle? {
        /// 存起来, 避免一直创建
        if let bundle = bundleByLanguageCode[code] {
            return bundle
        } else {
            let mainBundle = Foundation.Bundle.main
            if let path = mainBundle.path(forResource: code, ofType: "lproj"),
                let bundle = Foundation.Bundle(path: path) {
                bundleByLanguageCode[code] = bundle
                return bundle
            } else {
                return nil
            }
        }
    }
}
