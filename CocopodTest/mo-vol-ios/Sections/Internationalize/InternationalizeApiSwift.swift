//
//  LocalizationApiSwift.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/11/24.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
import UIKit

class InternationalizeApiSwift: UIViewController {

    typealias JSCallback = (Any)->Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   // MARK: - 拨打电话
   // 必须使用"_"忽略第一个参数名
    @objc func changeLanguage( _ arg: Any, handler: @escaping JSCallback){
        // 获取当前设备语言
        let lang: String = UserDefaults.standard.string(forKey: "localLanguage") ?? ""
//        let lang: String = Locale.preferredLanguages.first!
        print(lang)
        if lang.contains("Hant"){
            AppSettings.shared.language = .Chinese   //  .Chinese
            UserDefaults.standard.setValue("zh-Hans-CN", forKey: "localLanguage")
        } else {
            AppSettings.shared.language = .Tradition //  .Chinese
            UserDefaults.standard.setValue("zh-Hant-CN", forKey: "localLanguage")
        }
        resetRootViewController()
        handler(NSLocalizedString("inter_changeSuc", comment: "切换成功"))
    }
    
    func resetRootViewController() {
            if let appdelegate = UIApplication.shared.delegate {
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                if let mainController = storyBoard.instantiateViewController(withIdentifier: "rootViewController") as? UINavigationController {
                    appdelegate.window??.rootViewController = mainController
                }
            }
        }
}


